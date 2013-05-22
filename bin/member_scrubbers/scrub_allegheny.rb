require './MemberScrubber'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### ALLEGHENY ###                                                                                        
# mono  
allegheny_mono_cols = {
  :oclc => 0
}

mapper = MemberScrub::ColumnMapping.new(allegheny_mono_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'allegheny', :mapper=>mapper, :data_type=>'mono', :min_cols=>1)

# serial                                           
allegheny_serial_cols = {
  :oclc => 0
}

#mapper = MemberScrub::ColumnMapping.new(allegheny_serial_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'allegheny', :mapper=>mapper, :data_type=>'serial', :min_cols=>1)

scrubber.process_data(ARGV[0], ARGV[1])
