require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### baylor ###

# mono
baylor_mono_cols = {
  :oclc => 0, 
  :local_id => 4,
  :status => 5
}
#mapper = MemberScrub::ColumnMapping.new(baylor_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'baylor', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>3, :header_lines=>1)

# serial   
baylor_serial_cols = {
  :oclc => 0, 
  :local_id => 3,
  :issn => 4
}                                        
mapper = MemberScrub::ColumnMapping.new(baylor_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'baylor', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>4, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
