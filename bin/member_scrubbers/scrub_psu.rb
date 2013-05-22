require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### psu ###

# mono
psu_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 2, 
  :status => 3
}
#mapper = MemberScrub::ColumnMapping.new(psu_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'psu', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :delim=>'|')

# serial   
psu_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(psu_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'psu', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :delim=>'|')

scrubber.process_data(ARGV[0], ARGV[1])
