BEGIN;

	CREATE TABLE PARTSUPP (
		PS_PARTKEY 	BIGINT NOT NULL,
		PS_SUPPKEY 	BIGINT NOT NULL,
		PS_AVAILQTY 		INTEGER,
		PS_SUPPLYCOST		DECIMAL,
		PS_COMMENT		VARCHAR(199),
	      PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY)  
	);

	COPY lineitem FROM '/data/2.18.0_rc2/dbgen/partsupp.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

--create index ps_part on lineitem using btree (PS_PARTKEY asc);
--create index ps_supp on lineitem using btree (PS_SUPPKEY asc);
--create index ps_price on lineitem using btree (PS_SUPPLYCOST desc);