\c tpch


--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
create index l_sk on lineitem using btree (l_suppkey asc);
--create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
drop index l_qty;
drop index l_dis;
--drop index l_sk;
drop index l_ep;
drop index l_pk;

set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 800;

--variation
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 220;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 450;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 660;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 890;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 940;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 800;
--variation
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 220;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 450;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 660;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 890;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-5' as batch, 0 parllelmode, 1000000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 940;
\o



--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
create index l_sk on lineitem using btree (l_suppkey asc);
--create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
drop index l_qty;
drop index l_dis;
--drop index l_sk;
drop index l_ep;
drop index l_pk;

SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;


--l_suppkey index only, parallelism off
set force_parallel_mode = ON; --turn off workers
set parallel_setup_cost = 1000; --default is 1000

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 5000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 6000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 7500;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 9200;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 5000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 6000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 7500;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-22' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 1 i_s, 0 i_e, 0 i_d, 0 v_q, 5000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 9200;
\o


create index l_qty on lineitem using btree (l_quantity asc);
create index l_dis on lineitem using btree (l_discount asc);
create index l_sk on lineitem using btree (l_suppkey asc);
--create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
--drop index l_qty;
--drop index l_dis;
--drop index l_sk;
drop index l_ep;
drop index l_pk;

set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .10 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.10 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .11 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.11 and l_quantity < 2 ;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 5 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 2 ;

--variations
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .09 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.095 and l_quantity < 2 ;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .10 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.10 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .11 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.11 and l_quantity < 2 ;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 5 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 2 ;

--variations
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-6c' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .09 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.095 and l_quantity < 2 ;
\o

create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
create index l_sk on lineitem using btree (l_suppkey asc);
--create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
--drop index l_qty;
drop index l_dis;
--drop index l_sk;
drop index l_ep;
drop index l_pk;

--l_quantity index, no parallelism
--drop index l_dis;

set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .02 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.02 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .03 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.03 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .04 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.04 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .05 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.05 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .06 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.06 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .07 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.07 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .08 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.08 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .09 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.09 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .12 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.12 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .13 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.13 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .14 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.14 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .15 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.15 and l_quantity < 2 ;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .15 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.095 and l_quantity < 2 ;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .02 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.02 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .03 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.03 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .04 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.04 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .05 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.05 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .06 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.06 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .07 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.07 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .08 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.08 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .09 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.09 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .12 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.12 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .13 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.13 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .14 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.14 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .15 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.15 and l_quantity < 2 ;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-8' as batch, 0 parllelmode, 1000000 parallelsetupcost, 4 query, 1 i_q, 0 i_p, 0 i_s, 0 i_e, 1 i_d, 2 v_q, 0 v_s, .15 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.095 and l_quantity < 2 ;

\o

create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
--create index l_sk on lineitem using btree (l_suppkey asc);
create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
--drop index l_qty;
drop index l_dis;
drop index l_sk;
--drop index l_ep;
drop index l_pk;

--create index l_ep on lineitem using btree (l_extendedprice desc);
--drop index l_sk;

set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;


\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 120000 and l_partkey < 100000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 1000000 v_e, 0 v_p from lineitem where l_extendedprice > 100000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 990000 v_e, 0 v_p from lineitem where l_extendedprice > 99000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 980000 v_e, 0 v_p from lineitem where l_extendedprice > 98000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 970000 v_e, 0 v_p from lineitem where l_extendedprice > 97000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 960000 v_e, 0 v_p from lineitem where l_extendedprice > 96000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 950000 v_e, 0 v_p from lineitem where l_extendedprice > 95000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 940000 v_e, 0 v_p from lineitem where l_extendedprice > 94000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 930000 v_e, 0 v_p from lineitem where l_extendedprice > 93000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 920000 v_e, 0 v_p from lineitem where l_extendedprice > 92000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 910000 v_e, 0 v_p from lineitem where l_extendedprice > 91000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 900000 v_e, 0 v_p from lineitem where l_extendedprice > 90000 ;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 95000 and l_partkey < 100000;

