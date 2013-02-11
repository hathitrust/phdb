require 'phdb/phdb_utils'

pw = PHDBUtils.get_password_from_file('/htapps/pulintz.babel/Code/phdb/etc/ht_repository')

command = "mysqldump -h mysql-htdev -u pulintz -p pulintz_mdp holdings_deltas --no-create-info --skip-disable-keys --skip-add-drop-table --skip-lock-tables --skip-add-locks | mysql -h mysql-sdr -u ht_repository -p#{pw} ht_repository"
#puts command
system(command)
puts "done."
