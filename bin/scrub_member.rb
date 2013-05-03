require 'phdb/member_scrubber'

if ARGV.length != 3
  puts "Usage: ruby scrub.rb <member_id> <infile> <outfile>\n"
end


### set up the column mappings for the files ###
mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2
}

multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :status => 2,
  :enum_chron => 3
}

serial_cols = {
  :oclc => 0,
  :local_id => 1,
  :enum_chron => 2,
  :issn => 3
}

### create a column mapping ###
monomapper = MemberScrub::ColumnMapping.new(mono_cols)
#multimapper = MemberScrub::ColumnMapping.new(multi_cols)
#serialmapper = MemberScrub::ColumnMapping.new(serial_cols)


### create the parser ###
scrubber = MemberScrub::MemberScrubber.new(:member_id=>ARGV[0], :mapper=>monomapper, :data_type=>'mono', :min_cols=>2, :header_lines=>1)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>ARGV[0], :mapper=>multimapper, :data_type=>'multi', :min_cols=>2, :header_lines=>1)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>ARGV[0], :mapper=>serialmapper, :data_type=>'multi', :min_cols=>2, :header_lines=>1)


### parse the file ###  
scrubber.process_data(ARGV[1], ARGV[2])



