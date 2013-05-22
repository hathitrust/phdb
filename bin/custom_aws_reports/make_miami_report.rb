require 'phdb/aws_utils'

class MemberMapRunner
  include AWSUtils
  
  # SERIALS report for Miami
  def make_miami_report(infilen, outfilen)
    memberlist = ['miami', 'ufl']
    total_count = 0
    export_count = 0
    total_miami = total_ufl = total_ht = 0
    f = File.open(infilen, "r")
    outf = File.open(outfilen, "w")
    outf.puts("OCN\tUMiami\tUFlorida\tHathiTrust\n")
    f.each_line { |line|
      record = parse_record(line)
      next if record == nil
      raise "[pull_memberlist] 'memberlist' must be an Array" unless memberlist.kind_of? Array
      next unless record.types.include?('serial')
      intersection = memberlist & record.member_ids
      if intersection.length > 0
        miami_toggle = ufl_toggle = hathi_toggle = '0'
        if record.member_ids.include?('miami')
          miami_toggle = '1'
        elsif record.member_ids.include?('ufl')
          ufl_toggle = '1'
        elsif record.member_ids.include?('HATHI')
          hathi_toggle = '1'
        end
        outstr = "#{record.oclc}\t#{miami_toggle}\t#{ufl_toggle}\t#{hathi_toggle}"
      outf.puts(outstr)
      export_count += 1
      end
      total_count += 1
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

mmr.make_miami_report(infile, outfile)
puts "done."
