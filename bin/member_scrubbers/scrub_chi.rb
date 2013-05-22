require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### chi ###

# mono
chi_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 3,
  :enum_chron => 2
}
#mapper = MemberScrub::ColumnMapping.new(chi_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'chi', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>3)

# serial   
chi_serial_cols = {
  :oclc => 0, 
  :local_id => 1
}                                        
mapper = MemberScrub::ColumnMapping.new(chi_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'chi', :mapper=>mapper, :data_type=>'serial',
                                            :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
