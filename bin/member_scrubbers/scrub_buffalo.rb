require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### buffalo  ###

# mono
buffalo_mono_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(buffalo_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'buffalo', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :header_lines=>1)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])


buffalo_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :enum_chron => 2
}
#mapper = MemberScrub::ColumnMapping.new(buffalo_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'buffalo', :mapper=>mapper, :data_type=>'multi', :min_cols=>2, :header_lines=>1)


# serial
buffalo_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(buffalo_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'buffalo', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
