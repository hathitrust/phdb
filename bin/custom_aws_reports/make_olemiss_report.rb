require 'phdb/aws_utils'

class MemberMapRunner
  include AWSUtils
  
  # report for OleMiss, 09/24/2012
  def make_olemiss_report(infilen, outfilen)
    total_count = 0
    export_count = 0
    total_miami = total_ufl = total_ht = 0
    f = File.open(infilen, "r")
    outf = File.open(outfilen, "w")
    outf.puts("OCN\tOleMiss\tHathiTrust\n")
    f.each_line { |line|
      total_count += 1
      record = parse_record(line)
      next if record == nil
      next if not record.member_ids.include?('olemiss')
      olemiss_toggle = hathi_toggle = '0'  
      if record.member_ids.include?('olemiss')
        olemiss_toggle = '1'
      end
      if record.member_ids.include?('HATHI')
        hathi_toggle = '1'
      end 
      outstr = "#{record.oclc}\t#{olemiss_toggle}\t#{hathi_toggle}"
      outf.puts(outstr)
      export_count += 1
      puts total_count if total_count % 100000 == 0
    }
    puts "\n#{total_count} lines parsed."
    puts "#{export_count} records exported."
    outf.close
    f.close
  end
  
end

infile = ARGV[0]
outfile = ARGV[1]

mmr = MemberMapRunner.new

mmr.make_olemiss_report(infile, outfile)
puts "done."
