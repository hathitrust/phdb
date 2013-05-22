require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### dartmouth ###
# mono                                   
dartmouth_mono_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(dartmouth_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'dart', :mapper=>mapper, :data_type=>'mono',
#                                           :min_cols=>2, :header_lines=>1)

# multi
dartmouth_multi_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron =>2, 
  :status => 3
}
#mapper = MemberScrub::ColumnMapping.new(dartmouth_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'dart', :mapper=>mapper, :data_type=>'multi', 
#                                           :min_cols=>2, :header_lines=>1)

# serial   
dartmouth_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2,
  :status => 3
}                                        
mapper = MemberScrub::ColumnMapping.new(dartmouth_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'dart', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
