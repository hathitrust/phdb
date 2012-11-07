require 'phdb/phdb_utils'

def assign_cluster_type()
  # select cluster_ids
  conn = PHDBUtils.get_dev_conn()
  conn.fetch_size=50000
    
  cluster_count = 0
  query = "select cluster_id from cluster;"
  conn.enumerate(query).each_slice(50000) do |slice|
    slice.each do |row|
      cid = row[0]
      # grab all item_types for items in the cluster
      ctypes = []
      crows = conn.query("select distinct item_type from htitem as h, cluster_htitem_jn as chtij, cluster as c 
                            where c.cluster_id = chtij.cluster_id and chtij.volume_id = h.volume_id 
                            and c.cluster_id = #{cid};")
      crows.each do |ctype|
        ckey = ''
        case ctype[0]
        when 'mono'
          ckey = 'spm'
        when 'multi'
          ckey = 'mpm'
        when 'serial'
          ckey = 'ser'
        else
          puts "#{ctype[0]} type unknown."
          ckey = 'spm'
        end
        ctypes << ckey  
      end
      csorted = ctypes.sort
      typekey = csorted.join('/')
      # update
      update_q = conn.update("update cluster set cluster_type = '#{typekey}' where cluster_id = #{cid}")
        
      cluster_count += 1
      if ((cluster_count % 50000) == 0)
        puts "#{cluster_count}..."
      end  
    end
  end
  puts "done assigning cluster types."
end
  
assign_cluster_type()

