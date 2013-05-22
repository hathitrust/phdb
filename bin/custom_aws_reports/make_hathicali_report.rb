require 'phdb/aws_utils'

class MemberMapRunner
  include AWSUtils
  
  # report for HathiCali, 10/10/2012
  # organizes by volume_id the entries that are in HT but with no California mapping
  def make_hathicali_report(infilen, outfilen)
    total_count = 0
    export_count = 0
    f = File.open(infilen, "r")
    outf = File.open(outfilen, "w")
    outf.puts("VolumeID\tOCLC\tType(s)\n")
    f.each_line { |line|
      total_count += 1
      puts total_count if total_count % 100000 == 0
      record = parse_record(line)
      next if record == nil
      record.local_ids.each do |lid|
        pretty_types = record.types.join(',')
        outstr = "#{lid}\t#{record.oclc}\t#{pretty_types}"  
        outf.puts(outstr)
        export_count += 1
      end
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

mmr.make_hathicali_report(infile, outfile)
puts "done."
