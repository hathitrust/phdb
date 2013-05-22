require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### asu ###

# mono
asu_mono_cols = {
  :oclc => 0, 
  :local_id => 1
}
#mapper = MemberScrub::ColumnMapping.new(asu_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'asu', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>1)

# serial   
asu_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(asu_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'asu', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
