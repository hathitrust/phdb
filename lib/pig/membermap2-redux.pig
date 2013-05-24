data = load '$INPUT' as (ocn:long, bib:chararray, member_id:chararray, status:chararray, condition:chararray, date:chararray, enum_chron:chararray, type:chararray, issn:chararray);
ocnmap = load 's3://umich-lib-phdb/input/x2.all.inv.txt' as (ocn0:long, ocn1:long);
omdata = foreach data generate ocn, member_id, bib, type;
jnd_data = join omdata by ocn left outer, ocnmap by ocn0;
filtered_joined = foreach jnd_data GENERATE (ocn1 is null ? ocn : ocn1) AS oclc, 
                   member_id, bib, type;
grouped_ocn = group filtered_joined by oclc PARALLEL 4;
filtered_ocn = foreach grouped_ocn {
  mid = filtered_joined.member_id;
  bib = filtered_joined.bib;
  typ = filtered_joined.type;
  uniq_mid = distinct mid;
  uniq_bib = distinct bib;
  uniq_typ = distinct typ;
  generate group, uniq_mid, uniq_bib, uniq_typ;
};
store filtered_ocn into '$OUTPUT';
