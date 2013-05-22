require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### yale ###

# mono
yale_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 3,
  :status => 4
}
#yale_law_mono_cols = {
#  :oclc => 0,
#  :local_id => 1
#}
mapper = MemberScrub::ColumnMapping.new(yale_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'yale', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :delim=>'|')
#mapper = MemberScrub::ColumnMapping.new(yale_law_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'yale', :mapper=>mapper, :data_type=>'mono', :min_cols=>2)


# multi
#yale_multi_cols = {
#  :oclc => 0, 
#  :local_id => 1,
#  :enum_chron => 2,
#  :status => 3
#}                    
#mapper = MemberScrub::ColumnMapping.new(yale_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'yale', :mapper=>mapper, :data_type=>'multi',
#                                           :min_cols=>2)
#scrubber.process_data(ARGV[0], ARGV[1])

# serial
yale_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
#mapper = MemberScrub::ColumnMapping.new(yale_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'yale', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>2, :delim=>"|")

scrubber.process_data(ARGV[0], ARGV[1])
