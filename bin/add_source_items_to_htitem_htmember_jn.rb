require 'phdb/phdb_utils'


# This routine accounts for original "source" hathitrust items.  Many items in HT 
# do not match anything, even the print holdings of the member who submitted them
# to HT originally.  This routine updates the htitem_htmember_jn table with these 
# entries.
def add_source_items_to_htitem_htmember_jn(reportfn)

  conn = PHDBUtils.get_dev_conn()
  conn.fetch_size=10000
    
  # source institution map
  source_h = PHDBUtils.get_source_map()
  cali_members = %w(berkeley ucdavis uci ucla ucmerced ucr ucsb ucsc ucsd ucsf)
  #ht_members = PHDBUtils.get_member_list()
  outfile = File.new(reportfn, "w")
    
  ### loop through HT items ###
  rowcount = 0
  cali_total = 0
  deposits = 0
  cali_hits = 0
  other_hits = 0
  conn.query("SELECT volume_id, source from htitem") do |row1|
    #puts "DEBUG #{row1[:source]}\t#{row1[:volume_id]}"
    #! handle California !#
    rowcount += 1
    skip = false
    if row1[:source] == 'UC'
      cali_total += 1
      cali_query = "SELECT member_id from htitem_htmember_jn where volume_id = '#{row1[:volume_id]}'"
      test_rows = conn.query(cali_query)
      test_rows.each do |t|
        if cali_members.include?(t[0].strip)
          skip = true
          cali_hits += 1 
          break
        end 
      end
    else
      member_id = source_h[row1[:source]]
      mem_query = "SELECT member_id from htitem_htmember_jn where volume_id = '#{row1[:volume_id]}'"
      test_rows = conn.query(mem_query)
      test_rows.each do |t|
        if t[0].strip == member_id
          skip = true
          other_hits += 1
          break
        end 
      end
    end
    unless skip
      member_id = source_h[row1[:source]]
      deposits += 1
      query_str = "INSERT IGNORE INTO htitem_htmember_jn (volume_id, member_id, copy_count) 
                  VALUES ('#{row1[:volume_id]}', '#{member_id}', 1)"
      conn.query(query_str)
      outstr = "#{row1[:volume_id]}\t#{member_id}"
      #puts outstr
      outfile.puts(outstr)
    end
    skip = false
    if ((rowcount % 100000) == 0)
      puts "\nRowcount:  #{rowcount}..."
      puts "\tCaliTotal: #{cali_total}"
      puts "\tCaliHits:  #{cali_hits}"
      puts "\tOtherHits: #{other_hits}"
      puts "\tDeposits:  #{deposits}"
    end
  end
  
  puts "\nFinal Rowcount:  #{rowcount}..."
  puts "\tFinal CaliTotal: #{cali_total}"
  puts "\tFinal CaliHits:  #{cali_hits}"
  puts "\tFinal OtherHits: #{other_hits}"
  puts "\tFinal Deposits:  #{deposits}"

  outfile.close
  conn.close
end
  
if ARGV.length != 1
  abort "Usage: ruby add_source_items_to_htitem_htmember_jn <reportfile>\n"
end  
add_source_items_to_htitem_htmember_jn(ARGV[0])
