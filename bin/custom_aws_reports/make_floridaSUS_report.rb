require 'phdb/aws_utils'
require 'set'

class MemberMapRunner
  include AWSUtils
  
  def calc_bump1(ml) 
    if ((ml.include? 'fsu') and (ml.include? 'ufl'))
      return -1
    elsif ((ml.include? 'ufl') and (ml.include? 'sus'))
      return 0
    elsif ((ml.include? 'fsu') and (ml.include? 'sus'))
      return 0
    elsif ((ml.include? 'sus'))
      return 1
    else
      return 0
    end
  end


  def calc_bump2(ml)
    ht = ml.delete("HATHI")
    return false if not ht
    h = case ml
        when ["fsu", "miami", "sus", "ufl"] then -2
        when ["fsu", "sus", "ufl"] then -1
        when ["fsu", "miami", "sus"] then -1
        when ["miami", "sus", "ufl"] then -1
        when ["fsu", "miami", "ufl"] then -2
        when ["fsu", "sus"] then 0
        when ["miami", "ufl"] then -1
        when ["fsu", "miami"] then -1
        when ["fsu", "ufl"] then -1
        when ["miami", "sus"] then 0
        when ["sus", "ufl"] then 0
        when ["sus"] then 1
        when ["miami"] then 0
        when ["ufl"] then 0
        when ["fsu"] then 0
        else false
    end
    return h
  end
 

  # report for FloridaSUS
  # Need a report with OCLC number and the "bump" number that will be 
  # necessary for the cost calculation.
  def make_flasus_report(infilen, outfilen)
    total_count = 0
    export_count = 0
    nullchar = '\N'
    f = File.open(infilen, "r")
    outf = File.open(outfilen, "w")
    outf.puts("OCLC\tBump\n")
    f.each_line do |line|
      total_count += 1
      puts total_count if total_count % 100000 == 0
      record = parse_record(line)
      next if record == nil
      next if ((record.member_ids.length == 1) and (record.member_ids.include? 'HATHI'))
      bump = calc_bump2(record.member_ids)
      if bump
        outstr = "#{record.oclc}\t#{bump}"
      else
        outstr = "#{record.oclc}\t#{nullchar}"
      end
      outf.puts(outstr)
      export_count += 1
    end
    puts "\n#{total_count} lines parsed."
    puts "#{export_count} records exported."
    outf.close
    f.close
  end
  
end

infile = ARGV[0]
outfile = ARGV[1]

mmr = MemberMapRunner.new

mmr.make_flasus_report(infile, outfile)
puts "done."
