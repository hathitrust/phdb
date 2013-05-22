require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### olemiss  ###

# mono
olemiss_mono_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(olemiss_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'olemiss', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :header_lines=>1)


olemiss_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(olemiss_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'olemiss', :mapper=>mapper, :data_type=>'multi', :min_cols=>2, :header_lines=>1)


# serial
olemiss_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(olemiss_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'olemiss', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
