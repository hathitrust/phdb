require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### usu ###

# mono
usu_mono_cols = {
  :oclc => 1, 
  :local_id => 0
}
mapper = MemberScrub::ColumnMapping.new(usu_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'usu', :mapper=>mapper, :data_type=>'mono', 
                                           :min_cols=>2)
#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])

# serial   
usu_serial_cols = {
  :oclc => 1, 
  :local_id => 0,
  :issn => 2,
  :status => 6,
  :enum_chron => 4
}                                        
#mapper = MemberScrub::ColumnMapping.new(usu_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'usu', :mapper=>mapper, :data_type=>'serial',
#                                           :min_cols=>3, :header_lines=>1)
scrubber.process_data(ARGV[0], ARGV[1])
