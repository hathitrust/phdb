require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### usgs  ###

# mono
usgs_mono_cols = {
  :oclc => 0
}
mapper = MemberScrub::ColumnMapping.new(usgs_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'usgs', :mapper=>mapper, :data_type=>'mono', :min_cols=>1)


usgs_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :enum_chron => 2
}
#mapper = MemberScrub::ColumnMapping.new(usgs_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'usgs', :mapper=>mapper, :data_type=>'multi', :min_cols=>2)


# serial
usgs_serial_cols = {
  :oclc => 0
}                                        
#mapper = MemberScrub::ColumnMapping.new(usgs_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'usgs', :mapper=>mapper, :data_type=>'serial', :min_cols=>1)

scrubber.process_data(ARGV[0], ARGV[1])
