DELIMITER //

CREATE PROCEDURE LoadHTItemHTMemberJn()
BEGIN
	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
	FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc	AND h.volume_id	= ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'arizona';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'asu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'baylor';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'bc';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'berkeley';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'brandeis';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'brown';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'bu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'calgary';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'chi';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'cmu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'columbia';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'cornell';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'dart';
	
	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'duke';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'emory';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'fsu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'getty';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'harvard';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'iastate';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ind';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'iowa';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'jhu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ksu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ku';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'lafayette';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'loc';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'mcgill';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'miami';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'minn';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'missouri';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'mit';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'msu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'nccu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ncsu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'nd';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'nwu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'nypl';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'nyu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'osu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ou';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'pitt';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'prnc';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'psu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'purd';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'stanford';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'syr';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'tamu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'tufts';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ualberta';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucdavis';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uci';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucla';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucmerced';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uconn';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucr';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucsb';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucsc';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucsd';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ucsf';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'udel';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'ufl';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uh';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uic';
	
	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uiuc';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'umd';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'unc';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'unl';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uom';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'upenn';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'usu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'utah';
	
	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uva';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'uvm';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
        WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'vanderbilt';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'vt';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'washington';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'wfu';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'wisc';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'wustl';

	INSERT IGNORE INTO holdings_htitem_htmember_jn (volume_id, member_id, copy_count, lm_count, wd_count, brt_count, access_count)
        SELECT ho.volume_id, mc.member_id, mc.copy_count, mc.lm_count, mc.wd_count, mc.brt_count, mc.access_count
        FROM holdings_htitem_oclc as ho, holdings_memberitem_counts as mc, holdings_htitem as h
	WHERE ho.oclc = mc.oclc AND h.volume_id = ho.volume_id AND NOT h.item_type = 'multi'
        AND mc.member_id = 'yale';

END //
DELIMITER ;
