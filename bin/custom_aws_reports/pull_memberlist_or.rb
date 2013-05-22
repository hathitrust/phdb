require 'phdb/aws_utils'

class MemberMapRunner
  include AWSUtils
end


# exports records matching *any* of the member_ids in the provided memberlist
def pull_memberlist_or(infilen, outfilen, memberlist)
  total_count = 0
  export_count = 0
  f = File.open(infilen, "r")
  outf = File.open(outfilen, "w")
  outf.puts("OCN\tMEMBER_IDS\tLOCAL_IDS\tTYPES\n")
  f.each_line { |line|
    record = parse_record(line)
    next if record == nil
    raise "[pull_memberlist] 'memberlist' must be an Array" unless memberlist.kind_of? Array
    intersection = memberlist & record.member_ids
    if intersection.length > 0
    outf.puts(record.to_s)
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


infile = ARGV[0]
outfile = ARGV[1]

members = ['columbia', 'uom']
mmr = MemberMapRunner.new
mmr.pull_memberlist_or(infile, outfile, members)
puts "done."
