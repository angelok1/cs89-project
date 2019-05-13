BEGIN;

	CREATE TABLE ORDERS (
		O_ORDERKEY		BIGINT NOT NULL,
		O_CUSTKEY		BIGINT NOT NULL, --references C_CUSTKEY
		O_ORDERSTATUS	CHAR(1),
		O_TOTALPRICE	DECIMAL,
		O_ORDERDATE		DATE,
		O_ORDERPRIORITY	CHAR(15),
		O_CLERK			CHAR(15),
		O_SHIPPRIORITY	INTEGER,
		O_COMMENT		VARCHAR(79),
                PRIMARY KEY (O_ORDERKEY)  
	);

	COPY lineitem FROM '/data/2.18.0_rc2/dbgen/orders.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

--create index o_ord on lineitem using btree (O_ORDERKEY asc);
--create index o_cust on lineitem using btree (O_CUSTKEY asc);
--create index o_price on lineitem using btree (O_TOTALPRICE desc);
