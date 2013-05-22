require 'phdb/phdb_utils'
require 'phdb/phdb_multipart_utils'
        
     
# exports all lines for a cluster to an outfile (also puts them onscreen)
# useful for debugging                        
def get_cluster_htmember_multi_data(cluster_id, outfilen)
  testfile = File.new(outfilen, "w")
  multi_members_enum = PHDBMultipartUtils.get_multipart_members_list()
  ## example cluster_id: 3220320
  data = PHDBMultipartUtils.map_multipart_cluster_to_members(cluster_id, multi_members_enum)
  data.each do |line|
    puts line
    testfile.puts(line)
  end
  testfile.close
end
       
       
def generate_supplemental_cluster_htmember_multi_file(member_id, member_type, outfilen)
  outfile = File.new(outfilen, "w")
  cids = PHDBMultipartUtils.get_multipart_cluster_list()
  puts "#{cids.length} clusters in list."
  count = 0
  nomatch_count = 0
  cids.each do |cid|
    count += 1
    if ((count % 50000) == 0)
      puts "#{count}..."
      outfile.flush
    end
    result_set = PHDBMultipartUtils.map_multipart_cluster_to_individual_member(cid, member_id, member_type)
    nomatch_count += 1 if result_set.nil?
    next if result_set.nil?
    # calc unique lines
    result_set.uniq.each do |line|
      # line: oclc, enum, member_id, cluster_id, volume_ids, count
      outfile.puts(line)
    end
  end
  puts "Nomatch count = #{nomatch_count}"
  outfile.close()
end

## testers ##
#mems = PHDBMultipartUtils.get_multipart_members_list
#puts mems
#cluster_id = 3220320
#outfile = "test.txt"
#get_cluster_htmember_multi_data(cluster_id, outfile)

if ARGV.length != 3
  puts "Usage: ruby multipart_cluster_mapper.rb <member_id> <member_type> <outfile>\n"
  puts "'member_type' is '1' for a member who has submitted enum_chron data, '0' otherwise."
  exit
end
generate_supplemental_cluster_htmember_multi_file(ARGV[0], ARGV[1], ARGV[2])
