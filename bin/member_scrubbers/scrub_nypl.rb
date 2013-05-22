require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### nypl ###

# mono
nypl_mono_cols = {
  :oclc => 1, 
  :local_id => 0
}
#mapper = MemberScrub::ColumnMapping.new(nypl_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'nypl', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>2)
#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])

# multi
nypl_multi_cols = {
  :oclc => 1, 
  :local_id => 0
}                                        
#mapper = MemberScrub::ColumnMapping.new(nypl_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'nypl', :mapper=>mapper, :data_type=>'multi',
#                                           :min_cols=>2)
#scrubber.process_data(ARGV[0], ARGV[1])

# serial
nypl_serial_cols = {
  :oclc => 1, 
  :local_id => 0
}                                        
mapper = MemberScrub::ColumnMapping.new(nypl_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'nypl', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2)
scrubber.process_data(ARGV[0], ARGV[1])
