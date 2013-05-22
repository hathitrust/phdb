require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### columbia ###

# mono
columbia_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 3,
  :enum_chron => 2,
  :condition => 4
}
mapper = MemberScrub::ColumnMapping.new(columbia_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'columbia', :mapper=>mapper, :data_type=>'mono', 
                                           :min_cols=>3, :header_lines=>1)

# serial   
columbia_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
#mapper = MemberScrub::ColumnMapping.new(columbia_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'columbia', :mapper=>mapper, :data_type=>'serial',
#                                           :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
