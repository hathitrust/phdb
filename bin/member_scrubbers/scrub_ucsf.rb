require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### ucsf  ###

# mono
ucsf_mono_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 3
}
#mapper = MemberScrub::ColumnMapping.new(ucsf_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ucsf', :mapper=>mapper, :data_type=>'mono',
#                                           :min_cols=>2, :header_lines=>1)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])


ucsf_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 3,
  :enum_chron => 4
}
#mapper = MemberScrub::ColumnMapping.new(ucsf_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ucsf', :mapper=>mapper, :data_type=>'multi', :min_cols=>2, :header_lines=>1)


# serial
ucsf_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 3, 
  :enum_chron => 4, 
  :issn => 5
}                                        
mapper = MemberScrub::ColumnMapping.new(ucsf_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ucsf', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