--variations
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 900000 v_e, 0 v_p from lineitem where l_extendedprice > 89500 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 95000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 97000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 93000 and l_partkey < 100000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 120000 and l_partkey < 100000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 1000000 v_e, 0 v_p from lineitem where l_extendedprice > 100000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 990000 v_e, 0 v_p from lineitem where l_extendedprice > 99000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 980000 v_e, 0 v_p from lineitem where l_extendedprice > 98000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 970000 v_e, 0 v_p from lineitem where l_extendedprice > 97000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 960000 v_e, 0 v_p from lineitem where l_extendedprice > 96000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 950000 v_e, 0 v_p from lineitem where l_extendedprice > 95000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 940000 v_e, 0 v_p from lineitem where l_extendedprice > 94000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 930000 v_e, 0 v_p from lineitem where l_extendedprice > 93000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 920000 v_e, 0 v_p from lineitem where l_extendedprice > 92000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 910000 v_e, 0 v_p from lineitem where l_extendedprice > 91000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 900000 v_e, 0 v_p from lineitem where l_extendedprice > 90000 ;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 95000 and l_partkey < 100000;

--variations
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 900000 v_e, 0 v_p from lineitem where l_extendedprice > 89500 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 95000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 97000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-10' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 100000 v_p from lineitem where l_extendedprice > 93000 and l_partkey < 100000;
\o

create index l_pk on lineitem using btree (l_partkey desc);
drop index l_qty;
drop index l_dis;
drop index l_sk;
drop index l_ep;
--drop index l_pk;


SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;
set force_parallel_mode = ON; --turn off workers
set parallel_setup_cost = 1000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 85000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;

--variations
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 90000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 73000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 86000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 87000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 150000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 150000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 150000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 150000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 175000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 85000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;

--variations
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 90000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 73000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 100000 v_p from lineitem where l_extendedprice > 86000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 01i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 87000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 150000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 150000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 150000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-20' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 1 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 150000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 175000;
\o

--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
--create index l_sk on lineitem using btree (l_suppkey asc);
create index l_ep on lineitem using btree (l_extendedprice desc);
create index l_pk on lineitem using btree (l_partkey desc);
drop index l_qty;
drop index l_dis;
drop index l_sk;
--drop index l_ep;
--drop index l_pk;

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

set force_parallel_mode = ON; --turn off workers
set parallel_setup_cost = 1000; --default is 1000

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-12' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 1 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 90000 and l_partkey < 100000;

--variations
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-12' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 1 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 92500 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-12' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 1 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 97500 and l_partkey < 100000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-12' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 1 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 90000 and l_partkey < 100000;

--variations
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-12' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 1 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 92500 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-12' as batch, 1 parllelmode, 1000 parallelsetupcost, 9 query, 0 i_q, 1 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 85000 v_e, 100000 v_p from lineitem where l_extendedprice > 97500 and l_partkey < 100000;
\o

create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
--create index l_sk on lineitem using btree (l_suppkey asc);
create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
--drop index l_qty;
drop index l_dis;
drop index l_sk;
--drop index l_ep;
drop index l_pk;

set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 120000 and l_partkey < 100000;

--variations
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 115000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 110000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 100000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 120000 and l_partkey < 100000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 120000 and l_partkey < 100000;

--variations
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 115000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 110000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 100000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'bitmap' as type, '3-29' as batch, 0 parllelmode, 1000000 parallelsetupcost, 9 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 120000 and l_partkey < 100000;
\o

set force_parallel_mode = ON; --turn off workers
set parallel_setup_cost = 1000; --default is 1000

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1460000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;

--variations
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86500 and l_suppkey < 75000 and l_partkey < 1460000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 85500 and l_suppkey < 75000 and l_partkey < 1460000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1490000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1420000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 61500 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62500 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87500 and l_suppkey < 62000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87500 and l_suppkey < 62000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86500 and l_suppkey < 62000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1460000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86500 and l_suppkey < 75000 and l_partkey < 1460000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 85500 and l_suppkey < 75000 and l_partkey < 1460000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1490000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1420000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 61500 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62500 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87500 and l_suppkey < 62000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87500 and l_suppkey < 62000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86500 and l_suppkey < 62000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'bitmap' as type, '3-30' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;
\o

--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
create index l_sk on lineitem using btree (l_suppkey asc);
create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
drop index l_qty;
drop index l_dis;
--drop index l_sk;
--drop index l_ep;
drop index l_pk;
set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 75000 v_e, 0 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 77000 v_e, 0 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 50000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 78000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 2000000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1880000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 57000 v_s, 0 v_d, 82000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 68000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 58000 v_s, 0 v_d, 83000 v_e, 1200000 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 67000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 59000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 91000 and l_suppkey < 66000 and l_partkey < 1200000;

--vary
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 75000 v_e, 0 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 77000 v_e, 0 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 77000 v_e, 0 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 50000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 78000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 2000000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 75000 and l_partkey < 2000000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 96000 and l_suppkey < 75000 and l_partkey < 1880000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 75000 and l_partkey < 1880000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1920000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1920000;


