require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end

### cmu  ###

# mono
cmu_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 3,
  :condition => 4
}
#mapper = MemberScrub::ColumnMapping.new(cmu_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'cmu', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :delim=>',')


# multi                                                                                      
cmu_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :enum_chron => 2,
  :status => 3,
  :condition => 4
}
#mapper = MemberScrub::ColumnMapping.new(cmu_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'cmu', :mapper=>mapper, :data_type=>'multi', :min_cols=>3)



#parser = PHDBUtils::MemberFileParser.new
#tmpfilen = ARGV[0] + ".tmp"
#parser.label_multipart(ARGV[0], tmpfilen)
#scrubber.process_data(tmpfilen, ARGV[1])
#scrubber.process_data(ARGV[0], ARGV[1])

# serial   
cmu_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 3,
  :issn =>6
}                                        
mapper = MemberScrub::ColumnMapping.new(cmu_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'cmu', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :delim=>',')

scrubber.process_data(ARGV[0], ARGV[1])
