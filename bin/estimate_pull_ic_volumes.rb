require 'phdb/phdb_utils'
#require './MemberReporting.rb'
require 'date'  

if ARGV.length != 1
  puts "Usage: ruby estimator.rb <memberitem_table_name>\n"
  exit
end

date = DateTime.now
datestr = date.strftime("%Y%m%d")

### query to supplement the cost estimation ###
mtable = ARGV[0]
query = "SELECT DISTINCT ho.volume_id FROM holdings_htitem_oclc as ho, 
         holdings_htitem as h, pulintz_ht.#{mtable} as mt
         WHERE ho.oclc = mt.oclc 
         AND h.volume_id = ho.volume_id
         AND h.access = 'deny'"

outfile_name = "#{mtable}-volume_id.#{datestr}.out"
PHDBUtils.pull_query(query, outfile_name)

puts "done."


