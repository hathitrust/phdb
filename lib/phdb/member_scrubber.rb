
require 'date'
require 'iconv'

require 'phdb/phdb_utils'
require 'phdb/enum_chron_parser'


module MemberScrub

  # Stores the information on which data are in which member-submitted columns
  class ColumnMapping
    attr_accessor :oclc, :local_id, :status, :condition, :enum_chron, :issn, :item_id
    
    def initialize( options = {} )
      @oclc = options[:oclc] || 0
      @local_id = options[:local_id] || 1
      @status = options[:status] || nil
      @condition = options[:condition] || nil
      @enum_chron = options[:enum_chron] || nil
      @issn = options[:issn] || nil
      @item_id = options[:item_id] || nil
    end
    
  end

  # Class to accumulate reportable information through a parse.  Allows 
  # additional counts to be easily added, and knows how to print itself.
  class CountReporter
    attr_accessor :total_lines, :short_lines, :long_lines, :bad_oclc, :good_status, 
                  :bad_status, :bad_lines, :output_lines, :condition_items, 
		  :multi_ocn_items, :blank_lines
  
    def initialize( options = {} )
      @total_lines = 0
      @short_lines = 0
      @long_lines = 0
      @bad_oclc = 0
      @good_status = 0
      @bad_status = 0
      @bad_lines = 0
      @output_lines = 0
      @condition_items = 0
      @multi_ocn_items = 0
      @blank_lines = 0
    end
    
    def to_s()
      puts "\n"
      self.instance_variables.each do |var|
        puts "#{var} = #{self.instance_variable_get(var)}"
      end
    end
    
  end

  
  # Main parser module.  
  class MemberScrubber 
    attr_accessor :member_id, :mapper, :data_type, :delim, :min_cols, :header_lines, :long_lines
    
    @@MAX_OCN =  870000000
    @@VERBOSE = false
    @@REPORT_MULTIS = true 
    
    def initialize( options = {} )
      @member_id = options[:member_id]
      @mapper = options[:mapper]
      @data_type = options[:data_type] || 'mono'
      @delim = options[:delim] || "\t"
      @min_cols = options[:min_cols] || 2
      @header_lines = options[:header_lines] || 0
      @long_lines = options[:long_lines] || 9
    end
    
    def current_date()
      Date.today.to_s
    end
    
    def clean_line(untrusted_string)
      ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
      valid_string = ic.iconv(untrusted_string + ' ')[0..-2]
    end
    
    def choose_ocn_using_db(ocnline, delim)
      # pick the first matching OCN, or default to the first entry if none found
      conn = PHDBUtils.get_dev_conn()
      bits = ocnline.split(delim)
      bits.each do |bit|
        bi = bit.to_i
        next if bi == 0
        row = conn.query("select count(*) from holdings_htitem_oclc where oclc = #{bi}")
        result = row.uniq[0]
        count = result[0]  # grab the first term too
        if (count.to_i > 0)
          conn.close()
          return [bit, 'match']
        end
      end
      return [bits[0], 'no match']
    end
    
    
    def parse_multiple(ocnline, delim=';')
      # deprecated
      bits = ocnline.split(delim)
      max = 0
      bits.each do |bit|
        if bit.to_i > max
          max = bit.to_i
        end
      end
      return max
    end
    
    # A bit different than the 'parse_oclc' routine in phdb_utils. 
    # Handles several user-specific things.
    def parse_oclc(ocn, reporter)
      return 0 if ocn.nil?
      return 0 if ocn.empty?
      ocnp = ocn.strip.gsub(/\(OCoLC\)/, '')
      ocnp.gsub!(/ocl7/i, '')
      ocnp.gsub!(/oc[nm]/i, '')
      ocnp.gsub!(/oclc/i, '')
      ocnp.gsub!(/\\a/, '')
      multi_toggle = false
      hit_toggle = 'no match'
      if ocnp =~ /;/
        reporter.multi_ocn_items += 1
        multi_toggle = true
        ocnp, hit_toggle = choose_ocn_using_db(ocnp, ";")
      elsif ocnp =~ /\,/
        ocnp.gsub!(/\s/, ',')
        reporter.multi_ocn_items += 1
        multi_toggle = true
        ocnp, hit_toggle = choose_ocn_using_db(ocnp, ",")
      elsif ocnp =~ /\s/
        reporter.multi_ocn_items += 1
        multi_toggle = true
        ocnp, hit_toggle = choose_ocn_using_db(ocnp, "\s")
      elsif ocnp =~ /\\z/
        reporter.multi_ocn_items += 1
        multi_toggle = true
        ocnp, hit_toggle = choose_ocn_using_db(ocnp, '\z')
      end 
      if multi_toggle and @@REPORT_MULTIS
        puts "Multi OCLC: '#{ocn}'->'#{ocnp}' (#{hit_toggle})"
      end
      if (ocnp =~ /\D/)
        if @@VERBOSE
          puts "Adjusting '#{ocn}'->'#{ocnq}'->'#{ocni}'"
        end
        ocnp = ocnp.gsub(/\D/, '')
      end
      ocni = ocnp.to_i      
    end
    
    def test_oclc(ocn)
      if (ocn.is_a?(Integer))
        ((ocn < @@MAX_OCN) && (ocn > 0)) ? true : false
      else
        return false
      end
    end
     
    def test_status(status)
      status_list = ["CH", "LM", "WD", "", nil, "ch", "lm", "wd"]
      return true if status == nil
      if status_list.include?(status.strip) 
        return true
      else
        return false
      end
    end
    
    def test_condition(condition)
      condition_list = ["BRT", "DAMAGED"]
      if condition_list.include?(condition) 
        return true
      else
        return false
      end
    end
    
    def test_type(itype)
      itype_list = ["mono", "serial", "multi"]
      if itype_list.include?(itype) 
        return true
      else
        return false
      end
    end
    
    def parse_issn(issn)
      if issn and issn.length > 40
        bits = issn.split(';')
        issn = bits[0]
          if issn.length > 40
            issn = ''
          end
      end
      #if issn =~ /\-/
      #  issn.gsub!(/[\-]/, '')
      #end
      return issn
    end
    
    def replace_type_in_outline(outl, type)
      bits = outl.strip.split("\t")
      bits.map{ |item| item.gsub!(/\"/, '') }
      bits[7] = type
      return bits.join("\t")
    end
            
    def process_data (infilen, outfilen)
      outf = File.open(outfilen, 'w')
      outf.puts("OCN\tBIB\tMEMBER_ID\tSTATUS\tCONDITION\tDATE\tENUM_CHRON\tTYPE\tISSN\tN_ENUM\tN_CHRON\n")
      reporter = CountReporter.new
      ecparser = EnumChronParser.new  
      File.open(infilen, 'r') do |file|
        # skip header lines
        i = 0
        if (i < @header_lines)
          hline = file.readline
          i += 1
        end
        last_bib = nil
        last_line = nil
        in_multi = 0
        # loop over data lines
        file.each do |line|
          reporter.total_lines += 1
          # handle invalid encoding
          unless line.valid_encoding?
            #puts "Invalid line encoding: '#{line.strip}'"
            newline = line.force_encoding("ISO-8859-1").encode("UTF-8")
            #puts "Fix Attempt->'#{newline.strip}'"
            if newline.valid_encoding?
              line = newline
            else
              puts "\tFix fail... skipping."
              reporter.bad_lines += 1
              next
            end
          end
          bits = line.rstrip.split(@delim)
          bits.map{ |item| item.gsub!(/\"/, '') }
	  if bits.length < 1
	    reporter.blank_lines += 1
	    next
	  end
          unless bits.length >= @min_cols
            puts "Short Line: '#{line.strip}'"
            reporter.short_lines += 1
            next
          end
          if bits.length >= @long_lines
            puts "Long Line: '#{line.strip}'"
            reporter.long_lines += 1
          end
          ## handle required fields (oclc, local_id)
          rawocn = bits[@mapper.oclc]
          ocn = parse_oclc(rawocn, reporter)
          unless test_oclc(ocn)
            puts "Bad OCLC: (#{ocn}) '#{line.strip}'"
            reporter.bad_oclc += 1
            next
          end
          bib = bits[@mapper.local_id]
          ## handle optional fields
          status = ''
          condition = ''
          enum_chron = ''
          n_enum = ''
          n_chron = ''
          issn = ''
          type = @data_type
          if (@mapper.status)
            status = bits[@mapper.status].strip
            if status =~ /LLMLM/
              status.gsub!(/LLMLM/i, 'LM')    # mistake in arizona
            elsif status =~ /LLM/
              status.gsub!(/LLM/i, 'LM')
            end
            if test_status(status)
              reporter.good_status += 1
            else
              puts "Bad Status: (#{status}) '#{line.strip}'"
              reporter.bad_status += 1
              status = ''
            end
          end
          if (@mapper.condition)
            condition = bits[@mapper.condition].strip
            if test_condition(condition)
              reporter.condition_items += 1
            end
          end
          if (@mapper.enum_chron)
            enum_chron = bits[@mapper.enum_chron]
            unless (enum_chron.nil?)
              enum_chron = enum_chron.gsub("\t", ' ')
              enum_chron = enum_chron.gsub(/None/i, '') 
	      enum_chron = enum_chron.gsub(/NULL/i, '')
              enum_chron = enum_chron.gsub(/\?/, '') 
	      # "c.1" intervention
	      enum_chron = enum_chron.gsub(/c\.1$/, '')
	      enum_chron = enum_chron.gsub(/c\. 1$/, '')
              ecparser.parse(enum_chron)
              if ecparser.enum_str.length > 0
                n_enum = ecparser.normalized_enum.strip
              end
              if ecparser.chron_str.length > 0
                n_chron = ecparser.normalized_chron.strip
              end
            end
          end
          if (@mapper.issn)
            issn_raw = bits[@mapper.issn]
            issn = parse_issn(issn_raw)
          end
          # tricky bit to handle 'multi' status in monos - only used when item_ids are present
          if (@mapper.item_id)
            item_id = bits[@mapper.item_id]
            if (last_bib && (bib == last_bib))
              new_last_line = replace_type_in_outline(last_line, 'multi')
              outf.puts(new_last_line)
              reporter.output_lines += 1
              in_multi = 1
            else
              if (last_line && (in_multi==1))
                new_last_line = replace_type_in_outline(last_line, 'multi')
                outf.puts(new_last_line)
                reporter.output_lines += 1
                in_multi = 0
              else
                if last_line
                  outf.puts(last_line)
                  reporter.output_lines += 1
                end
              end
            end
            outstr = "#{ocn}\t#{item_id}\t#{@member_id}\t#{status}\t#{condition}\t#{current_date}\t#{enum_chron}\t#{type.strip}\t#{issn}\t#{n_enum}\t#{n_chron}"
            last_bib = bib
            last_line = outstr
            #puts(outstr)
          else
            reporter.output_lines += 1
            outstr = "#{ocn}\t#{bib}\t#{@member_id}\t#{status}\t#{condition}\t#{current_date}\t#{enum_chron}\t#{type.strip}\t#{issn}\t#{n_enum}\t#{n_chron}"
            last_line = outstr
            #puts(outstr)
            outf.puts(outstr)
          end
        end
        # last line
        outf.puts(last_line)
      end
      outf.close()
      reporter.to_s
    end
    
  end
  
   
end 
