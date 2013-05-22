require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### stanford ###

# mono
stanford_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2,
  :enum_chron => 3
}
mapper = MemberScrub::ColumnMapping.new(stanford_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'stanford', :mapper=>mapper, :data_type=>'mono', :min_cols=>3)

# serial   
stanford_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
#mapper = MemberScrub::ColumnMapping.new(stanford_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'stanford', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
