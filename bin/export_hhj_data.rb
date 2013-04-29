
require 'phdb/phdb_utils'

# grab the member_ids from the hhj table
def get_ids()
  conn = PHDBUtils.get_dev_conn()
  memberids = []
  rows = conn.query("select distinct(member_id) from holdings_htitem_htmember_jn;")
  rows.each do |row|
    memberids << row[0]
  end
  puts "member_id values obtained: #{memberids.length}"
  conn.close()
  return memberids
end


def export_data_files()
  memberids = PHDBUtils.get_member_list()
  htrep_pw = PHDBUtils.get_password_from_file('/htapps/pulintz.babel/Code/phdb/etc/ht_repository')
  count = 0
  memberids.each do |mid|
    next if mid.length < 2
    count += 1
    #command = "mysqldump -h mysql-htdev -u mdp -p#{mdp_pw} pulintz_mdp holdings_htitem_htmember_jn_dev -w\"member_id='#{mid}'\" --skip-add-drop-table --skip-opt --no-create-info | mysql -h mysql-sdr -u ht_repository -p#{htrep_pw} ht_repository"
    command = "mysqldump -h mysql-htdev -u ht_repository -p#{htrep_pw} pulintz_ht holdings_htitem_htmember_jn_dev -w\"member_id='#{mid}'\" --skip-add-drop-table --skip-disable-keys --skip-add-locks --skip-lock-tables --no-create-info | mysql -h mysql-sdr -u ht_repository -p#{htrep_pw} ht_repository"
    puts "#{count}: processing #{mid}..."
    ta = Time.new
    system(command)
    tb = Time.new
    sleeptime = (tb-ta)/2;
    if sleeptime > 600
      sleeptime = 600
    end
    puts "Timechange = #{sleeptime}\n" 
    sleep(sleeptime);
  end
end
  
export_data_files()