select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94500 and l_suppkey < 72000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 57000 v_s, 0 v_d, 82000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 68500 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 59000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 65500 and l_partkey < 1200000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 75000 v_e, 0 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 77000 v_e, 0 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 50000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 78000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 2000000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1880000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 57000 v_s, 0 v_d, 82000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 68000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 58000 v_s, 0 v_d, 83000 v_e, 1200000 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 67000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 59000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 91000 and l_suppkey < 66000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 75000 v_e, 0 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 77000 v_e, 0 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 77000 v_e, 0 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 50000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 78000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 2000000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 75000 and l_partkey < 2000000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 96000 and l_suppkey < 75000 and l_partkey < 1880000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 75000 and l_partkey < 1880000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1920000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1920000;


explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94500 and l_suppkey < 72000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 57000 v_s, 0 v_d, 82000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 68500 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-15' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 59000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 65500 and l_partkey < 1200000;
\o

--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
create index l_sk on lineitem using btree (l_suppkey asc);
create index l_ep on lineitem using btree (l_extendedprice desc);
create index l_pk on lineitem using btree (l_partkey desc);
drop index l_qty;
drop index l_dis;
--drop index l_sk;
--drop index l_ep;
--drop index l_pk;

set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1160000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1940000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 83000 v_e, 1280000 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 75000 and l_partkey < 1820000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1340000 v_p from lineitem where l_extendedprice > 91000 and l_suppkey < 75000 and l_partkey < 1760000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 69000 and l_partkey < 1200000;

--variation
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1160000 v_p from lineitem where l_extendedprice > 94500 and l_suppkey < 75000 and l_partkey < 1940000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 83000 v_e, 1280000 v_p from lineitem where l_extendedprice > 92500 and l_suppkey < 75000 and l_partkey < 1820000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1340000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 75000 and l_partkey < 1760000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 69500 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 69000 and l_partkey < 1200000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1160000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1940000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 83000 v_e, 1280000 v_p from lineitem where l_extendedprice > 92000 and l_suppkey < 75000 and l_partkey < 1820000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1340000 v_p from lineitem where l_extendedprice > 91000 and l_suppkey < 75000 and l_partkey < 1760000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 69000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 13 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1160000 v_p from lineitem where l_extendedprice > 94500 and l_suppkey < 75000 and l_partkey < 1940000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 83000 v_e, 1280000 v_p from lineitem where l_extendedprice > 92500 and l_suppkey < 75000 and l_partkey < 1820000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 14 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1340000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 75000 and l_partkey < 1760000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 95000 and l_suppkey < 69500 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'index' as type, '3-17' as batch, 0 parllelmode, 1000000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 93500 and l_suppkey < 69000 and l_partkey < 1200000;
\o

set force_parallel_mode = ON; --turn off workers
set parallel_setup_cost = 1000; --default is 1000
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-18' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 65000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-18' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 65000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-18' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 65000 and l_partkey < 1200000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-18' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 65000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-18' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 65000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-18' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 1 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 65000 and l_partkey < 1200000;
\o

--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
create index l_sk on lineitem using btree (l_suppkey asc);
create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);
drop index l_qty;
drop index l_dis;
--drop index l_sk;
--drop index l_ep;
drop index l_pk;


set force_parallel_mode = ON; --turn off workers
set parallel_setup_cost = 1000; --default is 1000

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

\o | cat - >> /home/ubuntu/export/test5-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-14' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1700000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-14' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 75000 and l_partkey < 1700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-14' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 75000 and l_partkey < 1700000;
\o
\timing off

\o | cat - >> /home/ubuntu/export/test5-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-14' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1700000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-14' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 90500 and l_suppkey < 75000 and l_partkey < 1700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 1 workers, 'index' as type, '3-14' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 1 i_s, 1 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 75000 and l_partkey < 1700000;
\o

drop index l_qty;
drop index l_dis;
drop index l_sk;
drop index l_ep;
drop index l_pk;

set parallel_setup_cost = 1000000; --default is 1000
SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;
set force_parallel_mode = OFF; --turn off workers

--SCAN ONLY

