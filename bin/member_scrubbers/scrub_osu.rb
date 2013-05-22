require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### osu ###

# mono
osu_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2,
  :enum_chron => 3
}
#mapper = MemberScrub::ColumnMapping.new(osu_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'osu', :mapper=>mapper, :data_type=>'mono',# 
#                                           :min_cols=>2, :header_lines=>1)

# serial   
osu_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(osu_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'osu', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2, :header_lines=>1, :delim=>',')

scrubber.process_data(ARGV[0], ARGV[1])
