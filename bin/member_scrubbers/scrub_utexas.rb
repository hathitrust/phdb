require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### utexas  ###

# mono
utexas_mono_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 2,
  :enum_chron => 3
}
#mapper = MemberScrub::ColumnMapping.new(utexas_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'utexas', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :long_lines=>6)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])


utexas_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 2,
  :enum_chron => 3
}
#mapper = MemberScrub::ColumnMapping.new(utexas_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'utexas', :mapper=>mapper, :data_type=>'multi', :min_cols=>3, :long_lines=>6)


# serial
utexas_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2,
  :issn => 3
}                                        
mapper = MemberScrub::ColumnMapping.new(utexas_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'utexas', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
