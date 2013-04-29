require 'phdb/cost_calculator'

# Need to work from a total operating cost number
# 2012-2013 number is $1,759,734
TOTAL_OP_COST = 1759734.0

ave_cost_per_vol = PHDBUtils.calc_ave_cost_per_vol(TOTAL_OP_COST)

member_ids = PHDBUtils.get_member_list()
total_members = member_ids.length + 2
#total_members = member_ids.length - 1
puts "Calculating PD cost based on #{total_members} members."

public_costs = PHDBUtils.calc_pd_costs(ave_cost_per_vol)
sum = 0.0
public_costs.each { |a| sum+=a }
#per_member = sum/(total_members+1)
per_member = sum/(total_members)

puts "Public domain costs:"
puts "\tSinglepart Monos: $#{public_costs[0]}"
puts "\tSerials: $#{public_costs[1]}"
puts "\tMultipart Monos: $#{public_costs[2]}"
puts "\tTotal public domain costs: $#{sum}"
puts "\tPublic domain cost per member: $#{per_member} (#{per_member*1.5})"

puts "done."
