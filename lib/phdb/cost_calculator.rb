require 'phdb/phdb_utils'

module PHDBUtils
  
  def PHDBUtils.calc_ave_cost_per_vol(projected_operating_costs)
    conn = PHDBUtils.get_dev_conn()
    count1 = conn.query("select count(*) from holdings_htitem;")
    total_HT_items = count1[0]
    return projected_operating_costs.to_f/total_HT_items[0].to_f
    conn.close()
  end
  
  
  def PHDBUtils.get_monograph_list()
    conn = get_dev_conn()
    members = []
    member_rows = conn.query("select distinct (member_id) from holdings_memberitem")
    member_rows.each do |mr|
      members << mr[0]
    end
    conn.close()
    return members
  end
  
  
  def PHDBUtils.calc_pd_costs(ave_cost_per_vol)
    conn = get_dev_conn()
    
    public_counts = []
    # get the singlepart monograph public domain cost
    count1 = conn.query("select count(*) from holdings_htitem where item_type = 'mono' and access = 'allow';")
    public_counts << count1[0]
    
    # get the serial public domain cost
    count2 = conn.query("select count(*) from holdings_htitem where item_type = 'serial' and access = 'allow';")
    public_counts << count2[0]
    
    # get the multipart monograph public domain cost
    count3 = conn.query("select count(*) from holdings_htitem where item_type = 'multi' and access = 'allow';")
    public_counts << count3[0]
    
    costs = public_counts.map {|x| x[0].to_i*ave_cost_per_vol}
 
    conn.close()
    return costs
  end
  
  
  def PHDBUtils.calc_total_ic_singlepart_monograph_cost(ave_cost_per_vol)
    conn = get_dev_conn()
    
    count_row = conn.query("select count(*) from holdings_htitem where item_type = 'mono' and access = 'deny'")
    ic_spm = count_row[0]
    total_spm_cost = ic_spm[0].to_i * ave_cost_per_vol
    
    conn.close()
    return total_spm_cost
  end
  
  
  def PHDBUtils.calc_adjusted_ic_spm_ave_cost_per_vol(ave_cost_per_vol)
    conn = get_dev_conn()
    
    new_total = 0.0
    member_rows = conn.query("select distinct (member_id) from holdings_memberitem")
    member_rows.each do |mr|
      result = PHDBUtils::calc_ic_singlepart_monograph_cost_for_member(mr[0], ave_cost_per_vol)
      cost_f = "%.2f" % result.to_f
      new_total += result.to_f
    end
    
    old_total = PHDBUtils.calc_total_ic_singlepart_monograph_cost(ave_cost_per_vol)
    diff = old_total - new_total
    puts "\tSPM Old Total: #{old_total} New Total: #{new_total} \n\tDiff: #{diff}"
    
    # need the number of *matching volumes* among which to distribute new cost
    #count_row = conn.query("select count(distinct volume_id) from cluster_htitem_jn as chj, 
    #                        cluster as c, cluster_htmember_jn as chmj 
    #                        where chj.cluster_id = c.cluster_id and chmj.cluster_id = c.cluster_id 
    #                        and c.cluster_type = 'spm' and not c.cost_rights_id = 1")
    count_row = conn.query("select count(*) from holdings_htitem_H as hhH, holdings_htitem as hh 
                            where hhH.volume_id = hh.volume_id and hh.item_type = 'mono'
                            and hh.access = 'deny' ")
    ic_spms = count_row[0]
    
    new_ave_cost_per_vol = ave_cost_per_vol + diff/ic_spms[0].to_i
    
    conn.close()
    return new_ave_cost_per_vol
  end
  
  
  def PHDBUtils.calc_ic_singlepart_monograph_cost_for_member(mem_id, ave_cost_per_vol)
    # get a connection
    conn = get_dev_conn()
    
    #ave_cost_per_volume = 0.163-(0.10*0.163)
    
    # get the in-copyright lookup table values for member
    rows = conn.query("select H_id, H_count from holdings_H_counts where member_id = '#{mem_id}' 
                       and access = 'deny' and item_type = 'mono'")
    
    total_cost = 0.0
    
    rows.each do |row|
      #puts "'#{row[:H_id]}'\t'#{row[:H_count]}'\n"
      h = row[:H_id].to_i
      count = row[:H_count].to_i
      cost = (count*ave_cost_per_vol)/h
      total_cost += cost
    end
    return total_cost
  end
  
  
  def PHDBUtils.calc_total_ic_multipart_monograph_cost(ave_cost_per_vol)
    conn = get_dev_conn()
    count_row = conn.query("select count(*) from holdings_htitem where item_type = 'multi' and access = 'deny'")
    ic_multis = count_row[0]
    total_multi_cost = ic_multis[0].to_i * ave_cost_per_vol
    conn.close()
    return total_multi_cost
  end
  
  
  def PHDBUtils.calc_adjusted_ic_multipart_cost_per_vol(old_ave_cost_per_vol, total_amount_reduced)
    ### DEPRECATED ###
    
    conn = get_dev_conn()
    # given a value to be deducted from the total, calculate a new ave_cost_per_vol for serials 
    old_total_cost = PHDBUtils.calc_total_ic_multipart_monograph_cost(old_ave_cost_per_vol)
    
    # need the number of *matching volumes* among which to distribute new cost
    count_row = conn.query("select count(distinct oclc, n_enum) from cluster_htmember_multi as chm, 
                            cluster as c where chm.cluster_id = c.cluster_id and 
                            not c.cost_rights_id = 1")
    
    ic_multis = count_row[0]
    
    #new_ave_cost_per_vol = (old_total_cost - total_amount_reduced)/1599721
    
    new_ave_cost_per_vol = (old_total_cost - total_amount_reduced)/ic_multis[0].to_i
    
    conn.close()
    return new_ave_cost_per_vol
  end
  
  
  def PHDBUtils.calc_adjusted_ic_mpm_ave_cost_per_vol(ave_cost_per_vol)
    conn = get_dev_conn()
    
    new_total = 0.0
    member_rows = conn.query("select distinct (member_id) from holdings_memberitem")
    member_rows.each do |mr|
      result = PHDBUtils::calc_ic_multipart_monograph_cost_for_member(mr[0], ave_cost_per_vol)
      cost_f = "%.2f" % result.to_f
      new_total += result.to_f
    end
    
    old_total = PHDBUtils.calc_total_ic_multipart_monograph_cost(ave_cost_per_vol)
    diff = old_total - new_total
    puts "\tMPM Old Total: #{old_total} New Total: #{new_total} \n\tDiff: #{diff}"
    
    # need the number of *matching volumes* among which to distribute new cost
    #count_row = conn.query("select count(distinct volume_id) from cluster_htitem_jn as chj, 
    #                        cluster as c, cluster_htmember_jn as chmj 
    #                        where chj.cluster_id = c.cluster_id and chmj.cluster_id = c.cluster_id 
    #                        and c.cluster_type = 'spm' and not c.cost_rights_id = 1")
    count_row = conn.query("select count(*) from holdings_htitem_H as hhH, holdings_htitem as hh 
                            where hhH.volume_id = hh.volume_id and hh.item_type = 'multi'
                            and hh.access = 'deny' ")
    ic_mpms = count_row[0]
    
    new_ave_cost_per_vol = ave_cost_per_vol + diff/ic_mpms[0].to_i
    
    conn.close()
    return new_ave_cost_per_vol
  end
  
  
  def PHDBUtils.calc_ic_multipart_monograph_cost_for_member(mem_id, ave_cost_per_vol)
    # get a connection
    conn = get_dev_conn()
    
    # get the in-copyright lookup table values for member
    rows = conn.query("select H_id, H_count from holdings_H_counts where member_id = '#{mem_id}' 
    and access = 'deny' and item_type = 'multi'")
    
    total_cost = 0.0
    
    rows.each do |row|
      #puts "'#{row[:H_id]}'\t'#{row[:H_count]}'\n"
      h = row[:H_id].to_i
      count = row[:H_count].to_i
      cost = (count*ave_cost_per_vol)/h
      total_cost += cost
    end
    return total_cost
    
  end
  
  
  def PHDBUtils.calc_total_ic_serial_cost(ave_cost_per_vol)
    conn = get_dev_conn()
    
    count_row = conn.query("select count(*) from holdings_htitem where item_type = 'serial' and access = 'deny'")
    ic_serials = count_row[0]
    total_serial_cost = ic_serials[0].to_i * ave_cost_per_vol
    
    conn.close()
    return total_serial_cost
  end
  
  
  
  def PHDBUtils.calc_adjusted_ic_serial_cost_per_vol(old_ave_cost_per_vol, total_amount_reduced)
    conn = get_dev_conn()
    # given a value to be deducted from the total, calculate a new ave_cost_per_vol for serials 
    old_total_cost = PHDBUtils.calc_total_ic_serial_cost(old_ave_cost_per_vol)
    #count_row = conn.query("select count(*) from htitem where item_type = 'serial' and access = 'deny'")
    #ic_serials = count_row[0]
    #new_ave_cost_per_vol = ((old_ave_cost_per_vol * new_total_cost)/old_total_cost)
    #new_ave_cost_per_vol = (old_total_cost - total_amount_reduced)/ic_serials[0].to_i
    
    # need the number of *matching* volumes among which to distribute new cost
    #count_row = conn.query("select count(distinct chj.volume_id) from cluster_htitem_jn as chj, 
    #                        cluster as c, memberitem_serial as ms, cluster_oclc as co 
    #                        where chj.cluster_id = c.cluster_id and c.cluster_id = co.cluster_id 
    #                        and co.oclc = ms.oclc and c.cluster_type = 'ser' 
    #                        and not c.cost_rights_id = 1")
    count_row = conn.query("select count(*) from holdings_htitem_H as hhH, holdings_htitem as hh 
                            where hhH.volume_id = hh.volume_id and hh.item_type = 'serial'
                            and hh.access = 'deny' ")
    ic_serials = count_row[0]
    
    #new_ave_cost_per_vol = (old_total_cost - total_amount_reduced)/1599721
    
    new_ave_cost_per_vol = (old_total_cost - total_amount_reduced)/(ic_serials[0].to_i)
    
    conn.close()
    return new_ave_cost_per_vol
  end
  
  
  def PHDBUtils.calc_ic_serial_cost_for_member_by_size(mem_id)
    # get a connection
    conn = get_dev_conn()
    
    xfactor = 1.50
    total_storage_size_bytes = 480722804968888.625
    total_storage_cost_usd = 1878347

    rowcount = 0
    total_cost = 0.0
    # get the in-copyright lookup table values for member
    conn.enumerate("SELECT holdings_cluster.cluster_id, cost_rights_id, total_serial_size, H 
                    FROM holdings_cluster, holdigns_cluster_htmember_jn 
                    WHERE holdings_cluster.cluster_id = holdings_cluster_htmember_jn.cluster_id 
                    AND total_serial_size > 0 AND NOT cost_rights_id = 1 AND member_id = '#{mem_id}'").each_slice(1000) do |slice|
    
      slice.each do |row|
        rowcount += 1
        cluster_id = row[0]
        total_serial_size = row[:total_serial_size].to_f
        volume_H = row[:H].to_i
        # calc cost for serial based on size
        serial_storage_cost = (total_serial_size/total_storage_size_bytes)*total_storage_cost_usd
        #serial_cost_to_member = (serial_storage_cost*xfactor)/volume_H
        serial_cost_to_member = serial_storage_cost/volume_H
        #puts "\t#{serial_storage_cost}\t#{serial_cost_to_member}"
        total_cost += serial_cost_to_member
        #puts "'#{row[0]}'\t'#{row[1]}'\t'#{row[2]}'\t'#{row[3]}'\n"
      end
    end
    #puts "Total rows: #{rowcount}"
    #puts "Total Serial Cost for #{mem_id}: #{total_cost} USD"
    return total_cost
  end
  
  
  def PHDBUtils.calc_member_monograph_percent_contribution(cost_hash, total_mono_cost)
    # expects a data structure as a hash, keyed by member_id, with a list [spm, mpm] costs as a value
    percent_hash = {}
    cost_hash.each_key {|k| percent_hash[k] = nil}
    
    cost_hash.each { |key, value|
      sum = value[0] + value[1]
      percent_hash[key] = (value[0]+value[1])/total_mono_cost
    }
    return percent_hash
  end
  
  
  def PHDBUtils.calc_ic_serial_cost_for_member_by_count(mem_id, ave_cost_per_vol)
    # get a connection
    conn = get_dev_conn()
    
    total_cost = 0.0
    # get the in-copyright lookup table values for member
    conn.enumerate("SELECT holdings_cluster.cluster_id, cost_rights_id, H, num_of_items 
                    FROM holdings_cluster, holdings_cluster_htmember_jn
                    WHERE holdings_cluster.cluster_id = holdings_cluster_htmember_jn.cluster_id 
                    AND cluster_type = 'ser'
                    AND member_id = '#{mem_id}'
                    AND NOT cost_rights_id = 1
                    GROUP BY cluster_id").each_slice(10000) do |slice|
      slice.each do |row|
        cluster_id = row[0]
        total_volume_count= row[3].to_i
        volume_H = row[:H].to_i
        # calc cost for serial based on size
        total_serial_cost = (total_volume_count)*ave_cost_per_vol
        #serial_cost_to_member = (serial_storage_cost*xfactor)/volume_H
        serial_cost_to_member = total_serial_cost/volume_H
        #puts "\t#{serial_storage_cost}\t#{serial_cost_to_member}"
        total_cost += serial_cost_to_member
        #puts "'#{row[0]}'\t'#{row[1]}'\t'#{row[2]}'\t'#{row[3]}'\n"
      end
    end
    
    conn.close()
    return total_cost
  end
  
  
  def PHDBUtils.calc_ic_serial_cost_for_member_by_count2(mem_id, ave_cost_per_vol)
    # get a connection
    conn = get_dev_conn()
    
    total_cost = 0.0
    
    # get the in-copyright lookup table values for member
    rows = conn.query("SELECT H_id, H_count FROM holdings_H_counts WHERE member_id = '#{mem_id}'
                    AND item_type = 'serial' AND access = 'deny'")
    
    rows.each do |row|
      h = row[:H_id].to_i
      h_count = row[:H_count].to_i
      total_cost += h_count*(ave_cost_per_vol/h)
      #if (mem_id == 'uiuc')
      #  puts "\tH_id: #{h}\tH_count: #{h_count}\t#{total_cost}\n"
      #end
    end
    
    conn.close()
    return total_cost
  end
  
end