\o | cat - >> /home/ubuntu/export/test3-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '3-1' as batch, 0 parllelmode, 1000000 parallelsetupcost, 2 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 2 v_q, 0 v_s, 0 v_d, 0 v_e, 0 v_p from lineitem where l_quantity < 2;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '3-1' as batch, 0 parllelmode, 1000000 parallelsetupcost, 2 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 3 v_q, 0 v_s, 0 v_d, 0 v_e, 0 v_p from lineitem where l_quantity < 3;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '3-1' as batch, 0 parllelmode, 1000000 parallelsetupcost, 2 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 4 v_q, 0 v_s, 0 v_d, 0 v_e, 0 v_p from lineitem where l_quantity < 4;
\timing off
\o
\o | cat - >> /home/ubuntu/export/test3-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, 0 parllelmode, 1000000 parallelsetupcost, 2 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 2 v_q, 0 v_s, 0 v_d, 0 v_e, 0 v_p from lineitem where l_quantity < 2;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, 0 parllelmode, 1000000 parallelsetupcost, 2 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 3 v_q, 0 v_s, 0 v_d, 0 v_e, 0 v_p from lineitem where l_quantity < 3;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, 0 parllelmode, 1000000 parallelsetupcost, 2 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 4 v_q, 0 v_s, 0 v_d, 0 v_e, 0 v_p from lineitem where l_quantity < 4;
\o

set force_parallel_mode = OFF; --turn off workers
set parallel_setup_cost = 1000000; --default is 1000

\o | cat - >> /home/ubuntu/export/test3-results.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1800;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2800;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3800;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 4000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 4000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 3 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 3 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 4 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 4 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 5 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 5 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 6 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 6 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 7 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 7 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 8 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 8 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 9 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 9 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 10 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 10 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 11 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 11 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 12 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 12 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 13 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 13 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 14 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 14 ;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 890000 v_e, 0 v_p from lineitem where l_extendedprice > 89000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 880000 v_e, 0 v_p from lineitem where l_extendedprice > 88000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 870000 v_e, 0 v_p from lineitem where l_extendedprice > 87000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 860000 v_e, 0 v_p from lineitem where l_extendedprice > 86000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 850000 v_e, 0 v_p from lineitem where l_extendedprice > 85000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 840000 v_e, 0 v_p from lineitem where l_extendedprice > 84000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 830000 v_e, 0 v_p from lineitem where l_extendedprice > 83000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 820000 v_e, 0 v_p from lineitem where l_extendedprice > 82000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 810000 v_e, 0 v_p from lineitem where l_extendedprice > 81000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 800000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 ;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 200000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 300000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 400000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 500000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 600000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 700000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 800000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 900000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 900000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1000000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1000000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1300000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1400000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1500000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1600000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1700000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1800000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1900000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1900000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 2000000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 2000000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 10000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 10000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 15000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 15000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 20000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 20000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 25000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 25000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 30000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 30000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 35000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 35000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 40000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 40000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 45000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 45000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 55000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 60000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 65000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 65000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 70000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 70000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 75000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 82000 v_e, 0 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 85000 v_e, 0 v_p from lineitem where l_extendedprice > 82000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 88000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 92000 v_e, 0 v_p from lineitem where l_extendedprice > 77000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 50000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 72000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 72000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 66000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 66000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 54000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 54000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 48000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 48000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 42000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 42000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 36000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 36000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 30000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 24000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 24000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 18000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 18000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 12000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 12000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 6000  v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 6000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 300000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 400000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 500000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 600000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 700000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 800000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 900000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 900000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1000000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1000000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1100000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 90000 v_e, 1200000 v_p from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 93000 v_e, 1200000 v_p from lineitem where l_extendedprice > 78000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 95000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 75000 and l_partkey < 1100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1160000 v_p from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1160000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 82000 and l_suppkey < 75000 and l_partkey < 1220000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 83000 v_e, 1280000 v_p from lineitem where l_extendedprice > 83000 and l_suppkey < 75000 and l_partkey < 1280000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1340000 v_p from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1340000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 75000 and l_partkey < 1400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 86000 v_e, 1460000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1460000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1520000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1520000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 88000 v_e, 1580000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1580000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 89000 v_e, 1640000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1640000;


select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 55000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 81000 and l_suppkey < 56000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 57000 v_s, 0 v_d, 82000 v_e, 1200000 v_p from lineitem where l_extendedprice > 82000 and l_suppkey < 57000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 58000 v_s, 0 v_d, 83000 v_e, 1200000 v_p from lineitem where l_extendedprice > 83000 and l_suppkey < 58000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 59000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 84000 and l_suppkey < 59000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 60000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 61000 v_s, 0 v_d, 86000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 61000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 62000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 63000 v_s, 0 v_d, 88000 v_e, 1200000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 63000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 64000 v_s, 0 v_d, 89000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 64000 and l_partkey < 1200000;


