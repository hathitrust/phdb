require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### wustl ###

# mono
#wustl_mono_cols_med = {
#  :oclc => 1, 
#  :local_id => 0
#}
wustl_mono_cols = {
  :oclc => 0,
  :local_id => 1
}
mapper = MemberScrub::ColumnMapping.new(wustl_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'wustl', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :delim=>'\t')
#mapper = MemberScrub::ColumnMapping.new(wustl_mono_cols_med)                     
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'wustl', :mapper=>mapper, :data_type=>'mono', :min_cols=>2)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])

# multi
wustl_multi_cols_med = {
  :oclc => 1,
  :local_id => 0
}
#wustl_multi_cols = {
#  :oclc => 0, 
#  :local_id => 1
#}                    
#mapper = MemberScrub::ColumnMapping.new(wustl_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'wustl', :mapper=>mapper, :data_type=>'multi', :min_cols=>2, :delim=>'\t')
#mapper = MemberScrub::ColumnMapping.new(wustl_multi_cols_med)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'wustl', :mapper=>mapper, :data_type=>'multi', :min_cols=>2, :header_lines=>1)

# serial
wustl_serial_cols_med = {
  :oclc => 1,
  :local_id => 0,
  :issn => 2
}
#wustl_serial_cols = {
#  :oclc => 0, 
#  :local_id => 1,
#  :issn => 2
#}                                        
#mapper = MemberScrub::ColumnMapping.new(wustl_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'wustl', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :delim=>'\t')
#mapper = MemberScrub::ColumnMapping.new(wustl_serial_cols_med)     
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'wustl', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
