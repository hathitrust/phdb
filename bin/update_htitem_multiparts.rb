require 'phdb/phdb_utils'

# this routine labels as 'multi' additional items associated with multipart 
# clusters that don't have any n_enum data
def update_multipart_items()
  conn = PHDBUtils.get_dev_conn()
    
  # select multipart clusters
  cluster_count = 0
  multipart_clusters = []
  rows = conn.query("select distinct(cluster_id) from cluster_htitem_jn as chtij, 
                     htitem as h where h.volume_id = chtij.volume_id and h.item_type = 'multi';")
  rows.each do |row|
    multipart_clusters << row[0]
  end
  puts "Multipart clusters obtained: #{multipart_clusters.length}"
    
  # loop through clusters and assign extra items (that don't have enum data) the 'multi' type
  multipart_clusters.each do |cid|
    # get volume_ids associated with the cluster                      
    vid_rows = conn.query("select distinct(volume_id) from cluster_htitem_jn where cluster_id = #{cid};")
    vid_rows.each do |vrow|
      vid = vrow[0]
      update_q = conn.query("update htitem set item_type = 'multi' where volume_id = '#{vid}'")
    end
    cluster_count += 1
    if ((cluster_count % 100000) == 0)
      puts "#{cluster_count}..."
    end  
  end
  conn.close()
end
  
update_multipart_items()
