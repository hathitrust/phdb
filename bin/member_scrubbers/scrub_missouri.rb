require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### missouri ###

# mono
missouri_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 2
}
#mapper = MemberScrub::ColumnMapping.new(missouri_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'missouri', :mapper=>mapper, :data_type=>'mono', :min_cols=>1)
#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])

# serial   
missouri_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(missouri_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'missouri', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)
scrubber.process_data(ARGV[0], ARGV[1])
