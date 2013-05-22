require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### upenn ###

# mono
upenn_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 2,
  :status => 3
}
#mapper = MemberScrub::ColumnMapping.new(upenn_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'upenn', :mapper=>mapper, :data_type=>'mono', :min_cols=>3, :header_lines=>1)


# serial   
upenn_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(upenn_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'upenn', :mapper=>mapper, :data_type=>'serial', :min_cols=>2, :header_lines=>1)

scrubber.process_data(ARGV[0], ARGV[1])
