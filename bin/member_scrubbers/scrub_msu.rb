require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### MSU ###
msu_mono_cols = {
  :oclc => 0, 
  :local_id => 1
}

# mono
mapper = MemberScrub::ColumnMapping.new(msu_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'msu', :mapper=>mapper, :data_type=>'mono', :min_cols=>2, :header_lines=>1, :delim=>'^')

# serial                                           

msu_serial_cols = {
  :oclc => 0,
  :local_id => 2,
  :issn => 1
}

#mapper = MemberScrub::ColumnMapping.new(msu_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'msu', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1, :delim=>'^')

scrubber.process_data(ARGV[0], ARGV[1])
