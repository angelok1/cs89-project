BEGIN;

	CREATE TABLE PART (
		P_PARTKEY 	BIGINT NOT NULL,
		P_NAME 		VARCHAR(55),
		P_MFGR		CHAR(25),
		P_BRAND		CHAR(10),
		P_TYPE		VARCHAR(25),
		P_SIZE		INTEGER,
		P_CONTAINER CHAR(10),
		P_RETAILPRICE DECIMAL,
		P_COMMENT	VARCHAR(23),
	      PRIMARY KEY (P_PARTKEY)  
	);

	COPY lineitem FROM '/data/2.18.0_rc2/dbgen/part.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

--create index p_part on lineitem using btree (P_PARTKEY asc);
--create index p_price on lineitem using btree (P_RETAILPRICE desc);