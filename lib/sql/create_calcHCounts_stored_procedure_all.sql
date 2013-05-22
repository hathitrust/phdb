DELIMITER //
CREATE PROCEDURE CalcHCounts()
BEGIN

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count) 
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id) 
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj 
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'arizona' 
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'asu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'baylor'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'bc'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'berkeley'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'brandeis'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'brown'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'bu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'calgary'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'chi'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'cmu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'columbia'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'cornell'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'dart'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'duke'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'emory'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'fsu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'getty'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'harvard'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'iastate'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ind'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'iowa'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'jhu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ksu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ku'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'lafayette'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'loc'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'mcgill'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'miami'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'minn'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'missouri'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'mit'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'msu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'nccu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ncsu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'nd'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'nwu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'nypl'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'nyu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'osu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ou'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'pitt'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'prnc'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'psu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'purd'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'stanford'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'syr'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'tamu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'tufts'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ualberta'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucdavis'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uci'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucla'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucmerced'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uconn'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucr'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucsb'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucsc'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucsd'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ucsf'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'udel'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'ufl'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uh'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uic'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uiuc'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'umd'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'unc'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'unl'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uom'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'upenn'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'usu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'utah'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uva'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'uvm'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'vanderbilt'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'vt'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'washington'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'wfu'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'wisc'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'wustl'
GROUP BY hh.H, h.access, h.item_type;

INSERT INTO holdings_H_counts (H_id, member_id, access, item_type, H_count)
SELECT hh.H, hhj.member_id, h.access, h.item_type, COUNT(DISTINCT hh.volume_id)
FROM holdings_htitem AS h, holdings_htitem_H AS hh, holdings_htitem_htmember_jn AS hhj
WHERE hh.volume_id = hhj.volume_id AND hh.volume_id = h.volume_id AND hhj.member_id = 'yale'
GROUP BY hh.H, h.access, h.item_type;

END //
DELIMITER ;
