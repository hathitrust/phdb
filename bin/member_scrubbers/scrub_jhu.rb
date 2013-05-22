require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### jhu ###

# mono
jhu_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2,
  :enum_chron => 4
}
#mapper = MemberScrub::ColumnMapping.new(jhu_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'jhu', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>3, :header_lines=>1)


# multi
jhu_multi_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 4
}
#mapper = MemberScrub::ColumnMapping.new(jhu_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'jhu', :mapper=>mapper, :data_type=>'multi', 
#                                           :min_cols=>3)

# serial   
jhu_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(jhu_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'jhu', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
