require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### ucsd ###

# mono
ucsd_mono_cols = {
  :oclc => 1,
  :local_id => 0,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(ucsd_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ucsd', :mapper=>mapper, :data_type=>'mono',:min_cols=>2, :header_lines=>1)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])


ucsd_multi_cols = {
  :oclc => 2,
  :local_id => 0,
  :status => 3,
  :enum_chron => 1
}
#mapper = MemberScrub::ColumnMapping.new(ucsd_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ucsd', :mapper=>mapper, :data_type=>'multi', :min_cols=>2, :header_lines=>1)


# serial
ucsd_serial_cols = {
  :oclc => 2, 
  :local_id => 0,
  :issn => 1,
  :status => 3
}                                        
mapper = MemberScrub::ColumnMapping.new(ucsd_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ucsd', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
