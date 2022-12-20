-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 20, 2022 at 04:42 PM
-- Server version: 5.7.40
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trcv2_model`
--

-- --------------------------------------------------------

--
-- Table structure for table `chemicals`
--

CREATE TABLE `chemicals` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL COMMENT 'primary key',
  `file_id` smallint(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'foreign key {files}',
  `orgnum` tinyint(3) UNSIGNED NOT NULL COMMENT 'nOrgNum in ThermoML',
  `substance_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL COMMENT 'foreign key {substances}',
  `sourcetype` enum('Commercial source','Synthesized by the authors','Synthesized by others','Standard Reference Material (SRM)','Isolated from a natural product','Not stated in the document','No sample used') COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'eSource in ThermoML',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table of chemicals from ThermoML files';

-- --------------------------------------------------------

--
-- Table structure for table `components`
--

CREATE TABLE `components` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `chemical_id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `mixture_id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `compnum` tinyint(2) UNSIGNED DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `conditions`
--

CREATE TABLE `conditions` (
  `id` mediumint(7) UNSIGNED ZEROFILL NOT NULL,
  `dataseries_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `datapoint_id` mediumint(7) UNSIGNED ZEROFILL DEFAULT NULL,
  `quantity_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `component_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `phase_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `property_name` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `datatype` enum('datum','array') COLLATE utf8mb4_bin NOT NULL DEFAULT 'datum',
  `number` mediumtext COLLATE utf8mb4_bin,
  `significand` mediumtext COLLATE utf8mb4_bin,
  `exponent` mediumtext COLLATE utf8mb4_bin,
  `error` mediumtext COLLATE utf8mb4_bin,
  `error_type` enum('absolute','relative','SD','%RSD','CI') COLLATE utf8mb4_bin DEFAULT NULL,
  `unit_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `accuracy` tinyint(2) DEFAULT NULL,
  `exact` tinyint(1) NOT NULL DEFAULT '0',
  `text` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `data`
--

CREATE TABLE `data` (
  `id` mediumint(8) UNSIGNED ZEROFILL NOT NULL,
  `datapoint_id` mediumint(7) UNSIGNED ZEROFILL DEFAULT NULL,
  `quantity_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `sampleprop_id` mediumint(7) UNSIGNED ZEROFILL DEFAULT NULL,
  `component_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `phase_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `property_name` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `datatype` enum('datum','array') COLLATE utf8mb4_bin NOT NULL DEFAULT 'datum',
  `number` mediumtext COLLATE utf8mb4_bin,
  `significand` mediumtext COLLATE utf8mb4_bin,
  `exponent` mediumtext COLLATE utf8mb4_bin,
  `error` mediumtext COLLATE utf8mb4_bin,
  `error_type` enum('absolute','relative','SD','%RSD','CI') COLLATE utf8mb4_bin NOT NULL DEFAULT 'absolute',
  `unit_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `accuracy` tinyint(2) DEFAULT NULL,
  `exact` tinyint(1) NOT NULL DEFAULT '0',
  `text` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `datapoints`
--

CREATE TABLE `datapoints` (
  `id` mediumint(7) UNSIGNED ZEROFILL NOT NULL,
  `dataseries_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `row_index` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `dataseries`
--

CREATE TABLE `dataseries` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `dataset_id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `type` enum('independent set','spectrum','chromatogram','kinetics trace','fiagram','free induction decay','error array','equation','independent value') COLLATE utf8mb4_bin NOT NULL,
  `idx` smallint(5) UNSIGNED NOT NULL,
  `points` smallint(5) UNSIGNED DEFAULT NULL,
  `comments` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Dataseries are part of a dataset and are made up of data' ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `datasets`
--

CREATE TABLE `datasets` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `title` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL,
  `setnum` smallint(3) UNSIGNED DEFAULT NULL,
  `report_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `system_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `trcidset_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `phase` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `points` smallint(5) UNSIGNED DEFAULT NULL,
  `comments` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Sets of property data about a chemical system' ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `trcid` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `title` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL,
  `abstract` varchar(4096) COLLATE utf8mb4_bin DEFAULT NULL,
  `reference_id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `filename` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='TRC Thermoml files';

-- --------------------------------------------------------

--
-- Table structure for table `identifiers`
--

CREATE TABLE `identifiers` (
  `id` mediumint(8) UNSIGNED ZEROFILL NOT NULL,
  `substance_id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `type` enum('inchi','inchikey','casrn','smiles','chemspiderId','pubchemId','iupacname','springerId','othername','csmiles','ismiles','wikidataid') COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(1024) COLLATE utf8mb4_bin NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='types of information about a substance that is used';

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` tinyint(3) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(4) COLLATE utf8mb4_bin DEFAULT NULL,
  `coden` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `issn` varchar(9) COLLATE utf8mb4_bin DEFAULT NULL,
  `set` varchar(8) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `language` set('Unknown','Afrikaans','Arabic','Chinese','Czech','Danish','Dutch','English','Finnish','French','German','Hungarian','Italian','Japanese','Korean','Norwegian','Polish','Portuguese','Romanian','Russian','Slovak','Spanish','Swedish','Taiwanese','Turkish') COLLATE utf8mb4_bin NOT NULL DEFAULT 'Unknown',
  `abbrev` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `publisher` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `homepage` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='FAD Journals';

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

CREATE TABLE `keywords` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `report_id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `term` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `check` tinyint(1) DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table of keywords in XML files';

-- --------------------------------------------------------

--
-- Table structure for table `mixtures`
--

CREATE TABLE `mixtures` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `system_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `dataset_id` mediumint(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `phases`
--

CREATE TABLE `phases` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `mixture_id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `phasetype_id` tinyint(2) UNSIGNED ZEROFILL NOT NULL,
  `orgnum` tinyint(2) UNSIGNED DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Join table for datasets and phases';

-- --------------------------------------------------------

--
-- Table structure for table `phasetypes`
--

CREATE TABLE `phasetypes` (
  `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `type` enum('solid','liquid','gas','fluid','liquid crystal') COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='TRC phase options (from schema)';

-- --------------------------------------------------------

--
-- Table structure for table `purificationsteps`
--

CREATE TABLE `purificationsteps` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `chemical_id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `step` tinyint(3) UNSIGNED NOT NULL,
  `type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `purity` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `puritysf` tinyint(2) UNSIGNED DEFAULT NULL,
  `purityunit_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `analmeth` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `purimeth` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table of purification steps for a chemical';

-- --------------------------------------------------------

--
-- Table structure for table `quantities`
--

CREATE TABLE `quantities` (
  `id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `phase` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `field` mediumtext COLLATE utf8mb4_bin,
  `label` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `symbol` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `definition` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `source` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(256) COLLATE utf8mb4_bin DEFAULT '["independent set"]',
  `kind` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `quantitykind_id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `defunit_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `lowerlimit` float DEFAULT NULL,
  `upperlimit` float DEFAULT NULL,
  `condcnt` mediumint(8) UNSIGNED DEFAULT NULL,
  `datacnt` mediumint(8) UNSIGNED DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table of chemical properties';

-- --------------------------------------------------------

--
-- Table structure for table `quantitykinds`
--

CREATE TABLE `quantitykinds` (
  `id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `symbol` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `si_unit` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `dim_symbol` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `url` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table of quantities';

-- --------------------------------------------------------

--
-- Table structure for table `references`
--

CREATE TABLE `references` (
  `id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `journal_id` tinyint(3) UNSIGNED ZEROFILL NOT NULL,
  `authors` varchar(2048) COLLATE utf8mb4_bin DEFAULT NULL,
  `aulist` varchar(2048) COLLATE utf8mb4_bin DEFAULT NULL,
  `year` smallint(4) UNSIGNED DEFAULT NULL,
  `volume` varchar(12) COLLATE utf8mb4_bin DEFAULT NULL,
  `issue` varchar(16) COLLATE utf8mb4_bin DEFAULT NULL,
  `startpage` varchar(16) COLLATE utf8mb4_bin DEFAULT NULL,
  `endpage` varchar(16) COLLATE utf8mb4_bin DEFAULT NULL,
  `title` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL,
  `bibliography` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL,
  `url` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `doi` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  `count` smallint(5) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='References from Springer Materials PDFs';

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `title` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL,
  `description` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL,
  `file_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `points` smallint(5) UNSIGNED DEFAULT NULL,
  `comment` varchar(2048) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Reports of data from the literature' ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `sampleprops`
--

CREATE TABLE `sampleprops` (
  `id` mediumint(7) UNSIGNED ZEROFILL NOT NULL,
  `dataset_id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `propnum` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `orgnum` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `property_group` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `property_name` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `quantity_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `unit_id` smallint(5) UNSIGNED ZEROFILL DEFAULT NULL,
  `method_name` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `phase` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `presentation` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `solventorgnum` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `uncnum` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `unceval` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `uncconf` varchar(8) COLLATE utf8mb4_bin DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `substances`
--

CREATE TABLE `substances` (
  `id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(1024) COLLATE utf8mb4_bin NOT NULL,
  `type` enum('element','compound','not found') COLLATE utf8mb4_bin DEFAULT NULL,
  `subtype` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `formula` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  `pcformula` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `molweight` float DEFAULT NULL,
  `casrn` varchar(16) COLLATE utf8mb4_bin DEFAULT NULL,
  `count` smallint(4) UNSIGNED DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table of compounds from Springer materials';

-- --------------------------------------------------------

--
-- Table structure for table `substances_systems`
--

CREATE TABLE `substances_systems` (
  `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL,
  `substance_id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `system_id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `systems`
--

CREATE TABLE `systems` (
  `id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `phase` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `subtype` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `composition` enum('pure substance','binary mixture','ternary mixture','quaternary mixture','quinternary mixture','pure compound') COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  `field` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL,
  `label` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `quantity_id` smallint(5) UNSIGNED ZEROFILL NOT NULL,
  `symbol` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `type` enum('si','siderived','cgs','imperial','inversesi','other') COLLATE utf8mb4_bin NOT NULL,
  `exact` tinyint(1) NOT NULL DEFAULT '1',
  `factor` float NOT NULL DEFAULT '1',
  `si_equivalent` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `qudt` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `header` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL,
  `lowerlimit` float DEFAULT NULL,
  `upperlimit` float DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table of scientific units';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chemicals`
--
ALTER TABLE `chemicals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `substances` (`substance_id`) USING BTREE,
  ADD KEY `files` (`file_id`) USING BTREE;

--
-- Indexes for table `components`
--
ALTER TABLE `components`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chemicals` (`chemical_id`) USING BTREE,
  ADD KEY `mixtures` (`mixture_id`) USING BTREE;

--
-- Indexes for table `conditions`
--
ALTER TABLE `conditions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phases` (`phase_id`) USING BTREE,
  ADD KEY `quantities` (`quantity_id`) USING BTREE,
  ADD KEY `components` (`component_id`) USING BTREE,
  ADD KEY `units` (`unit_id`) USING BTREE,
  ADD KEY `datapoints` (`datapoint_id`) USING BTREE,
  ADD KEY `dataseries` (`dataseries_id`) USING BTREE;

--
-- Indexes for table `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `components` (`component_id`) USING BTREE,
  ADD KEY `quantities` (`quantity_id`) USING BTREE,
  ADD KEY `phases` (`phase_id`) USING BTREE,
  ADD KEY `sampleprops` (`sampleprop_id`) USING BTREE,
  ADD KEY `units` (`unit_id`) USING BTREE,
  ADD KEY `datapoints` (`datapoint_id`) USING BTREE;

--
-- Indexes for table `datapoints`
--
ALTER TABLE `datapoints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dataseries` (`dataseries_id`) USING BTREE;

--
-- Indexes for table `dataseries`
--
ALTER TABLE `dataseries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `datasets` (`dataset_id`) USING BTREE;

--
-- Indexes for table `datasets`
--
ALTER TABLE `datasets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reports` (`report_id`) USING BTREE,
  ADD KEY `systems` (`system_id`) USING BTREE;

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `references` (`reference_id`) USING BTREE;

--
-- Indexes for table `identifiers`
--
ALTER TABLE `identifiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `substances` (`substance_id`) USING BTREE;

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD UNIQUE KEY `ID` (`id`),
  ADD UNIQUE KEY `Code` (`code`);

--
-- Indexes for table `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_keys_reports` (`report_id`);

--
-- Indexes for table `mixtures`
--
ALTER TABLE `mixtures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sys-set` (`system_id`,`dataset_id`),
  ADD KEY `datasets` (`dataset_id`) USING BTREE;

--
-- Indexes for table `phases`
--
ALTER TABLE `phases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mixes` (`mixture_id`) USING BTREE,
  ADD KEY `ptypes` (`phasetype_id`) USING BTREE;

--
-- Indexes for table `phasetypes`
--
ALTER TABLE `phasetypes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purificationsteps`
--
ALTER TABLE `purificationsteps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quantities`
--
ALTER TABLE `quantities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `qkinds` (`quantitykind_id`) USING BTREE,
  ADD KEY `defunits` (`defunit_id`) USING BTREE;

--
-- Indexes for table `quantitykinds`
--
ALTER TABLE `quantitykinds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `units` (`si_unit`) USING BTREE;

--
-- Indexes for table `references`
--
ALTER TABLE `references`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_refs_jrnls` (`journal_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_files_reports` (`file_id`);

--
-- Indexes for table `sampleprops`
--
ALTER TABLE `sampleprops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dataset_id` (`dataset_id`),
  ADD KEY `units` (`unit_id`) USING BTREE,
  ADD KEY `fk_sprops_quants` (`quantity_id`);

--
-- Indexes for table `substances`
--
ALTER TABLE `substances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `casrn` (`casrn`);

--
-- Indexes for table `substances_systems`
--
ALTER TABLE `substances_systems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `systems` (`system_id`) USING BTREE,
  ADD KEY `substances` (`substance_id`) USING BTREE;

--
-- Indexes for table `systems`
--
ALTER TABLE `systems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`),
  ADD KEY `name` (`name`),
  ADD KEY `composition` (`composition`) USING BTREE;

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_units_quants` (`quantity_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chemicals`
--
ALTER TABLE `chemicals`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'primary key';

--
-- AUTO_INCREMENT for table `components`
--
ALTER TABLE `components`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conditions`
--
ALTER TABLE `conditions`
  MODIFY `id` mediumint(7) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data`
--
ALTER TABLE `data`
  MODIFY `id` mediumint(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `datapoints`
--
ALTER TABLE `datapoints`
  MODIFY `id` mediumint(7) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dataseries`
--
ALTER TABLE `dataseries`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `datasets`
--
ALTER TABLE `datasets`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` smallint(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `identifiers`
--
ALTER TABLE `identifiers`
  MODIFY `id` mediumint(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` tinyint(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mixtures`
--
ALTER TABLE `mixtures`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phases`
--
ALTER TABLE `phases`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phasetypes`
--
ALTER TABLE `phasetypes`
  MODIFY `id` tinyint(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purificationsteps`
--
ALTER TABLE `purificationsteps`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quantities`
--
ALTER TABLE `quantities`
  MODIFY `id` smallint(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quantitykinds`
--
ALTER TABLE `quantitykinds`
  MODIFY `id` smallint(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `references`
--
ALTER TABLE `references`
  MODIFY `id` smallint(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sampleprops`
--
ALTER TABLE `sampleprops`
  MODIFY `id` mediumint(7) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `substances`
--
ALTER TABLE `substances`
  MODIFY `id` smallint(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `substances_systems`
--
ALTER TABLE `substances_systems`
  MODIFY `id` mediumint(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `systems`
--
ALTER TABLE `systems`
  MODIFY `id` smallint(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` smallint(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
