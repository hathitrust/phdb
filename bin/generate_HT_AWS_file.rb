require 'phdb/phdb_utils'


# The purpose of this routine is to generate the HathiTrust equivalent
#   of one of the memberitem flatfiles, so that HT data can be treated
#   the same as member data for the purpose of the AWS hadoop calculations.
def generate_HT_AWS_file(outfn)
  
  conn = PHDBUtils.get_dev_conn()
  conn.fetch_size=50000
  count = 0

  outf = File.open(outfn, 'w')
  # get oclc hash
  oclc_h = {}

  query = "select ho.oclc, ho.volume_id, item_type
               from htitem_oclc as ho, htitem as h
               where h.volume_id = ho.volume_id"
  conn.enumerate(query).each_slice(50000) do |slice|
    slice.each do |row|
      count += 1
      ocn = row[0]
      vid = row[1]
      type = row[2]
      outline = "#{ocn}\t#{vid}\tHATHI\tNull\tNull\tNull\tNull\t#{type}\tNull"
      outf.puts(outline)
    end
    if ((count % 500000) == 0)
      puts "#{count}..."
    end
  end

  conn.close
  outf.close
end

if ARGV.length != 1
  puts "Usage: ruby generate_HT_AWS_file.rb <outfile>\n"
end

generate_HT_AWS_file(ARGV[0])
