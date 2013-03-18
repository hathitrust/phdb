
# encoding: UTF-8

require 'phdb/enum_chron_parser'

def get_reasons()
  reasons = %w(bib ncn con ddd man pvt ren nfi cdpp cip unp gfv crms 
               add ddd exp udp orphcand del gatt ipma)
end

def generate_htitem_table(infilen, outfilen, serialsfn)
  f = File.open(infilen, "r")
  s = File.open(serialsfn, "r")
  errorfn = "#{outfilen}.err"
  e = File.open(errorfn, "w")
  outf = File.open(outfilen, "w")
  
  # parse serials file to get record nums
  umrecords = Hash.new
  s.each_line do |sline|
    bits = sline.split("\t")
    next unless bits.length > 0
    um_id_i = bits[0].to_i
    if um_id_i == 0 
      puts "Problem with serials line '#{sline}'"
      next
    end
    umrecords[um_id_i] = true
  end
  s.close
  
  # parse the flatfile
  ecparser = EnumChronParser.new
  reasons = get_reasons()
  puts "processing HathiTrust flatfile..."
  line_count = 0
  out_count = 0
  serial_count = 0
  multi_count = 0
  f.each_line do |line|
    line_count += 1
    if ((line_count % 1000000) == 0)
      puts "#{line_count}..."
    end
    enum_chron = ''
    n_enum = ''
    n_chron = ''
    bits = line.split("\t")
    if bits.length < 15
      puts "Line too short: '#{line}'"
      e.puts(line)
      next
    end
    bits.map{ |item| item.strip }
    um_id = bits[3].to_i
    reason = bits[13]
    enum_chron = bits[4]
    itype = 'mono'
    if umrecords.include?(um_id)
      itype = 'serial'
      serial_count += 1
    end
    if not reasons.include?(reason)
      puts "Bad Reason Code (#{reason}).  Line '#{line.strip}'"
    end
    if enum_chron.length > 0
      enum_chron = enum_chron.gsub("\t", ' ')
      enum_chron = enum_chron.gsub /None/i, '' 
      enum_chron = enum_chron.gsub /\?/, '' 
      ecparser.parse(enum_chron)
      if ecparser.enum_str.length > 0
        n_enum = ecparser.normalized_enum.strip
      end
      if ecparser.chron_str.length > 0
        n_chron = ecparser.normalized_chron.strip
      end
    end
    if (itype == 'mono' and n_enum.length > 0)
      itype = 'multi'
      multi_count += 1
    end
    outline = "#{bits[0]}\t#{bits[1]}\t#{bits[2]}\t#{bits[3]}\t#{bits[4]}\t#{bits[5]}\t#{bits[6]}\t#{bits[7]}\t#{bits[13]}\t#{bits[14]}\t#{itype}\t0\t#{n_enum}\t#{n_chron}\t#{bits[15]}\t#{bits[16]}\t#{bits[17]}\t#{bits[18]}\t#{bits[19]}"
    out_count += 1
    outf.puts(outline)
  end
  
  puts "#{line_count} lines processed."
  puts "#{out_count} lines exported."
  puts "#{serial_count} serials."
  puts "#{multi_count} multis."
  outf.close
  f.close
  e.close
end



if ARGV.length != 3
  puts "Usage: ruby maketable_htitem_from_file.rb <infile> <outfile> <serialfile>\n"
end
generate_htitem_table(ARGV[0], ARGV[1], ARGV[2])
