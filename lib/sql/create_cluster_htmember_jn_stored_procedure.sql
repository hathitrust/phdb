DELIMITER //

CREATE PROCEDURE LoadClusterHtmemberJn()
BEGIN
	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'arizona';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
	SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
	WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'asu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
	SELECT DISTINCT cluster_id, member_id FROM	holdings_cluster_oclc, holdings_memberitem
	WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'baylor';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM      holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'bc';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'berkeley';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'brandeis';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
	WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'bu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
	SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'calgary';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'chi';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'cmu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'columbia';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'cornell';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'dart';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'duke';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'emory';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'fsu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'getty';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'harvard';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'iastate';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ind';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'iowa';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'jhu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ksu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ku';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'lafayette';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'loc';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'mcgill';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'miami';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'minn';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
	SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
	WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'missouri';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'mit';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'msu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'nccu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ncsu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
	WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'nd';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'nwu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'nypl';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'nyu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'osu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ou';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'pitt';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'prnc';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'psu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'purd';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'stanford';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'syr';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'tamu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
	SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'tufts';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
	SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ualberta';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucdavis';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uci';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucla';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucmerced';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
	WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uconn';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucr';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucsb';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucsc';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucsd';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ucsf';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'udel';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'ufl';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uh';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uic';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uiuc';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'umd';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'unc';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
	SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
	WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'unl';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uom';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'upenn';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'usu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'utah';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uva';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'uvm';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'vanderbilt';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'vt';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'washington';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'wfu';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'wisc';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'wustl';

	INSERT INTO holdings_cluster_htmember_jn (cluster_id, member_id)
        SELECT DISTINCT cluster_id, member_id FROM holdings_cluster_oclc, holdings_memberitem
        WHERE holdings_cluster_oclc.oclc = holdings_memberitem.oclc AND member_id = 'yale';

END //
DELIMITER ;
