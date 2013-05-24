data = load '$INPUT' as (ocn:long, bib:chararray, member_id:chararray, status:chararray, condition:chararray, date:chararray, enum_chron:chararray, type:chararray, issn:chararray);
ocn_member_data = foreach data generate ocn, member_id;
grouped_ocn = group ocn_member_data by ocn;
filtered_ocn = foreach grouped_ocn {
  mid = ocn_member_data.member_id;
  uniq_mid = distinct mid;
  generate group, uniq_mid, COUNT(uniq_mid);
};
store filtered_ocn into '$OUTPUT';
