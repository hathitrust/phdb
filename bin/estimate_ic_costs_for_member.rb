require 'phdb/cost_estimator'

#AVE_COST_PER_VOL = 0.186944845716613
#AVE_COST_PER_VOL = 0.181453094142357  # june 2012
#AVE_COST_PER_VOL = 0.180579876387534  # july 2012
#AVE_COST_PER_VOL = 0.179096979710214  # sept 2012
#AVE_COST_PER_VOL = 0.177889350984018  # nov 2012
#AVE_COST_PER_VOL = 0.177532249781885  # dec 2012
#AVE_COST_PER_VOL = 0.165692620281601  # jan 2013
#AVE_COST_PER_VOL = 0.165335669929596 # feb 2013
#AVE_COST_PER_VOL = 0.164977764010886  # march 2013
#AVE_COST_PER_VOL = 0.16478905170822647 # april 2013
AVE_COST_PER_VOL = 0.163766430419597  # may 2013

if ARGV.length != 3
  puts "Usage: ruby calc_ic_costs_for_member.rb <memberitem_table> <volume_id_table> <ave cost_per_vol>\n"
  puts "Current average cost per volume = $#{AVE_COST_PER_VOL}."
  exit
end

member_data_table = ARGV[0]
volume_id_file = ARGV[1]
ave_cost_per_vol = ARGV[2].to_f

estimator = PHDBUtils::CostEstimator.new(member_data_table)

cost = estimator.estimate_cost(ave_cost_per_vol, 1, volume_id_file)
cost_str = "%.2f" % cost
puts "total ic cost = $#{cost_str}"

puts "done."
