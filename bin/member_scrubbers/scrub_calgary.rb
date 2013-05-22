require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### calgary ###

# mono
calgary_mono_cols = {
  :oclc => 1, 
  :local_id => 0,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(calgary_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'calgary', :mapper=>mapper, :data_type=>'mono', 
#                                           :min_cols=>2, :delim=>'|')
#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])


# serial
calgary_serial_cols = {
  :oclc => 1, 
  :local_id => 0,
  :issn => 2,
  :status => 3
}                                        
mapper = MemberScrub::ColumnMapping.new(calgary_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'calgary', :mapper=>mapper, :data_type=>'serial',
                                           :min_cols=>2, :delim=>'|')
scrubber.process_data(ARGV[0], ARGV[1])
