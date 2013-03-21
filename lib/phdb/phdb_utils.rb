require 'rubygems'
require 'java'
require 'jdbc-helper'
require 'set'

jars_dir = File.join(File.dirname(__FILE__), '../java')
for jar in Dir["#{jars_dir}/*.jar"]
  require jar
end
#require 'mysql-connector-java-5.1.17-bin.jar'

module PHDBUtils
  
  def PHDBUtils.get_source_map()
    source_map = {
       'MiU' => 'uom', 
       'UC' => 'berkeley',
       'COO' => 'cornell', 
       'PUR' => 'purd',
       'WU' => 'wisc', 
       'INU' => 'ind',
       'UMN' => 'minn', 
       'NYP' => 'nypl',
       'LOC' => 'loc', 
       'UVA' => 'uva',
       'YALE' => 'yale', 
       'UIU' => 'uiuc',
       'HVD' => 'harvard', 
       'PST' => 'psu',
       'IEN' => 'nwu', 
       'NJP' => 'prnc',
       'NNC' => 'columbia', 
       'UNC' => 'unc',
       'CHI' => 'chi', 
       'NCSU' => 'ncsu',
       'DUL' => 'duke', 
       'UCM' => 'ucm',
       'USU' => 'usu',
       'MDL' => 'minn',
       'MChB' => 'bc',
       'FU' => 'ufl'
    }
  end

  # currently storing passwords in separate files in my
  # project folder (under /etc).  Files are named
  # after username and contain a single line.
  def PHDBUtils.get_password_from_file(fn)
    file = File.new(fn, "r")
    line = file.gets
    return line.chomp
  end


  
  def PHDBUtils.get_dev_conn()
    # get PW
    pw = PHDBUtils.get_password_from_file('/htapps/pulintz.babel/Code/phdb/etc/ht_repository')
    # Log in
    conn = JDBCHelper::Connection.new(
      :driver=>'com.mysql.jdbc.Driver', 
      :url=>'jdbc:mysql://mysql-htdev/ht_repository',
      :user => 'ht_repository',
      :password => pw,
      :useCursorFetch => 'true', 
      :defaultFetchSize => 10000
    )
  end
  
  def PHDBUtils.get_prod_conn()
    # get PW              
    pw = PHDBUtils.get_password_from_file('/htapps/pulintz.babel/Code/phdb/etc/mdp')
    # Log in
    conn = JDBCHelper::Connection.new(
      :driver=>'com.mysql.jdbc.Driver', 
      :url=>'jdbc:mysql://mysql-sdr/mdp_holdings',
      :user => 'mdp',
      :password => pw,
      :useCursorFetch => 'true', 
      :defaultFetchSize => 10000
    )
  end
  
  # returns a list of member_ids           
  def PHDBUtils.get_member_list()
    conn = PHDBUtils.get_dev_conn() 
    rows1 = conn.query("select distinct member_id from holdings_memberitem")
    mem_ids = []
    rows1.each do |row|
      mid = row[:member_id]
      mem_ids << mid
    end
    conn.close()
    return mem_ids
  end

  def PHDBUtils.get_active_member_list()
    conn = PHDBUtils.get_dev_conn()
    rows1 = conn.query("select distinct member_id from holdings_htmember where status=1 order by member_id")
    mem_ids = []
    rows1.each do |row|
      mid = row[:member_id]
      mem_ids << mid
    end
    conn.close()
    return mem_ids
  end

  def PHDBUtils.get_serial_member_list()
    conn = PHDBUtils.get_dev_conn()
    # query takes 2.5 min (Feb 2013)
    rows1 = conn.query("select distinct member_id from holdings_memberitem where item_type='serial' order by member_id")
    mem_ids = []
    rows1.each do |row|
      mid = row[:member_id]
      mem_ids << mid
    end
    conn.close()
    return mem_ids
  end

  
  def PHDBUtils.parse_multiple_oclc(ocnline, delim=';')
    # currently just pulls the maximum number
    bits = ocnline.split(delim)
    max = 0
    bits.each do |bit|
      if bit.to_i > max
        max = bit.to_i
      end
    end
    return max
  end
  
  
  def PHDBUtils.parse_oclc(ocn)
      return 0 if ocn.nil?
      return 0 if ocn.empty?
      ### only use 1st OCLC ###
      ocnp = ocn.gsub(/\(OCoLC\)/, '')
      ocnp.gsub!(/ocl7/i, '')
      ocnp.gsub!(/oc[nm]/i, '')
      ocnp.gsub!(/oclc/i, '')
      ocnp.gsub!(/\\a/, '')
      if ocnp =~ /;/
        ocnp = PHDBUtils.parse_multiple_oclc(ocnp)
      elsif ocnp =~ /\,/
        ocnp = PHDBUtils.parse_multiple_oclc(ocnp, ",")
      elsif ocnp =~ /\s/
        ocnp = PHDBUtils.parse_multiple_oclc(ocnp, "\s")
      elsif ocnp =~ /\\z/
        ocnp = PHDBUtils.parse_multiple_oclc(ocnp, '\z')
      elsif ocnp =~ /\|/
        ocnp = PHDBUtils.parse_multiple_oclc(ocnp, '|')
      end 
      if (ocnp =~ /\D/)
        ocnp = ocnp.gsub(/\D/, '')
      end
      ocni = ocnp.to_i
    end
  
  
  def PHDBUtils.update_multipart_items()
    # this routine labels as 'multi' additional items associated with multipart clusters that
    # don't have any n_enum data
    conn = get_dev_conn()
    
    # select multipart clusters
    cluster_count = 0
    multipart_clusters = []
    rows = conn.query("select distinct(cluster_id) from holdings_cluster_htitem_jn as chtij, 
                      holdings_htitem as h where h.volume_id = chtij.volume_id and h.item_type = 'multi';")
    rows.each do |row|
      multipart_clusters << row[0]
    end
    puts "Multipart clusters obtained: #{multipart_clusters.length}"
    
    # loop through clusters and assign extra items (that don't have enum data) the 'multi' type
    multipart_clusters.each do |cid|
      # get volume_ids associated with the cluster                      
      vid_rows = conn.query("select distinct(volume_id) from holdings_cluster_htitem_jn where cluster_id = #{cid};")
      vid_rows.each do |vrow|
        vid = vrow[0]
        update_q = conn.query("update htitem set item_type = 'multi' where volume_id = '#{vid}'")
      end
      cluster_count += 1
      if ((cluster_count % 10000) == 0)
        puts "#{cluster_count}..."
      end  
    end
    conn.close()
  end
  
  
  def PHDBUtils.assign_cluster_type()
    # select cluster_ids
    conn = get_dev_conn()
    conn.fetch_size=50000
    
    cluster_count = 0
    query = "select cluster_id from holdings_cluster;"
    conn.enumerate(query).each_slice(50000) do |slice|
      slice.each do |row|
        cid = row[0]
        # grab all item_types for items in the cluster
        ctypes = []
        crows = conn.query("select distinct item_type from holdings_htitem as h, 
                            holdings_cluster_htitem_jn as chtij, holdings_cluster as c 
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
  
  
  def PHDBUtils.pull_cluster_tables(table_list)
    # get a connection
    conn = get_dev_conn()
    
    # Query 1 (get max cluster id)
    row = conn.query("select max(cluster_id) from cluster")
    result = row.uniq
    cell = result[0]   # first row in result array
    max_cluster_id = cell[0]  # apparently need to grab the first term too
    
    table_list.each do |table|
      puts "#{table}\n"
      # outfile for table
      outf = File.open("#{table}.out.tsv", "w")
      
      # Query 2 (pull all rows using enumerate)
      #sth = conn.prepare("select cluster_id, osici, cost_rights_id, last_mod from #{table} where cluster_id >= ? and cluster_id < ?")
      sth = conn.prepare("select * from #{table} where cluster_id >= ? and cluster_id < ?")
      min = 0
      until min > max_cluster_id do
        max = min + 10000
        sth.enumerate(min, max).each do |row|
          outstr = row.join("\t")
          outf.puts outstr
        end
        min += 10000
      end
      
      outf.close      
      sth.close
    end
    conn.close
  end
  
  
  def PHDBUtils.pull_phdb_tables(table_list)
    # get a connection
    conn = get_dev_conn()
    conn.fetch_size=10000
    table_list.each do |table|
      puts "#{table}\n"
      
      # outfile for table
      outf = File.open("#{table}.out.tsv", "w")
      
      conn.enumerate("SELECT * FROM #{table}").each_slice(10000) do |slice|
        slice.each do | row |
          outstr = row.join("\t")
          outf.puts outstr
        end
      end
      
      outf.close      
    end
    conn.close
  end
  
  
  def PHDBUtils.pull_matching_serials(serials_filename)
    # get a list of serial cluster ids from a flatfile list of serial oclc numbers.
    serial_ocns = []
    cluster_ids = Set.new
    volume_ids = Hash.new
    file = File.new(serials_filename, "r")
   
    puts "grabbing serial ocns from file..."
    while (line = file.gets)
      bits = line.chomp.split()
      #puts "'#{bits[2]}'\t#{bits.length}"
      next unless bits.length > 2 
      oclc = PHDBUtils.parse_oclc(bits[2])
      serial_ocns.push(oclc)
    end
    
    # get a connection
    conn = get_dev_conn()
    conn.fetch_size=10000
    
    # outfile 
    outf = File.open("serials.out.tsv", "w")
    
    # get cluster ids
    puts "grabbing cluster_ids..."
    serial_ocns.each do |tocn|
      conn.query("SELECT cluster_id FROM holdings_cluster_oclc WHERE oclc=#{tocn}") do |row|
        cluster_ids.add row[0]
      end
    end
    
    serial_ocns = nil
    
    # get volumes for each
    puts "grabbing volume_ids..."
    cluster_ids.each do |cid|
      conn.query("SELECT volume_id from holdings_cluster_htitem_jn where cluster_id = #{cid}") do |row1|
        conn.query("SELECT enum_chron from holdings_htitem where volume_id = '#{row1[:volume_id]}'") do |row2|
          outf.puts("#{cid}\t#{row1[:volume_id]}\t#{row2[:enum_chron]}")
        end    
      end
    end
    
    outf.close   
    conn.close   
  end
  
  
  def PHDBUtils.parse_serial_um_record_numbers(serials_filename)
    # get a list of serial um_record_numbers from Margaret's monthly flatfile.
    serial_umrecords = Set.new
    file = File.new(serials_filename, "r")
    
    # outfile 
    outf = File.open("serial_recordnums.out.tsv", "w")
   
    puts "grabbing serial ocns from file..."
    while (line = file.gets)
      bits = line.chomp.split("\t")
      next unless bits.length > 1 
      um_record_num = bits[0].to_i
      serial_umrecords.add um_record_num
    end
    
    serial_umrecords.each do |umr|
      
    end
    
    outf.close   
  end
  
  
  def PHDBUtils.split_volume_id(vid)
    # splits a volume_id of the form 'mdp.39015017176853' into an array ['mdp', 39015017176853]
    bits = vid.chomp.split('.')
    result = [bits[0], bits[1]]
    return result
  end
  
  
  
  def PHDBUtils.pull_query(query, filen)
    # get a connection
    conn = get_dev_conn()
    conn.fetch_size=10000
      
    # outfile for table
    outf = File.open(filen, "w")
    
    puts "Running '#{query}'..."
      
    conn.enumerate(query).each_slice(10000) do |slice|
      slice.each do | row |
        outstr = row.join("\t")
        outf.puts outstr
      end
    end
      
    outf.close     
    conn.close
  end
  
    
    
  def PHDBUtils.pull_serial_sizes(serial_data_fn)
    # takes a serial data file (clusterid, volumeid, enum_chron), hits the mdp_tracking.audit table 
    # and exports a file of the form (clusterid, volumeid, zip_size, mets_size) called                   
    # 'serialsize.out.tsv'                                                                               
    file = File.new(serial_data_fn, "r")
    outf = File.open("serialsize.out.tsv", "w")

    # get a connection         
    pconn = get_prod_conn()
    count = 0
    while (line = file.gets)
      bits = line.chomp.split()
      cluster_id = bits[0]
      vol_id = bits[1]
      next if not(vol_id && cluster_id)
      vid_bits = split_volume_id(vol_id)
      namespace = vid_bits[0]
      barcode = vid_bits[1]
      pconn.query("select zip_size, mets_size from mdp_tracking.audit \
                   where namespace = '#{namespace}' and id = '#{barcode}'") do |row|
        outf.puts("#{cluster_id}\t#{vol_id}\t#{row[0]}\t#{row[1]}")
      end
      count += 1
      if ((count % 10000) == 0)
        puts "#{count}..."
      end
    end
    file.close
    outf.close
    pconn.close
  end


  def PHDBUtils.add_source_items_to_htitem_htmember_jn()
    # This routine accounts for original "source" hathitrust items.  Many items in HT 
    # do not match anything, even the print holdings of the member who submitted them
    # to HT originally.  This routine updates the htitem_htmember_jn table with these 
    # entries.
    
    # get a connection
    conn = get_dev_conn()
    conn.fetch_size=10000
    
    # source institution map
    source_h = get_source_map()
    
    # california test set
    cali_members = %w(berkeley ucdavis uci ucla ucmerced ucr ucsb ucsc ucsd ucsf)
    
    ### loop through HT items ###
    count = 0
    cali_hits = 0
    conn.query("SELECT volume_id, source from holdings_htitem") do |row1|
      #puts "DEBUG #{row1[:source]}\t#{row1[:volume_id]}"
      #! handle California !#
      count += 1
      skip = false
      if row1[:source] == 'UC'
        cali_query = "SELECT member_id from holdings_htitem_htmember_jn where volume_id = '#{row1[:volume_id]}'"
        test_rows = conn.query(cali_query)
        test_rows.each do |t|
          if cali_members.include?(t[0].strip)
            skip = true
            break
          end 
        end
      end
      cali_hits += 1 if skip
      member_id = source_h[row1[:source]]
      unless skip
        query_str = "INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count) 
                  VALUES ('#{row1[:volume_id]}', '#{member_id}', 1)"
        conn.query(query_str)
      end
      skip = false
      if ((count % 100000) == 0)
        puts "Count:     #{count}..."
        puts "\tSkipped Calis:  #{cali_hits}"
      end
    end
    
    conn.close
  end
  
  
  
  def PHDBUtils.prune_OCLC_resolution_data(datafn, outfn)  
    # only retain lines with HT oclc numbers
    file = File.new(datafn, "r")
    outf = File.open(outfn, 'w')

    # get a connection
    conn = get_dev_conn()
    
    # get oclc hash
    oclc_h = {}
    o_rows = conn.query("select distinct(oclc) from holdings_htitem_oclc;")
    o_rows.each do |o|
      oclc_h[o[0]] = 1
    end
    
    puts "Sanity check: #{oclc_h.length} oclcs."

    count = 0
    while (line = file.gets)
      count += 1
      bits = line.chomp.split(':')
      ocn0 = bits[0]
      ocns = bits[1].split(' | ')
      ocns.each do |ocn|
        if oclc_h.has_key?(ocn.to_i)
          outf.puts line
        end
      end  
      
      if ((count % 10000) == 0)
        puts "#{count}..."
      end
    end
    file.close
    outf.close
    conn.close
  end
  
  
  ## Creates an additional htitem_oclc file 
  def PHDBUtils.add_OCLC_resolution_data_to_htitem_oclc(datafn, outfn)  
    file = File.new(datafn, "r")
    outf = File.open(outfn, 'w')

    # get a connection
    conn = get_dev_conn()
    
    # get oclc hash
    #oclc_h = {}
    #o_rows = conn.query("select distinct(oclc) from htitem_oclc;")
    #o_rows.each do |o|
    #  oclc_h[o[0]] = 1
    #end
    
    #puts "Sanity check: #{oclc_h.length} oclcs."

    count = 0
    while (line = file.gets)
      count += 1
      bits = line.chomp.split(':')
      ocn0 = bits[0]
      ocns = bits[1].split(' | ')
      # get all vol_ids associated with these ocns
      vol_ids = Set.new
      ocns.each do |ocn|
        vid_rows = conn.query("select volume_id from holdings_htitem_oclc where oclc = #{ocn};")
        vid_rows.each do |vrow|
          #vol_ids << vrow
          vol_ids.add(vrow[0])       
        end
      end  
      # insert vol-oclc pairs
      vol_ids.each do |vid|
        ocns.each do |oc|
          outf.puts "#{vid}\t#{oc}\t1"
        end
      end
      
      if ((count % 10000) == 0)
        puts "#{count}..."
      end
    end
    file.close
    outf.close
    conn.close
  end
  
  
  
  def PHDBUtils.print_matching_item_counts(outfn)
    # get a connection
    conn = get_dev_conn()
    
    outf = File.open(outfn, 'w')
    
    # get member ids
    members = []
    rows = conn.query("select member_id, member_name from holdings_htmember")
    rows.each do |row|
      members << row[:member_id]
    end
    puts "#{members.length} members."
    
    smembers = members.sort
    
    smembers.each do |mem|
      q1 = "select item_type, count(distinct hhj.volume_id) 
      from holdings_htitem_htmember_jn as hhj, holdings_htitem as h where hhj.volume_id = h.volume_id 
      and member_id = '#{mem}' group by item_type"
      
      conn.query(q1) do |row|
        out_str = "#{mem}\t#{row[0]}\t#{row[1]}"
        puts out_str
        outf.puts(out_str) 
      end
    end
    conn.close
    outf.close
  end
  
  # The purpose of this routine is to generate the HathiTrust equivalent 
  #   of one of the memberitem flatfiles, so that HT data can be treated
  #   the same as member data for the purpose of the AWS hadoop calculations.
  def PHDBUtils.generate_HT_AWS_file(outfn)
    # get a connection
    conn = get_dev_conn()
    conn.fetch_size=50000
    count = 0
      
    outf = File.open(outfn, 'w') 
          
    # get oclc hash
    oclc_h = {}
    query = "select ho.oclc, ho.volume_id, item_type
               from holdings_htitem_oclc as ho, holdings_htitem as h 
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

  # Routine loads all data from a specified folder into the memberitem table
  def PHDBUtils.load_all_data_into_memberitem(my_dir)
    conn = get_dev_conn()
    files = Dir["#{my_dir}/*.tsv"]
    files.sort!
    files.each do |fil|
      query = "LOAD DATA LOCAL INFILE '#{fil}' INTO TABLE holdings_memberitem IGNORE 1 LINES 
      (oclc, local_id, member_id, status, item_condition, process_date, enum_chron, item_type, issn, n_enum, n_chron)"
      puts "loading #{fil}..."
      conn.update(query)
    end
    conn.close
  end

end
