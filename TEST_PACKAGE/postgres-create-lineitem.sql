BEGIN;

	CREATE TABLE LINEITEM (
		L_ORDERKEY		BIGINT NOT NULL, -- references O_ORDERKEY
		L_PARTKEY		BIGINT NOT NULL, -- references P_PARTKEY (compound fk to PARTSUPP)
		L_SUPPKEY		BIGINT NOT NULL, -- references S_SUPPKEY (compound fk to PARTSUPP)
		L_LINENUMBER	INTEGER,
		L_QUANTITY		DECIMAL,
		L_EXTENDEDPRICE	DECIMAL,
		L_DISCOUNT		DECIMAL,
		L_TAX			DECIMAL,
		L_RETURNFLAG	CHAR(1),
		L_LINESTATUS	CHAR(1),
		L_SHIPDATE		DATE,
		L_COMMITDATE	DATE,
		L_RECEIPTDATE	DATE,
		L_SHIPINSTRUCT	CHAR(25),
		L_SHIPMODE		CHAR(10),
		L_COMMENT		VARCHAR(44),
                PRIMARY KEY (L_ORDERKEY, L_LINENUMBER)  
	);

	COPY lineitem FROM '/data/2.18.0_rc2/dbgen/lineitem.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
--create index l_sk on lineitem using btree (l_suppkey asc);
--create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