select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 25000 v_s, 0 v_d, 75000 v_e, 250000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 25000 and l_partkey < 250000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 30000 v_s, 0 v_d, 75000 v_e, 300000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 35000 v_s, 0 v_d, 75000 v_e, 350000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 35000 and l_partkey < 350000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 40000 v_s, 0 v_d, 75000 v_e, 400000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 40000 and l_partkey < 400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 45000 v_s, 0 v_d, 75000 v_e, 450000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 45000 and l_partkey < 450000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 75000 v_e, 500000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 50000 and l_partkey < 500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 75000 v_e, 550000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 55000 and l_partkey < 550000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 75000 v_e, 600000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 65000 v_s, 0 v_d, 75000 v_e, 650000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 65000 and l_partkey < 650000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 70000 v_s, 0 v_d, 75000 v_e, 700000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 70000 and l_partkey < 700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 750000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 750000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 80000 v_s, 0 v_d, 75000 v_e, 800000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 80000 and l_partkey < 800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 85000 v_s, 0 v_d, 75000 v_e, 850000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 85000 and l_partkey < 850000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 90000 v_s, 0 v_d, 75000 v_e, 900000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 90000 and l_partkey < 900000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '4-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 95000 ;



--variation
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1100;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 990;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 970;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 890000 v_e, 0 v_p from lineitem where l_extendedprice > 89500 ;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 200000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 150000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 10000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 7500;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 91000 and l_suppkey < 50000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 150000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 175000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 89000 v_e, 1640000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 75000 and l_partkey < 1640000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 89000 v_e, 1640000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1700000;


select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 64000 v_s, 0 v_d, 89000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 64500 and l_partkey < 1200000;

