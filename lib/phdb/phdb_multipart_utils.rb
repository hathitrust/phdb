require 'phdb/phdb_utils'

module PHDBMultipartUtils
  
  class MultiItem
    attr_accessor :id, :oclc, :member_id, :status, :item_condition, 
    :process_date, :enum_chron, :item_type, :issn, :n_enum, :n_chron
    
    def initialize(instring)
      bits = instring.chomp.split("\t")
      
      unless bits.length == 11
        puts "Wrong number of fields: '#{bits.length}'"
        return nil
      end
      
      @id = bits[0]
      @oclc = bits[1]
      @local_id = bits[2]
      @member_id = bits[3]
      @status = bits[4]
      @item_condition = bits[5]
      @proces_date = bits[6]
      @enum_chron = bits[7]
      @item_type = bits[8]
      @issn = bits[9]
      @n_enum = bits[10]
      @n_chron = bits[11]
    end
    
    def to_s()
      i_vars = self.instance_variables
      first_var = i_vars.shift
      outstr = self.instance_variable_get(first_var)
      i_vars.each do |var|
        outstr << "\t#{self.instance_variable_get(var)}"
      end
      outstr << "\n"
      return outstr
    end
  end
   
   
  # returns a list of members who have contributed enum_chron data           
  def PHDBMultipartUtils.get_multipart_members_list()
    conn = PHDBUtils.get_dev_conn() 
    rows1 = conn.query("select member_id from holdings_memberitem 
                        where length(n_enum)>0 group by member_id")
    mem_ids = []
    rows1.each do |row|
      mid = row[:member_id]
      mem_ids << mid 
    end
    conn.close()
    return mem_ids
  end    
   
   
  def PHDBMultipartUtils.get_multipart_cluster_list()
    conn = PHDBUtils.get_dev_conn()
    #rows1 = conn.query("select distinct(c.cluster_id) from memberitem as mm, 
    #cluster_oclc as co, cluster as c where mm.oclc = co.oclc and co.cluster_id = c.cluster_id
    #and c.cluster_type = 'mpm';")
    rows1 = conn.query("select distinct(cluster_id) from holdings_cluster where cluster_type = 'mpm'")
    cids = []
    rows1.each do |row|
      cids << row[0]
    end
    conn.close()
    return cids
  end 
   
   
  def PHDBMultipartUtils.choose_oclc(cluster_id, member_id)
    new_conn = PHDBUtils.get_dev_conn()
    res = new_conn.query("select co.oclc, count(*) from holdings_memberitem as mm, 
                          holdings_cluster_oclc as co where co.oclc = mm.oclc and 
                          cluster_id = #{cluster_id} and member_id = '#{member_id}' group by oclc;")
    max = 0
    winner = ''
    res.each do |row|
      if row[1].to_i > max 
        winner = row[0]
      end
    end 
    new_conn.close()
    return winner
  end  
    
 
  ### This method is the main implementation of the mapping between multipart records
  #   provided by members and hathitrust items.  Given a cluster id, this method will 
  #   return a set of lines of the format:
  #        oclc n_enum member_id volume_id [counts]
  #   where [counts] is a list of [copy_count, lm_count, wd_count, brt_count, access_count].
  ###    
  def PHDBMultipartUtils.map_multipart_cluster_to_members(cluster_id, enum_members_l)
    # this subroutine populates the "cluster_htmember_multi" data file

    # get a connection
    conn = PHDBUtils.get_dev_conn()
    
    # collect data rows
    results = []
    
    ### get all oclcs ###
    query_str = "select distinct oclc from holdings_cluster_oclc where cluster_id = #{cluster_id};"
    rows1 = conn.query(query_str)
    ocns = []
    rows1.each do |row1|
      ocns << row1[:oclc]
    end
    
    ### get all memberdata and construct the memberdata stucture            ###
    ##  The structure is a bit involved to accommodate all the counts, but   ##
    ##  basically its member_id[oclc-nenum] -> [copy_count, lm_count, ...]   ##
    member_data = {}    # this will be a hash of hashes of lists (refactor this)
    ocns.each do |ocn|
      rows2 = conn.query("select member_id, oclc, n_enum, status, item_condition from holdings_memberitem
                          where oclc = #{ocn};")
      rows2.each do |row2|
        data_key = "#{row2[:oclc]}-#{row2[:n_enum]}"
        if member_data.has_key?(row2[:member_id])
          if member_data[row2[:member_id]].has_key?(data_key)
            member_data[row2[:member_id]][data_key][0] += 1
            member_data[row2[:member_id]][data_key][1] += 1 if row2[:status] == 'LM' 
            member_data[row2[:member_id]][data_key][2] += 1 if row2[:status] == 'WD' 
            member_data[row2[:member_id]][data_key][3] += 1 if row2[:item_condition] == 'BRT'
            member_data[row2[:member_id]][data_key][4] += 1 if (row2[:status] == 'LM' or row2[:item_condition] == 'BRT') 
          else
            row2[:status] == 'LM' ? lm_count = 1 : lm_count = 0
            row2[:status] == 'WD' ? wd_count = 1 : wd_count = 0
            row2[:item_condition] == 'BRT' ? brt_count = 1 : brt_count = 0
            (lm_count + brt_count) > 0 ? access_count = 1 : access_count = 0
            member_data[row2[:member_id]][data_key] = [1, lm_count, wd_count, 
                                                       brt_count, access_count]
          end
        else
          count_l = [1, 0, 0, 0, 0]
          count_l[1] += 1 if row2[:status] =='LM' 
          count_l[2] += 1 if row2[:status] == 'WD' 
          count_l[3] += 1 if row2[:item_condition] == 'BRT'
          count_l[4] += 1 if (row2[:status] == 'LM' or row2[:item_condition] == 'BRT')
          member_data[row2[:member_id]] = {data_key => count_l}
        end
      end
    end
    
    
    ### get all HT data ###
    ht_data = []  # this will be a list of lists
    rows3 = conn.query("select distinct oclcs, n_enum, chtij.volume_id from holdings_htitem as h, 
                        holdings_cluster_htitem_jn as chtij where h.volume_id = chtij.volume_id 
                        and chtij.cluster_id = #{cluster_id};")
    #rows3 = conn.query("select distinct oclcs, n_enum from htitem as h, 
    #                    cluster_htitem_jn as chtij where h.volume_id = chtij.volume_id 
    #                    and chtij.cluster_id = #{cluster_id};")
    rows3.each do |row3|
      ht_data << [row3[0], row3[1], row3[2]]
    end
    
    # if HT data has 'blanks', bailout assign all members from both lists
    bailout = 0
    #ht_data.each do |ht_item|
    #  bailout = 1 if not (ht_item[1] =~ /[A-Z0-9]/i)
    #end
    
    ### construct volume_id maps for cluster enums
    ht_dict = {}
    ht_data.each do |htd|
      if ht_dict.has_key?(htd[1])
        ht_dict[htd[1]] << htd[2]
      else
        ht_dict[htd[1]] = [htd[2]]
      end
    end
    
    ### categorize members ###
    enum_match_mems = []
    all_match_mems = []   # these members will be assigned to all items
    if (bailout == 1)
      all_match_mems = member_data.keys
    else
      unique_members = member_data.keys
      unique_members.each do |mem|
        if not enum_members_l.include?(mem)
          all_match_mems << mem
          next
        end
        data = member_data[mem]
        fail = 0
        data.each_pair do |k,v|
          k_bits = k.split('-')
          if not (k_bits[1] =~ /[A-Z0-9]/i)
            fail = 1
            next
          end
          if (k_bits[1] =~ /[\-,]/)
            fail = 1
            next
          end
        end
        fail == 0 ? enum_match_mems << mem : all_match_mems << mem
      end
    end
    
    #puts "DEBUG, all-match members: #{all_match_mems.join(',')}."
    #puts "DEBUG, enum-match members: #{enum_match_mems.join(',')}."
    
    ### add 'enum-match' members (should be <= all match) ###
    enum_match_mems.each do |emm|
      rows4 = conn.query("select distinct ho.oclc, h.n_enum from holdings_htitem as h, 
                          holdings_htitem_oclc as ho, holdings_cluster_oclc as co, holdings_memberitem as mm 
                          where h.volume_id = ho.volume_id and ho.oclc = co.oclc and 
                          ho.oclc = mm.oclc and h.n_enum = mm.n_enum and co.cluster_id = #{cluster_id} 
                          and mm.member_id = '#{emm}';")
      rows4.each do |row4|
        pkey = "#{row4[1]}"
        vol_str = ''
        if ht_dict[pkey]
          vol_str = ht_dict[pkey].join(',')
        else
          puts "Problem: zero length vol_str:\n\t#{cluster_id}\t#{row4[0]}\t#{row4[1]}\t#{emm}"
        end
        count_key = "#{row4[0]}-#{row4[1]}"
        count_str = "1\t0\t0\t0\t0"
        if member_data[emm].has_key?(count_key)
          copy_counts = member_data[emm][count_key]
          count_str = copy_counts.join("\t")
        #else
        #  puts "Problem, bad copy count key: #{count_key}"
        end
        outstr = "#{row4[0]}\t#{row4[1]}\t#{emm}\t#{cluster_id}\t#{vol_str}\t#{count_str}"
        results << outstr
        #puts outstr
      end
      # if no matches (but with member data for oclc), add member to all-match members
      if rows4.length() == 0
        all_match_mems << emm
      end
      
    end
    
    ### add 'all-match' members ###
    all_match_mems.each do |amm|
      ht_data.each do |ht_item|
        ocn = ht_item[0]
        if ht_item[0] =~ /[,]/          #  this can be optimized, its redundant
          ocn = PHDBMultipartUtils.choose_oclc(cluster_id, amm)
        end
        pkey = "#{ht_item[1]}"
        vol_str = ''
        if ht_dict[pkey] 
          vol_str = ht_dict[pkey].join(',')
        else
          puts "Problem: zero length vol_str:\n\t#{cluster_id}\t#{row4[0]}\t#{row4[1]}\t#{amm}"
        end
        count_key = "#{ocn}-#{ht_item[1]}"
        count_str = "1\t0\t0\t0\t0"
        if member_data[amm].has_key?(count_key)
          copy_counts = member_data[amm][count_key]
          count_str = copy_counts.join("\t")
        end
        outstr = "#{ocn}\t#{ht_item[1]}\t#{amm}\t#{cluster_id}\t#{vol_str}\t#{count_str}"
        results << outstr
        #puts outstr
      end
    end
    
    conn.close()
    return results
  end  

  
  ### Modification of the previous routine to only generate a file for an individual member  ###
  def PHDBMultipartUtils.map_multipart_cluster_to_individual_member(cluster_id, member_id, member_type)
    # this subroutine populates the "cluster_htmember_multi" data file

    # get a connection
    conn = PHDBUtils.get_dev_conn()
    
    # collect data rows
    results = []
    
    ### get all oclcs ###
    query_str = "select distinct oclc from holdings_cluster_oclc where cluster_id = #{cluster_id};"
    rows1 = conn.query(query_str)
    ocns = []
    rows1.each do |row1|
      ocns << row1[:oclc]
    end
    
    ### get all data for these OCLCs and construct the memberdata stucture   ###
    ##  The structure is a list of counts, basically its oclc-nenum -> [copy_count, lm_count, ...]  
    member_data = {}   
    ocns.each do |ocn|
      rows2 = conn.query("select oclc, n_enum, status, item_condition from holdings_memberitem
                          where oclc = #{ocn} and member_id = '#{member_id}';")
      rows2.each do |row2|
        n_enum = row2[:n_enum]
        next if n_enum.nil?
        data_key = "#{ocn}-#{n_enum}"
        if member_data.has_key?(data_key)
          member_data[data_key][0] += 1
          member_data[data_key][1] += 1 if row2[:status] == 'LM' 
          member_data[data_key][2] += 1 if row2[:status] == 'WD' 
          member_data[data_key][3] += 1 if row2[:item_condition] == 'BRT'
          member_data[data_key][4] += 1 if (row2[:status] == 'LM' or row2[:item_condition] == 'BRT') 
        else
          count_l = [1, 0, 0, 0, 0]
          count_l[1] += 1 if row2[:status] =='LM' 
          count_l[2] += 1 if row2[:status] == 'WD' 
          count_l[3] += 1 if row2[:item_condition] == 'BRT'
          count_l[4] += 1 if (row2[:status] == 'LM' or row2[:item_condition] == 'BRT')
          member_data[data_key] = count_l
        end
      end
    end
    
    return nil if member_data.empty?

    ### get all HT data ###
    ht_data = []  # this will be a list of lists
    rows3 = conn.query("select distinct oclcs, n_enum, chtij.volume_id from holdings_htitem as h, 
                        holdings_cluster_htitem_jn as chtij where h.volume_id = chtij.volume_id 
                        and chtij.cluster_id = #{cluster_id};")
    rows3.each do |row3|
      ht_data << [row3[0], row3[1], row3[2]]
    end
    
    # if HT data has 'blanks', bailout assign all members from both lists
    punt = 0
    #ht_data.each do |ht_item|
    #  punt = 1 if not (ht_item[1] =~ /[A-Z0-9]/i)
    #end
    
    ### construct volume_id maps for cluster enums
    ht_dict = {}
    ht_data.each do |htd|
      if ht_dict.has_key?(htd[1])   # 1 = n_enum
        ht_dict[htd[1]] << htd[2]   # 2 = volume_id
      else
        ht_dict[htd[1]] = [htd[2]]
      end
    end
    
    ### Handle detailed matching VS all matching (punt) case ###
    punt_count = 0
    non_punt_count = 0
    if member_type
      rows4 = conn.query("select distinct ho.oclc, h.n_enum from holdings_htitem as h, 
                          holdings_htitem_oclc as ho, holdings_cluster_oclc as co, holdings_memberitem as mm
                          where h.volume_id = ho.volume_id and ho.oclc = co.oclc and 
                          ho.oclc = mm.oclc and h.n_enum = mm.n_enum and co.cluster_id = #{cluster_id} 
                          and mm.member_id = '#{member_id}';")
      # if no matches (but with member data for oclc), add member to all-match members                              
      if rows4.length() == 0
        punt = 1
        punt_count += 1
      else 
        punt = 0
        non_punt_count += 1
      end
      rows4.each do |row4|
        pkey = "#{row4[1]}"      # n_enum
        vol_str = ''
        if ht_dict[pkey]
          vol_str = ht_dict[pkey].join(',')
        else
          puts "Problem: zero length vol_str:\n\t#{cluster_id}\t#{row4[0]}\t#{row4[1]}\t#{member_id}"
        end
        count_key = "#{row4[0]}-#{row4[1]}"   # oclc-n_enum
        count_str = "1\t0\t0\t0\t0"
        if member_data.has_key?(count_key)
          copy_counts = member_data[count_key]
          count_str = copy_counts.join("\t")
        #else
        #  puts "Problem, bad copy count key: #{count_key}"
        end
        outstr = "#{row4[0]}\t#{row4[1]}\t#{member_id}\t#{cluster_id}\t#{vol_str}\t#{count_str}"
        results << outstr
        #puts outstr
      end
    end  

    if (punt == 1)   # match all-all
      ht_data.each do |ht_item|
        ocn = ht_item[0]
        if ht_item[0] =~ /[,]/          #  this can be optimized, its redundant
          ocn = PHDBMultipartUtils.choose_oclc(cluster_id, member_id)
        end
        pkey = "#{ht_item[1]}"
        vol_str = ''
        if ht_dict[pkey] 
          vol_str = ht_dict[pkey].join(',')
        else
          puts "Problem: zero length vol_str:\n\t#{cluster_id}\t#{row4[0]}\t#{row4[1]}\t#{member_id}"
        end
        count_key = "#{ocn}-#{ht_item[1]}"
        count_str = "1\t0\t0\t0\t0"
        if member_data.has_key?(count_key)
          copy_counts = member_data[count_key]
          count_str = copy_counts.join("\t")
        end
        outstr = "#{ocn}\t#{ht_item[1]}\t#{member_id}\t#{cluster_id}\t#{vol_str}\t#{count_str}"
        results << outstr
        #puts outstr
      end
    end
    conn.close()
    return results
  end  
    
    
  def calc_H_for_multipart_items()
    # this routine generates data for the cluster_H table for multipart items
  
    # outfile
    outfile = File.new("cluster_H_multi.data", "w")
    # get a connection
    conn = PHDBUtils.get_dev_conn()
    
    # get all cluster_ids
    cidrows = conn.query("select distinct(cluster_id) from cluster_htmember_multi;")
    
    count = 0
    cidrows.each do |cid|
      count += 1
      results = conn.query("select distinct n_enum, count(distinct member_id) from cluster_htmember_multi 
                  where cluster_id = #{cid} group by n_enum;")
      results.each do |hit|
        outstr = "#{cid}\t#{hit[0]}\t#{hit[1]}"
        outfile.puts(outstr)
        #puts outstr
      end
      if ((count % 10000) == 0)
        puts "#{count}..."
        outfile.flush
      end 
    end
    
    outfile.close()
    conn.close()
  end  
    
    
  def get_multiH_records_for_cluster(conn, cluster_id)
    results = conn.query("select distinct ho.oclc, h.n_enum, count(distinct mm.member_id) 
    from htitem as h, htitem_oclc as ho, cluster_oclc as co, cluster_htmember_jn as chj, 
    memberitem as mm where h.volume_id = ho.volume_id and ho.oclc = co.oclc 
    and co.cluster_id = chj.cluster_id and ho.oclc = mm.oclc and h.n_enum = mm.n_enum 
    and co.cluster_id = #{cluster_id} group by ho.oclc, n_enum order by h.n_enum;")
    outstrs = []
    results.each do |result|
      ocn = result[0]
      n_enum = result[1]
      #next if n_enum.length < 1
      h = result[2]
      str = "#{ocn}\t'#{n_enum}'\t#{h}"
      outstrs << str
    end
    return outstrs
  end  
    
    
  def generate_multi_report_for_cluster(conn, cluster_id)
    # get a connection
    #conn = get_dev_conn()
    
    # count all the unique ocns that match a cluster_id
    rows1 = conn.query("select distinct oclc from cluster_oclc where cluster_id = #{cluster_id};")
    ocns = []
    rows1.each do |row|
      ocns << row
    end
    unique_ocns = ocns.uniq
    
    # get count of unique volume_ids for a cluster
    rows2 = conn.query("select distinct volume_id from cluster_htitem_jn where 
      cluster_id = #{cluster_id};")
    vol_ids = []
    rows2.each do |vid|
      vol_ids << vid
    end    
    unique_volids = vol_ids.uniq
        
    # count the number of memberitems matching cluster
    count3 = conn.query("select count(distinct co.oclc, member_id, n_enum) from memberitem 
      as mm, cluster_oclc as co where cluster_id = #{cluster_id} and co.oclc = mm.oclc 
      order by n_enum, member_id;")
    total_memberitems = count3[0]
    
    # count the number of memberitems matching cluster
    count4 = conn.query("select count(distinct co.oclc, mm.member_id, mm.n_enum) 
    from memberitem as mm, cluster_oclc as co, htitem as h, htitem_oclc as ho 
    where cluster_id = #{cluster_id} and co.oclc = mm.oclc and ho.volume_id = h.volume_id 
    and co.oclc = ho.oclc and h.n_enum = mm.n_enum;")
    matching_memberitems = count4[0]
    
    # count the number of matching members (global H-count for cluster)
    count5 = conn.query("select count(distinct member_id, co.oclc)
    from cluster_oclc as co, memberitem as mm 
    where cluster_id = #{cluster_id} and co.oclc = mm.oclc;")
    all_members = count5[0]
    
    # count the number of matching members (global H-count for corje!luster)
    count6 = conn.query("select count(distinct mm.member_id, co.oclc) 
    from memberitem as mm, cluster_oclc as co, htitem as h, htitem_oclc as ho 
    where cluster_id = #{cluster_id} and co.oclc = mm.oclc and ho.volume_id = h.volume_id 
    and co.oclc = ho.oclc and h.n_enum = mm.n_enum;")
    matching_members = count6[0]
    
    # count the number of memberitems with empty enum_chron
    count7 = conn.query("select count(distinct co.oclc, member_id, n_enum) 
    from memberitem as mm, cluster_oclc as co 
    where cluster_id = #{cluster_id} and co.oclc = mm.oclc and length(n_enum) = 0;")
    blank_entries = count7[0]
    
    # count the number of htitems with empty enum_chron
    count8 = conn.query("select count(distinct chj.volume_id, enum_chron) 
    from cluster_htitem_jn as chj, htitem where cluster_id = #{cluster_id} 
    and chj.volume_id = htitem.volume_id and length(enum_chron)=0;")
    blank_htitems = count8[0]
    
    # output 
    outstr = "#{cluster_id}\t#{unique_ocns.length}\t#{unique_volids.length}\t#{total_memberitems}\t#{matching_memberitems}\t#{all_members}\t#{matching_members}\t#{blank_entries}\t#{blank_htitems}"
    return outstr
  end
  
  def calc_multireport_stats(mfilen)
    sum_memberitems = 0
    sum_matches = 0
    sum_memblanks = 0
    sum_htblanks = 0
    clusters_with_blanks = 0
    File.readlines(mfilen).each do |line|
      bits = line.split("\t")
      sum_memberitems += bits[3].to_i
      sum_matches += bits[4].to_i
      sum_memblanks += bits[7].to_i
      sum_htblanks += bits[8].to_i
      if bits[8].to_i > 0
        clusters_with_blanks += 1
      end
    end  
    puts "\nTotal memberitems: #{sum_memberitems}"
    puts "Total matches: #{sum_matches}"
    puts "Total memblanks: #{sum_memblanks}"
    puts "Total htblanks: #{sum_htblanks}"
    percent_match = sum_matches.to_f/sum_memberitems.to_f
    percent_blank = sum_memblanks.to_f/sum_memberitems.to_f
    puts "Percentage matched: #{percent_match}"
    puts "Percentage blanks: #{percent_blank}"
    puts "Clusters with blanks: #{clusters_with_blanks}"
  end

end
