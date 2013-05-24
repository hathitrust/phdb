require 'phdb/phdb_utils'

#if ARGV.length != 1
#  puts "Usage: ruby runner.rb <outfile>\n"
#end

### pull out NYU multipart overlap data ###
#query = "select distinct(mm.local_id), chm.oclc, chm.n_enum, ch.H from memberitem_multi as mm 
#         inner join cluster_htmember_multi as chm on mm.oclc = chm.oclc 
#         inner join cluster_H_multi as ch on chm.cluster_id = ch.cluster_id 
#         where mm.member_id = 'nyu' and mm.n_enum = chm.n_enum and ch.n_enum = chm.n_enum;"
   
### grab multipart memberitems that have changed ###
#query = "select * from memberitem_serial left join memberitem_multi on memberitem_multi.id = memberitem_serial.id where memberitem_multi.id IS NULL and memberitem_serial.item_type = 'multi'"
        
### grab multipart items from memberitem and memberitem_serial ###                
#outfilen = "memberitem_multis_20120907.txt"
#query = "select * from memberitem where item_type = 'multi'"
#query = "select * from memberitem_serial where item_type = 'multi'"
#PHDBUtils.pull_query(query, outfilen)

### nyu final report ###
#query = "select * from nyu_report2"

### count report queries ###
#outfilen = "matching_member_counts.120721.out"
#query = "select member_id, item_type, count(*) from memberitem group by member_id, item_type"
#puts "Member Counts"
#PHDBUtils.pull_query(query, "total_member_counts.121113.out")
#puts "Item Counts"
#PHDBUtils.print_matching_item_counts("matching_item_counts.121113.out")
#puts "Oclc Counts"
#PHDBUtils.print_matching_oclc_counts("matching_oclc_counts.121113.out")

### query for WUSTL report ###
#query = "select hhj.volume_id, ho.oclc, m.local_id, hh.H from htitem_htmember_jn as hhj, htitem_oclc as ho, htitem_H as hh, memberitem as m where hhj.volume_id = ho.volume_id and hhj.volume_id = hh.volume_id and ho.oclc = m.oclc and hhj.member_id = m.member_id and hhj.member_id = 'wustl'"
#outfilen = "wustl-june12-matches.txt"

#PHDBUtils.pull_query(query, outfilen)

### query to supplement the cost estimation ###
#query = "SELECT DISTINCT ho.volume_id FROM htitem_oclc as ho, 
#         htitem as h, memberitem_wfu as mt
#         WHERE ho.oclc = mt.oclc 
#         AND h.volume_id = ho.volume_id
#         AND h.access = 'deny'"

#query = "select * from H_counts where member_id = 'wustl'"
#PHDBUtils.pull_query(query, "wustl-Hcounts-20120627.txt")

#PHDBUtils.pull_query(query, "memberitem_wfu-volume_id.out")

### WUSTL PROBLEM ###
#query = "select ho.volume_id from htitem_oclc as ho, cluster_oclc as co, cluster_htmember_jn as chj where ho.oclc = co.oclc and co.cluster_id = chj.cluster_id and member_id = 'wustl' and ho.volume_id not in (select volume_id from htitem_htmember_jn where member_id = 'wustl');"

#query = "select hhj.volume_id, co.oclc, m.local_id, hh.H from htitem_htmember_jn as hhj, cluster_htitem_jn as chj, cluster_oclc as co, memberitem as m, htitem_H as hh where hhj.volume_id = chj.volume_id and chj.cluster_id = co.cluster_id and co.oclc = m.oclc and hhj.member_id = m.member_id and hhj.volume_id = hh.volume_id and hhj.member_id = 'wustl'"

#query = "select distinct(volume_id), oclc, local_id, H from test_wustl order by local_id"
#outfilen = "wustl-june2012-report.txt"


### Texas Christian Estimation ###
#query = "SELECT DISTINCT ho.volume_id FROM htitem_oclc as ho, htitem as h, memberitem_texas as mt WHERE ho.oclc = mt.oclc AND h.volume_id = ho.volume_id AND h.access = 'deny'"
#outfilen = "memberitem_tcu-volume_id.out"


### !!!!!!!!!  ###
### HCounts query
#query = "select member_id, access, item_type, sum(H_count) from holdings_H_counts group by member_id, access, item_type"
#outfilen = "HCounts_query.20130417.tsv"
#PHDBUtils.pull_query(query, outfilen)

#query2 = "select member_id, count(distinct hm.oclc) from holdings_memberitem as hm, holdings_htitem_oclc as hho where hm.oclc = hho.oclc group by member_id;"
#outfilen = "oclc_match_query.20130417.tsv"
#PHDBUtils.pull_query(query2, outfilen)
### !!!!!!!!! ###


### HathiTrust AWS Dataset Generation ###
#outfilen = "HT003_HATHI.sept12.tsv"
#PHDBUtils.generate_HT_AWS_file(outfilen)

### HathiTrust AWS Dataset Generation - Cali (Oct 9, 2012) ###
#outfilen = "HT003_HAtHI_CALI.sept12.tsv"
#PHDBUtils.generate_HT_AWS_file(outfilen)

### Query to pull all no-oclc california items
#query = "select volume_id, item_type from htitem where length(oclcs) < 1 and source = 'UC'"
#outfilen = "Cali-noOCN.20121010.tsv"

### pull H_counts table
#query = "select * from H_counts"
#outfilen = "HCounts_201209.tsv"
#PHDBUtils.pull_query(query, outfilen)

### pull htmember data 
#query = "select member_id, member_name from htmember order by member_id"
#outfilen = "htmember_201209.tsv"
#PHDBUtils.pull_query(query, outfilen)

### load all memberitem data ###
#my_dir = '/htapps/pulintz.babel/data/phdb/HT003'
#PHDBUtils.load_all_data_into_memberitem(my_dir)

### one-off ufl op query ###
#query = "select distinct(m.local_id), m.oclc, hhj.volume_id from memberitem as m, htitem_htmember_jn as hhj, htitem_oclc as ho where m.oclc = ho.oclc and ho.volume_id = hhj.volume_id and m.member_id = 'ufl' and hhj.volume_id in (select volume_id from htitem where rights = 'op')"
#PHDBUtils.pull_query(query, "UFL-OP-query.txt")

### one-off ucm query ###
#query = "select * from holdings_htitem_htmember_jn where member_id = 'ucm'"
#PHDBUtils.pull_query(query, "UCMhhj.201304.txt")


### one-off 'con' queries for Angelina ###
#query1 = "select h.volume_id, h.item_type, h.oclcs, chj.cluster_id, h.reason_code from holdings_cluster_htitem_jn as chj, holdings_htitem as h where chj.volume_id = h.volume_id and cluster_id in (select cluster_id from holdings_cluster_htitem_jn as chj, holdings_htitem as h where chj.volume_id = h.volume_id and reason_code = 'con' and item_type = 'multi')"      
#query2 = "select * from pulintz_ht.holdings_conquery_tmp where cluster_id in (select cluster_id from pulintz_ht.holdings_conquery_tmp where reason_code != 'con')"                                                    
#PHDBUtils.pull_query(query2, "ConQuery.20130410.txt")

### one-off wustl query, 05/23/13 ###
query = "select hm.local_id, hm.oclc, hho.volume_id, hh.rights, hh.access from holdings_memberitem as hm, holdings_htitem_oclc as hho, holdings_htitem as hh where hh.volume_id = hho.volume_id and hho.oclc = hm.oclc and hm.member_id = 'wustl'"
PHDBUtils.pull_query(query, "Wustl_report.20130523.tsv")
