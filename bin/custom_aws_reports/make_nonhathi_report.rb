equire 'membermap_parser.rb'

class MemberMapRunner
  include AWSUtils
  
  # report to calculate HCounts for items that don't match HT
  def make_nonHT_report(infilen, outfilen)
    total_count = 0
    export_count = 0
    f = File.open(infilen, "r")
    outf = File.open(outfilen, "w")
    outf.puts("OCN\tH\tMembers\tTypes\n")
    f.each_line { |line|
      total_count += 1
      puts total_count if total_count % 1000000 == 0
      record = parse_record(line)
      next if record == nil
      next if record.member_ids.include?('HATHI')
      h = record.member_ids.length
      outstr = "#{record.oclc}\t#{h}\t#{record.member_ids}\t#{record.types}"
      outf.puts(outstr)
      export_count += 1
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

mmr.make_nonHT_report(infile, outfile)
puts "done."