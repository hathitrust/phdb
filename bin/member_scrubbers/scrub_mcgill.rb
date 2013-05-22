require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### mcgill ###

# mono
mcgill_mono_cols = {
  :oclc => 0, 
  :local_id => 1,
  :status => 2
}
#mapper = MemberScrub::ColumnMapping.new(mcgill_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'mcgill', :mapper=>mapper, :data_type=>'mono', :min_cols=>2)


# multi
mcgill_multi_cols = {
  :oclc => 0, 
  :local_id => 1,
  :enum_chron => 2,
  :status => 3
}                    
#mapper = MemberScrub::ColumnMapping.new(mcgill_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'mcgill', :mapper=>mapper, :data_type=>'multi', :min_cols=>2)

# serial
mcgill_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(mcgill_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'mcgill', :mapper=>mapper, :data_type=>'serial',:min_cols=>2)


scrubber.process_data(ARGV[0], ARGV[1])
