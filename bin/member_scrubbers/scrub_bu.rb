require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### bu ###

# mono
bu_mono_cols = {
  :oclc => 0, 
  :local_id => 1
}
#mapper = MemberScrub::ColumnMapping.new(bu_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'bu', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>2)


#  multi
bu_multi_cols = {
  :oclc => 0, 
  :local_id => 1
}
#mapper = MemberScrub::ColumnMapping.new(bu_multi_cols)
##scrubber = MemberScrub::MemberScrubber.new(:member_id=>'bu', :mapper=>mapper, :data_type=>'multi', 
#                                           :min_cols=>2, :header_lines=>1)
                                           

# serial   
bu_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(bu_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'bu', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