select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '4-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 95500 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '4-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 94500 ;
\timing off
\o
\o | cat - >> /home/ubuntu/export/test3-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1800;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 2800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 2800;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3200 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3400 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3600 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 3800 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 3800;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 4000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 4000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 3 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 3 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 4 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 4 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 5 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 5 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 6 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 6 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 7 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 7 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 8 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 8 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 9 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 9 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 10 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 10 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 11 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 11 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 12 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 12 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 13 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 13 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 5 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 14 v_q, 0 v_s, .01 v_d, 0 v_e, 0 v_p from lineitem where l_discount < 0.01 and l_quantity < 14 ;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 890000 v_e, 0 v_p from lineitem where l_extendedprice > 89000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 880000 v_e, 0 v_p from lineitem where l_extendedprice > 88000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 870000 v_e, 0 v_p from lineitem where l_extendedprice > 87000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 860000 v_e, 0 v_p from lineitem where l_extendedprice > 86000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 850000 v_e, 0 v_p from lineitem where l_extendedprice > 85000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 840000 v_e, 0 v_p from lineitem where l_extendedprice > 84000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 830000 v_e, 0 v_p from lineitem where l_extendedprice > 83000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 820000 v_e, 0 v_p from lineitem where l_extendedprice > 82000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 810000 v_e, 0 v_p from lineitem where l_extendedprice > 81000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 800000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 ;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 200000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 300000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 400000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 500000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 600000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 700000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 800000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 900000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 900000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1000000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1000000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1300000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1400000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1500000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1600000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1700000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1800000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 1900000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 1900000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 2000000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 2000000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 10000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 10000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 15000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 15000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 20000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 20000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 25000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 25000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 30000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 30000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 35000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 35000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 40000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 40000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 45000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 45000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 55000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 60000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 65000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 65000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 70000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 70000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 75000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 82000 v_e, 0 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 85000 v_e, 0 v_p from lineitem where l_extendedprice > 82000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 88000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 92000 v_e, 0 v_p from lineitem where l_extendedprice > 77000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 50000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 72000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 72000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 66000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 66000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 54000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 54000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 48000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 48000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 42000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 42000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 36000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 36000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 30000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 24000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 24000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 18000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 18000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 12000 v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 12000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 11 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 6000  v_s, 0 v_d, 75000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 6000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 300000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 400000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 500000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 600000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 700000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 800000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 900000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 900000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1000000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1000000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 1100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1100000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 90000 v_e, 1200000 v_p from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 93000 v_e, 1200000 v_p from lineitem where l_extendedprice > 78000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 95000 v_e, 1200000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 80000 v_e, 1100000 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 75000 and l_partkey < 1100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 81000 v_e, 1160000 v_p from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1160000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 82000 v_e, 1220000 v_p from lineitem where l_extendedprice > 82000 and l_suppkey < 75000 and l_partkey < 1220000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 83000 v_e, 1280000 v_p from lineitem where l_extendedprice > 83000 and l_suppkey < 75000 and l_partkey < 1280000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 84000 v_e, 1340000 v_p from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1340000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 85000 v_e, 1400000 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 75000 and l_partkey < 1400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 86000 v_e, 1460000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1460000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1520000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1520000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 88000 v_e, 1580000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1580000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 89000 v_e, 1640000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1640000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 80000 v_e, 1200000 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 55000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 56000 v_s, 0 v_d, 81000 v_e, 1200000 v_p from lineitem where l_extendedprice > 81000 and l_suppkey < 56000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 57000 v_s, 0 v_d, 82000 v_e, 1200000 v_p from lineitem where l_extendedprice > 82000 and l_suppkey < 57000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 58000 v_s, 0 v_d, 83000 v_e, 1200000 v_p from lineitem where l_extendedprice > 83000 and l_suppkey < 58000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 59000 v_s, 0 v_d, 84000 v_e, 1200000 v_p from lineitem where l_extendedprice > 84000 and l_suppkey < 59000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 85000 v_e, 1200000 v_p from lineitem where l_extendedprice > 85000 and l_suppkey < 60000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 61000 v_s, 0 v_d, 86000 v_e, 1200000 v_p from lineitem where l_extendedprice > 86000 and l_suppkey < 61000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 62000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 63000 v_s, 0 v_d, 88000 v_e, 1200000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 63000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 64000 v_s, 0 v_d, 89000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 64000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 25000 v_s, 0 v_d, 75000 v_e, 250000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 25000 and l_partkey < 250000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 30000 v_s, 0 v_d, 75000 v_e, 300000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 35000 v_s, 0 v_d, 75000 v_e, 350000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 35000 and l_partkey < 350000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 40000 v_s, 0 v_d, 75000 v_e, 400000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 40000 and l_partkey < 400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 45000 v_s, 0 v_d, 75000 v_e, 450000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 45000 and l_partkey < 450000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 75000 v_e, 500000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 50000 and l_partkey < 500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 55000 v_s, 0 v_d, 75000 v_e, 550000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 55000 and l_partkey < 550000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 60000 v_s, 0 v_d, 75000 v_e, 600000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 65000 v_s, 0 v_d, 75000 v_e, 650000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 65000 and l_partkey < 650000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 70000 v_s, 0 v_d, 75000 v_e, 700000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 70000 and l_partkey < 700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 750000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 750000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 80000 v_s, 0 v_d, 75000 v_e, 800000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 80000 and l_partkey < 800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 85000 v_s, 0 v_d, 75000 v_e, 850000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 85000 and l_partkey < 850000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 16 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 90000 v_s, 0 v_d, 75000 v_e, 900000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 90000 and l_partkey < 900000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '4-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 95000 ;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 1100;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 990;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 3 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 1000 v_s, 0 v_d, 0 v_e, 0 v_p  from lineitem where l_suppkey < 970;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 890000 v_e, 0 v_p from lineitem where l_extendedprice > 89500 ;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 7 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 80000 v_e, 200000 v_p from lineitem where l_extendedprice > 80000 and l_partkey < 150000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 8 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 10000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 80000 and l_suppkey < 7500;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 10 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 50000 v_s, 0 v_d, 80000 v_e, 0 v_p from lineitem where l_extendedprice > 91000 and l_suppkey < 50000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 150000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 12 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 75000 v_e, 100000 v_p from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 175000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 13 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 87000 v_e, 1200000 v_p from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 89000 v_e, 1640000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 75000 and l_partkey < 1640000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 14 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 75000 v_s, 0 v_d, 89000 v_e, 1640000 v_p from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1700000;


explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 workers, 'scan' as type, '3-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 15 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 64000 v_s, 0 v_d, 89000 v_e, 1200000 v_p from lineitem where l_extendedprice > 89500 and l_suppkey < 64500 and l_partkey < 1200000;

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '4-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 95500 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 0 workers, 'scan' as type, '4-2' as batch, 1 parllelmode, 1000 parallelsetupcost, 6 query, 0 i_q, 0 i_p, 0 i_s, 0 i_e, 0 i_d, 0 v_q, 0 v_s, 0 v_d, 95000 v_e, 0 v_p from lineitem where l_extendedprice > 94500 ;
\o

