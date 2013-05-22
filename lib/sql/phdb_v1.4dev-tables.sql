USE ht_repository;
BEGIN;
CREATE TABLE `holdings_htitem` (
    `volume_id` varchar(50) NOT NULL PRIMARY KEY,
    `access` varchar(20) NOT NULL,
    `rights` varchar(16) NOT NULL,
    `um_record` integer NOT NULL,
    `enum_chron` varchar(200),
    `source` varchar(16) NOT NULL,
    `institution_id` varchar(75) NOT NULL,
    `oclcs` varchar(75) NOT NULL,
    `reason_code` varchar(50) NOT NULL,
    `update_date` timestamp NOT NULL,
    `item_type` varchar(20),
    `total_size` bigint(20),
    `n_enum` varchar(60),
    `n_chron` varchar(60),
    `gov_doc` boolean, 
    `pub_date` int,
    `pub_place` varchar(5),
    `lang` varchar(5),
    `bib_format` varchar(5)
);

CREATE TABLE `holdings_htmember` (
    `member_id` varchar(20) NOT NULL PRIMARY KEY,
    `member_name` varchar(100) NOT NULL,
    `member_parent` VARCHAR(20),
    `oclc_sym` varchar(10),
    `marc21_sym` varchar(10),
    `status` smallint NOT NULL
);

CREATE TABLE `holdings_memberitem` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `oclc` bigint NOT NULL,
    `local_id` varchar(50) NOT NULL,
    `member_id` varchar(20) NOT NULL,
    `status` varchar(20),
    `item_condition` varchar(20),
    `process_date` date NOT NULL,
    `enum_chron` varchar(100),
    `item_type` varchar(20),
    `issn` varchar(50),
    `n_enum` varchar(60),
    `n_chron` varchar(60)
);

CREATE TABLE `holdings_cluster` (
    `cluster_id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `cost_rights_id` smallint NOT NULL,
    `osici` varchar(60),
    `last_mod` datetime,
    `H` smallint,
    `total_serial_size` bigint,
    `cluster_type` varchar(15),
    `num_of_items` smallint
);

CREATE TABLE `holdings_cluster_oclc` (
    `cluster_id` bigint NOT NULL,
    `oclc` bigint  NOT NULL,
    PRIMARY KEY (cluster_id, oclc)
);

CREATE TABLE `holdings_cluster_htitem_jn` (
    `cluster_id` bigint NOT NULL,
    `volume_id` varchar(50) NOT NULL,
    PRIMARY KEY (cluster_id, volume_id)
);

CREATE TABLE `holdings_htitem_oclc` (
    `volume_id` varchar(50) NOT NULL,
    `oclc` bigint NOT NULL,
    `origin` smallint NOT NULL,
    PRIMARY KEY (volume_id, oclc)
);

CREATE TABLE `holdings_cluster_htmember_jn` (
    `cluster_id` bigint NOT NULL,
    `member_id` varchar(20)  NOT NULL,
    PRIMARY KEY (cluster_id, member_id)
);

CREATE TABLE `holdings_htitem_htmember_jn` (
    `volume_id` varchar(50) NOT NULL,
    `member_id` varchar(20)  NOT NULL,
    `copy_count` int,
    `lm_count` smallint,
    `wd_count` smallint,
    `brt_count` smallint,
    `access_count` smallint,
    PRIMARY KEY (volume_id, member_id)
);

CREATE TABLE `holdings_H_counts` (
    `H_id` smallint NOT NULL,
    `member_id` varchar(20) NOT NULL,
    `access` varchar(10) NOT NULL,
    `item_type` varchar(8) NOT NULL,
    `H_count` int  NOT NULL,
    PRIMARY KEY (H_id, member_id, access, item_type)
);


CREATE TABLE `holdings_htitem_H` (
    `volume_id` varchar(50) NOT NULL PRIMARY KEY,
    `H` int
);

CREATE TABLE `memberitem_counts` (
    `oclc` bigint NOT NULL,
    `member_id` varchar(20) NOT NULL,
    `copy_count` int,
    `lm_count` smallint,
    `wd_count` smallint,
    `brt_count` smallint,
    `access_count` smallint,
    PRIMARY KEY (oclc, member_id)
);

CREATE TABLE `holdings_deltas` (
    `volume_id` varchar(50) NOT NULL,
    `version` int NOT NULL,
    `update_date` date NOT NULL, 
    PRIMARY KEY (volume_id, version)
);
