require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### utah ###

# mono
utah_mono_cols = {
  :oclc => 2, 
  :local_id => 0
}
#mapper = MemberScrub::ColumnMapping.new(utah_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'utah', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :header_lines=>1)

# serial   
utah_serial_cols = {
  :oclc => 2, 
  :local_id => 0,
  :issn => 1
}                                        
mapper = MemberScrub::ColumnMapping.new(utah_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'utah', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
