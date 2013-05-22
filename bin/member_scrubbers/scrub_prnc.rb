require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### prnc ###

# mono
prnc_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(prnc_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'prnc', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :header_lines=>1)

#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])

# serial   
prnc_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(prnc_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'prnc', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
