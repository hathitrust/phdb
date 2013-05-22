require 'phdb/aws_utils'

class MemberMapRunner
  include AWSUtils
  
  # report for UConn, 10/23/2012
  # organizes by volume_id the entries that are in HT but with no California mapping
  def make_uconn_report(infilen, outfilen)
    total_count = 0
    export_count = 0
    oclc_count = 0
    f = File.open(infilen, "r")
    outf = File.open(outfilen, "w")
    outf.puts("LocalID\tOCLC\tType\n")
    f.each_line { |line|
      total_count += 1
      puts total_count if total_count % 100000 == 0
      record = parse_record(line)
      next if record == nil
      if not record.member_ids.class == Array
        puts "Problem: record.member_ids class = '#{record.member_ids.class}'"
        next
      end
      rlen = record.member_ids.length
      next unless ((rlen = 1) and (record.member_ids.include?('uconn')))  
      oclc_count += 1
      record.local_ids.each do |lid|
        pretty_types = record.types.join(',')
        outstr = "#{lid}\t#{record.oclc}\t#{pretty_types}"  
        outf.puts(outstr)
        export_count += 1
      end
    }
    puts "\n#{total_count} lines parsed."
    puts "#{oclc_count} distinct OCLC numbers exported."
    puts "#{export_count} records exported."
    outf.close
    f.close
  end
  
  # Overlap report.  This is the "1 or 0" report style  
  def make_uconn_overlap_report(infilen, outfilen)
    memberlist = ['uconn']
    total_count = 0
    export_count = 0
    total_uconn = total_ht = 0
    f = File.open(infilen, "r")
    outf = File.open(outfilen, "w")
    outf.puts("OCN\tUConn\tHathiTrust\n")
    f.each_line { |line|
      total_count += 1
      record = parse_record(line)
      next if record == nil
      raise "[pull_memberlist] 'member_ids' must be an Array" unless record.member_ids.kind_of? Array
      next unless record.member_ids.include?('uconn')
      total_uconn += 1
      hathi_toggle = '0'
      if record.member_ids.include?('HATHI')
        hathi_toggle = '1'
        total_ht += 1
      end
      outstr = "#{record.oclc}\t1\t#{hathi_toggle}"
      outf.puts(outstr)
      export_count += 1
      puts total_count if total_count % 100000 == 0
    }
    puts "\n#{total_count} lines parsed."
    puts "#{export_count} records exported."
    puts "UConn items: #{total_uconn}"
    puts "Hathi items: #{total_ht}"
    outf.close
    f.close
  end
  
end

infile = ARGV[0]
outfile = ARGV[1]

mmr = MemberMapRunner.new

#mmr.make_uconn_report(infile, outfile)
mmr.make_uconn_overlap_report(infile, outfile)
puts "done."
