require 'rubygems'
require 'java'
require 'jdbc-helper'
#require 'mysql-connector-java-5.1.17-bin.jar'
require 'set'

jars_dir = File.join(File.dirname(__FILE__), '../java')
for jar in Dir["#{jars_dir}/*.jar"]
  require jar
end

module OCLCUtils
  
  # This routine transforms a row such as:
  #       158:158 | 3712335 | 232967609 | 504562466
  #   into tab-delimited rows:
  #       3712335     158
  #       232967609   158
  #       504562466   158
  def inverse_oclc_data(datafn, outfn)
    dataf = File.new(datafn, "r")
    outf = File.open(outfn, 'w')
    row_count = 0
    written_count = 0
    while (line = dataf.gets)
      row_count += 1
      bits = line.chomp.split(':')
      ocn0 = bits[0]
      ocns = bits[1].split(' | ')
      ocns.shift      # shift off the starting ocn
      ocns.each do |ocn|
        outstr = "#{ocn}\t#{ocn0}"
        outf.puts(outstr)
        written_count += 1
      end
      
      if ((row_count % 1000000) == 0)
        puts "#{row_count}..."
      end
    end
    
    puts "[OCLCUtils] #{row_count} rows parsed."
    puts "[OCLCUtils] #{written_count} rows exported."
    outf.close
    dataf.close
  end
  
  
  
  def prune_OCLC_resolution_data(datafn, outfn)  
    # only retain lines with HT oclc numbers
    file = File.new(datafn, "r")
    outf = File.open(outfn, 'w')

    # get a connection
    conn = get_dev_conn()
    
    # get oclc hash
    oclc_h = {}
    o_rows = conn.query("select distinct(oclc) from htitem_oclc;")
    o_rows.each do |o|
      oclc_h[o[0]] = 1
    end
    
    puts "Sanity check: #{oclc_h.length} oclcs."

    count = 0
    while (line = file.gets)
      count += 1
      bits = line.chomp.split(':')
      ocn0 = bits[0]
      ocns = bits[1].split(' | ')
      ocns.each do |ocn|
        if oclc_h.has_key?(ocn.to_i)
          outf.puts line
        end
      end  
      
      if ((count % 10000) == 0)
        puts "#{count}..."
      end
    end
    file.close
    outf.close
    conn.close
  end
  
  
  ## Creates an additional htitem_oclc file 
  def add_OCLC_resolution_data_to_htitem_oclc(datafn, outfn)  
    file = File.new(datafn, "r")
    outf = File.open(outfn, 'w')

    # get a connection
    conn = get_dev_conn()
    
    # get oclc hash
    #oclc_h = {}
    #o_rows = conn.query("select distinct(oclc) from htitem_oclc;")
    #o_rows.each do |o|
    #  oclc_h[o[0]] = 1
    #end
    
    #puts "Sanity check: #{oclc_h.length} oclcs."

    count = 0
    while (line = file.gets)
      count += 1
      bits = line.chomp.split(':')
      ocn0 = bits[0]
      ocns = bits[1].split(' | ')
      # get all vol_ids associated with these ocns
      vol_ids = Set.new
      ocns.each do |ocn|
        vid_rows = conn.query("select volume_id from htitem_oclc where oclc = #{ocn};")
        vid_rows.each do |vrow|
          #vol_ids << vrow
          vol_ids.add(vrow)       
        end
      end  
      # insert vol-oclc pairs
      vol_ids.each do |vid|
        ocns.each do |oc|
          outf.puts "#{vid}\t#{oc}\t1"
        end
      end
      
      if ((count % 10000) == 0)
        puts "#{count}..."
      end
    end
    file.close
    outf.close
    conn.close
  end
  
  
  def cleanup_OCLC_resolution_data(datafn, outfn)  
    dfile = File.new(datafn, "r")
    outf = File.open(outfn, 'w')

    count = 0
    while (line = dfile.gets)
      count += 1
      bits = line.chomp.split(':')
      ocn0 = bits[0]
      ocns = bits[1].split(' | ')
      ocns.each do |ocn|
        if oclc_h.has_key?(ocn.to_i)
          outf.puts line
        end
      end  
      
      if ((count % 10000) == 0)
        puts "#{count}..."
      end
    end
    file.close
    outf.close
    conn.close
  end
  
  
end
