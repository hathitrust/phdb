require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### uh  ###

# mono
uh_mono_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 3,
  :condition => 4
}
mapper = MemberScrub::ColumnMapping.new(uh_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'uh', :mapper=>mapper, :data_type=>'mono', :min_cols=>3, :header_lines=>1)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])


uh_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :enum_chron => 5,
  :status => 3
}
#mapper = MemberScrub::ColumnMapping.new(uh_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'uh', :mapper=>mapper, :data_type=>'multi', :min_cols=>3, :header_lines=>1)


# serial
uh_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 3
}                                        
#mapper = MemberScrub::ColumnMapping.new(uh_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'uh', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
