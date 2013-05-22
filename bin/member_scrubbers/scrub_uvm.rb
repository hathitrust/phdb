require './MemberScrubber'
#require './HTFileParser.rb'

if ARGV.length != 2
  puts "Usage: ruby scrub.rb <infile> <outfile>\n"
end


### uvm  ###

# mono
uvm_mono_cols = {
  :oclc => 0,
  :local_id => 1
}
#mapper = MemberScrub::ColumnMapping.new(uvm_mono_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'uvm', :mapper=>mapper, :data_type=>'mono', :min_cols=>2)


uvm_multi_cols = {
  :oclc => 0,
  :local_id => 1,
  :enum_chron => 2
}
#mapper = MemberScrub::ColumnMapping.new(uvm_multi_cols)
#scrubber = MemberScrub::MemberScrubber.new(:member_id=>'uvm', :mapper=>mapper, :data_type=>'multi', :min_cols=>2)


# serial
uvm_serial_cols = {
  :oclc => 0, 
  :local_id => 1,
  :issn => 2
}                                        
mapper = MemberScrub::ColumnMapping.new(uvm_serial_cols)
scrubber = MemberScrub::MemberScrubber.new(:member_id=>'uvm', :mapper=>mapper, :data_type=>'serial', :min_cols=>2)

scrubber.process_data(ARGV[0], ARGV[1])
