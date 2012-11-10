require 'phdb/phdb_utils'
require 'phdb/phdb_multipart_utils'

#multi_members_enum = %w{arizona bc berkeley chi columbia cornell dart emory getty 
#                        harvard ind iowa jhu ksu lafayette mcgill miami minn missouri 
#                        nd nwu nyu osu pitt psu purd stanford tamu ucdavis uci ucla 
#                        ucsb ucsc ucsd ucsf udel ufl uic uiuc umd unl uom upenn uvm 
#                        washington wisc yale}
        
     
                        
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
       
       
def generate_cluster_htmember_multi_file(outfilen)
  #outfile = File.new("cluster_htmember_multi.20120409.data", "w")
  outfile = File.new(outfilen)
  multi_members_enum = PHDBMultipartUtils.get_multipart_members_list()

  cids = PHDBMultipartUtils.get_multipart_cluster_list()
  puts "#{cids.length} clusters in list."
  count = 0
  cids.each do |cid|
    result_set = PHDBMultipartUtils.map_multipart_cluster_to_members(cid, multi_members_enum)
    # calc unique lines
    result_set.uniq.each do |line|
    # line: oclc, enum, member_id, cluster_id, volume_ids, count
      outfile.puts(line)
    end
    count += 1
    if ((count % 10000) == 0)
      puts "#{count}..."
    outfile.flush
    end
  end
  outfile.close()
end

#mems = PHDBMultipartUtils.get_multipart_members_list
#puts mems
cluster_id = 3220320
outfile = "test.txt"
get_cluster_htmember_multi_data(cluster_id, outfile)
