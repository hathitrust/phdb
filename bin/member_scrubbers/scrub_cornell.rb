require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### cornell ###

# mono
cornell_mono_cols = {
  :oclc => 1, 
  :local_id => 0,
  :status => 3,
  :enum_chron => 2
}
#mapper = MemberScrub::ColumnMapping.new(cornell_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'cornell', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>3, :header_lines=>1)

# serial   
cornell_serial_cols = {
  :oclc => 1, 
  :local_id => 0,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(cornell_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'cornell', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
