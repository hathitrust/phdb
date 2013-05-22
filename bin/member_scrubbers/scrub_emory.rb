require './MemberScrubber.rb'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### emory ###

# mono
emory_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 3
}
#mapper = MemberScrub::ColumnMapping.new(emory_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'emory', :mapper=>mapper, :data_type=>'mono', :min_cols=>4, :delim=>'|', :header_lines=>1)
#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])

# serial   
emory_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 3
}                                        
mapper = MemberScrub::ColumnMapping.new(emory_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'emory', :mapper=>mapper, :data_type=>'serial',:min_cols=>3, :header_lines=>1, :delim=>'|')

scrubber.process_data(ARGV[0], ARGV[1])
