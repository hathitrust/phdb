require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### miami ###

# mono
miami_mono_cols = {
  :oclc => 1,
  :status => 0,
  :local_id => 2
}
#mapper = MemberScrub::ColumnMapping.new(miami_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'falc', :mapper=>mapper, :data_type=>'mono', :min_cols=>2)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])


miami_multi_cols = {
  :oclc => 3, 
  :local_id => 4,
  :enum_chron => 1,
  :status => 0
}
#mapper = MemberScrub::ColumnMapping.new(miami_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'falc', :mapper=>mapper, :data_type=>'multi', :min_cols=>2)



# serial
miami_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(miami_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'falc', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
