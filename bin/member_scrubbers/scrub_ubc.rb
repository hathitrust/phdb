require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### ubc ###

# mono
ubc_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2,
  :condition => 3
}
#mapper = MemberScrub::ColumnMapping.new(ubc_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ubc', :mapper=>mapper, :data_type=>'mono', :min_cols=>2)


# multi                                                                                      
ubc_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :enum_chron => 4,
  :status => 2,
  :condition => 3
}
#mapper = MemberScrub::ColumnMapping.new(ubc_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ubc', :mapper=>mapper, :data_type=>'multi', :min_cols=>3)



# serial   
ubc_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(ubc_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'ubc', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
