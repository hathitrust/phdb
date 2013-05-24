data = load '$INPUT' as (ocn:long, bib:chararray, member_id:chararray, status:chararray, condition:chararray, date:chararray, enum_chron:chararray, type:chararray, issn:chararray);
ocn_member_data = foreach data generate ocn, member_id, bib, type;
grouped_ocn = group ocn_member_data by ocn PARALLEL 4;
filtered_ocn = foreach grouped_ocn {
  mid = ocn_member_data.member_id;
  bib = ocn_member_data.bib;
  typ = ocn_member_data.type;
  uniq_mid = distinct mid;
  uniq_typ = distinct typ;
  generate group, uniq_mid, bib, uniq_typ;
};
store filtered_ocn into '$OUTPUT';
