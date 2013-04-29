require 'phdb/phdb_utils'
require 'set'
### These routines pull out lists of changed items in the "htitem_htmember_jn table from month
###    to month.  Assumes that a "new" and "old" version of the table exists in the development DB.
###    The generated lists are used by DLPS to determine which entries need to be flagged for 
###    re-indexing (since to re-index all takes weeks).  These are lists of volume_ids.


## returns true if lists are different, false of they're the same 
def changed_counts(oldlist, newlist)
  olds = {}
  oldlist.each do |a|
    omember, ocount = a.split("-")
    olds[omember] = (ocount.to_i > 0)
  end
  newlist.each do |b|
    nmember, ncount = b.split("-")
    # is the member in the old list
    if olds.has_key?(nmember)
      # does the access_count go from zero to non-zero, or vice versa
      return true unless olds[nmember] == (ncount.to_i > 0)
    else
      # adding a member with access_count > 0
      if ncount.to_i > 0
        return true
      end  
    end
  end
  return false
end


#def get_id_count_pairs_for_vol(volume_id, tablename)
#  members = []
#  conn2 = PHDBUtils.get_dev_conn()
#  query2 = "select member_id, access_count from #{tablename} where volume_id = '#{volume_id}'"
#  conn2.query(query2_new) do |row2|
#    members << "#{row2[0]}-#{row2[1]}"
#  end
#  conn2.close
#  return members
#end


def generate_volume_change_list(olddb, newdb, outfn)
  conn = PHDBUtils.get_dev_conn()
  conn.fetch_size=50000
  count = 0

  # going to have to loop through every current volume_id and check it against the old version
  access_count_changes = []
  gain_loss_changes = []   
  query1 = "select volume_id from holdings_htitem"
  conn.enumerate(query1).each_slice(50000) do |slice|
    slice.each do |row|
      count += 1
      vid = row[0]
      new_members = []
      old_members = []
      new_pairs = []
      old_pairs = []
      query2_new = "select member_id, access_count from #{newdb} where volume_id = '#{vid}'"
      query2_old = "select member_id, access_count from #{olddb} where volume_id = '#{vid}'"
      conn.query(query2_new) do |row2|
        mem_id = row2[0]
        acount = row2[1]
        new_members << mem_id
        mem_num_pair = "#{mem_id}-#{acount}"
        new_pairs << mem_num_pair
      end
      conn.query(query2_old) do |row2|
        mem_id = row2[0]
        acount = row2[1]
        old_members << mem_id
        mem_num_pair = "#{mem_id}-#{acount}"
        old_pairs << mem_num_pair
      end
      gain_loss_changes << vid unless new_members.sort == old_members.sort
      access_count_changes << vid if changed_counts(old_pairs, new_pairs)  
    end
    if ((count % 500000) == 0)
      puts "#{count}..."
    end
  end
  puts "There are #{gain_loss_changes.length} gain-loss changes."
  puts "There are #{access_count_changes.length} access_count changes."
  conn.close
  
  # write results
  outf = File.open(outfn, 'w')
  gl_set = Set.new gain_loss_changes  
  ac_set = Set.new access_count_changes
  puts "The gain_loss set a subset of the access_count subset.  #{gl_set.subset?(ac_set)}"
  puts "The access_count set a subset of the gain_loss subset.  #{ac_set.subset?(gl_set)}"
  gl_set.merge(ac_set)
  puts "There are #{gl_set.size} elements in the merged set"
  gl_set.each do |vid|
    outf.puts(vid)
  end
  outf.close
end



if ARGV.length != 1
  puts "Usage: ruby generate_updated_items_list.rb <outfile>\n"
end

old_table_name = "pulintz_ht.holdings_htitem_htmember_jn_old"
new_table_name = "pulintz_ht.holdings_htitem_htmember_jn"
generate_volume_change_list(old_table_name, new_table_name, ARGV[0])
