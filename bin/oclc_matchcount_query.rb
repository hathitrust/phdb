
require 'phdb/phdb_utils'
require 'date'

def put_oclc_counts(outfn)
  conn = PHDBUtils.get_dev_conn()
  outf = File.open(outfn, 'w')

  members = PHDBUtils.get_active_member_list()
  puts "#{members.length} members."

  smembers = members.sort
  smembers.each do |mem|
    q1 = "select count(distinct ho.oclc) from holdings_memberitem as hm, holdings_htitem_oclc as ho 
          where ho.oclc = hm.oclc and member_id = '#{mem}'"
    row = conn.query(q1)
    result = row.uniq[0]
    cell = result[0]   # first row in result array                                                             
    out_str = "#{mem}\t#{cell}"
    puts out_str
    outf.puts(out_str)
  end
  conn.close
  outf.close
end


def main()
  date = DateTime.now
  datestr = date.strftime("%Y%m%d")
  name = "oclc-countreport.#{datestr}.out"
  puts "Generating #{name}..."
  put_oclc_counts(name)
end



main()
