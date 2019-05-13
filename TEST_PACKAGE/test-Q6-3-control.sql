--Btree Index, multithreading off
\timing off

\c tpch


--Q2:  select count(l_extendedprice) from lineitem where l_discount between 0.08 and 0.09;
--Q3  select count(l_extendedprice) from lineitem where l_quantity < 2;
--Q4 select count(l_extendedprice) from lineitem where l_discount between 0.08 and 0.09 and l_quantity < 2 ;
--Q4-1 select count(l_extendedprice) from lineitem where l_discount between 0.08 and 0.09 and l_quantity < 3 ;
--Q4-2 select count(l_extendedprice) from lineitem where l_discount between 0.07 and 0.09 and l_quantity < 2 ;

-- select count(l_extendedprice) from lineitem where l_shipdate >= date '1995-01-01' and l_shipdate < date '1995-01-01' + interval '1' year and l_discount between 0.09 - 0.01 and 0.09 + 0.01 and l_quantity < 24 ;

--set seq_page_cost = 1; --1
--set random_page_cost = 4; --4
--set cpu_tuple_cost = .01; --.01
--set cpu_index_tuple_cost = .005; --.005 this is for indexes only
--set cpu_operator_cost = 0.0025; --.0025
--set parallel_setup_cost = 1000; --default is 1000
--set parallel_tuple_cost = .1; --.1
--set min_parallel_table_scan_size = '8MB'; --8 MB
--set min_parallel_index_scan_size = '512kB'; --512 k
--set effective_cache_size = '4GB'; --4 GB

--legend:
--i_q = index on l_quantity? 1 = yes, 0 = no
--i_p = index on l_partkey? 1 = yes, 0 = no
--i_s = index on l_suppkey? 1 = yes, 0 = no
--i_e = index on l_extendedprice? 1 = yes, 0 = no
--i_d = index on l_discount? 1 = yes, 0 = no
--v_q = value of l_quantity

--query up to 3.5% selectivity

--study bitmap heap vs bitmap index scan

--scans:

--No index, no parallelism
--set parallel_setup_cost = 1000; --default is 1000
--SET enable_seqscan = ON;
--SET enable_indexscan = ON;
--SET enable_bitmapscan = ON;
--set force_parallel_mode = OFF; --turn off workers

--create index l_qty on lineitem using btree (l_quantity asc);
--create index l_dis on lineitem using btree (l_discount asc);
--create index l_sk on lineitem using btree (l_suppkey asc);
--create index l_ep on lineitem using btree (l_extendedprice desc);
--create index l_pk on lineitem using btree (l_partkey desc);

--drop index l_pk;
--drop index l_sk;
--drop index l_qty;
--drop index l_ep;
--drop index l_dis;


--Q1 vary l_partkey... done
--Q2 vary l_quantity
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, '3-1' as batch, 2 query from lineitem where l_quantity < 2;
select cast (count(l_extendedprice) as float)/59986052 selectivity, '3-1' as batch, 2 query from lineitem where l_quantity < 3;
select cast (count(l_extendedprice) as float)/59986052 selectivity, '3-1' as batch, 2 query from lineitem where l_quantity < 4;
\timing off
\o
\o | cat - >> /home/ubuntu/export/control-explain.txt
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 query from lineitem where l_quantity < 2;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 query from lineitem where l_quantity < 3;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 2 query from lineitem where l_quantity < 4;
\o
--Q3 vary l_suppkey

\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 800;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1800;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2800;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3200;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3400;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3600;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3800;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 4000;
\timing off
\o
--4 Q4 vary l_discount & l_quantity (vary l_discount)
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.01 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.02 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.03 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.04 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.05 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.06 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.07 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.08 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.09 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.10 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.11 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.12 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.13 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.14 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.15 and l_quantity < 2 ;
\timing off
\o
--5 Q5 vary l_discount & l_quantity (vary l_quantity)
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 2 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 3 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 4 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 5 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 6 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 7 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 8 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 9 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 10 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 11 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 12 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 13 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 14 ;
\timing off
\o
--6 Q6 vary l_extendedprice
--go from 100k to 80k stepping in incrememnts of 1000
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 100000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 99000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 98000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 97000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 96000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 95000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 94000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 93000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 92000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 91000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 90000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 89000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 88000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 87000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 86000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 85000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 84000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 83000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 82000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 81000 ;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 80000 ;
\timing off
\o


--try an asc key too?

--7 Q7 vary l_partkey & l_extendedprice (partkey fixed)
--partkey 100k-2M by 100k incr
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 900000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1000000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 1900000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 2000000;
\timing off
\o
--8 Q8 vary l_suppkey & l_extendedprice (suppkey fixed)
--supkey 5k-75k by 5k
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 5000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 10000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 15000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 20000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 25000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 30000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 35000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 40000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 45000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 55000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 60000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 65000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 70000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 75000;
\timing off
\o

--9 Q9 vary l_partkey & l_extendedprice (l_extendedprice fixed)
--move l_extendedprice from 75k to 120k in increments of 5k
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 75000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 85000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 90000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 95000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 100000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 105000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 110000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 115000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 120000 and l_partkey < 100000;
\timing off
\o
--10 Q10 vary l_suppkey & l_extendedprice (l_extendedprice fixed)
--75k-95k in increments of 2 or 3 k
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 75000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 77000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 82000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 85000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 88000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 92000 and l_suppkey < 50000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 95000 and l_suppkey < 50000;
\timing off
\o
--11 Q11 vary l_partkey & l_extendedprice & l_suppkey (l_extendedprice & l_partkey fixed)
--vary suppkey 6k-75k by 6k 
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 72000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 66000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 54000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 48000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 42000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 36000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 24000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 18000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 12000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 6000 and l_partkey < 1200000;
\timing off
\o
--12 Q12 vary l_partkey & l_extendedprice & l_suppkey (l_extendedpri
--vary partkey by 100k to 100k
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 900000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query  from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1000000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query  from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1100000;
\timing off
\o
--13 Q13 vary l_partkey & l_extendedprice & l_suppkey (l_suppkey & l_partkey fixed)
--vary price from 75-95k by 3k
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 78000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;
\timing off
\o
--14 Q14 vary l_partkey & l_extendedprice & l_suppkey (l_suppkey fix
--l_partkey=1100000 to 2M in incr of 60k,  l_extendedprice=95k to 80
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 80000 and l_suppkey < 75000 and l_partkey < 1100000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1160000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 82000 and l_suppkey < 75000 and l_partkey < 1220000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 83000 and l_suppkey < 75000 and l_partkey < 1280000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1340000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 85000 and l_suppkey < 75000 and l_partkey < 1400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1460000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1520000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1580000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1640000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 91000 and l_suppkey < 75000 and l_partkey < 1760000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 92000 and l_suppkey < 75000 and l_partkey < 1820000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1880000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1940000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 2000000;
\timing off
\o
--15 Q15 vary l_partkey & l_extendedprice & l_suppkey (l_partkey fixed)
--l_suppkey=75 to 55 in incr of 1.5k,  l_extendedprice=95k to 80 in incr of 1k
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 80000 and l_suppkey < 55000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 81000 and l_suppkey < 56000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 82000 and l_suppkey < 57000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 83000 and l_suppkey < 58000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 84000 and l_suppkey < 59000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 85000 and l_suppkey < 60000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 86000 and l_suppkey < 61000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 88000 and l_suppkey < 63000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 89000 and l_suppkey < 64000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 90000 and l_suppkey < 65000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 91000 and l_suppkey < 66000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 92000 and l_suppkey < 67000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 93000 and l_suppkey < 68000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 94000 and l_suppkey < 69000 and l_partkey < 1200000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;
\timing off
\o
--16 Q16 vary l_partkey & l_extendedprice & l_suppkey (l_extendedpri
--l_suppkey=90k to 25k in incr of 5k,  l_partkey=900k to 250k in inc
\o | cat - >> /home/ubuntu/export/control-query.txt
\timing on
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 25000 and l_partkey < 250000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 300000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 35000 and l_partkey < 350000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 40000 and l_partkey < 400000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 45000 and l_partkey < 450000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 50000 and l_partkey < 500000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 55000 and l_partkey < 550000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 600000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 65000 and l_partkey < 650000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 70000 and l_partkey < 700000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 750000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 80000 and l_partkey < 800000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 85000 and l_partkey < 850000;
select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 90000 and l_partkey < 900000;
\timing off
\o

\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query from lineitem where l_suppkey < 800;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 1800;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 2800;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3200;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3400;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3600;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 3800;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 3 query  from lineitem where l_suppkey < 4000;

\o
--4 Q4 vary l_discount & l_quantity (vary l_discount)
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.01 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.02 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.03 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.04 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.05 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.06 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.07 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.08 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.09 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.10 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.11 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.12 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.13 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.14 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 4 query from lineitem where l_discount < 0.15 and l_quantity < 2 ;

\o
--5 Q5 vary l_discount & l_quantity (vary l_quantity)
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 2 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 3 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 4 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 5 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 6 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 7 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 8 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query from lineitem where l_discount < 0.01 and l_quantity < 9 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 10 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 11 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 12 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 13 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 5 query  from lineitem where l_discount < 0.01 and l_quantity < 14 ;

\o

\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query  from lineitem where l_extendedprice > 100000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 99000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 98000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 97000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 96000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 95000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 94000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 93000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 92000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 91000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 90000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 89000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 88000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 87000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 86000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 85000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 84000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 83000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 82000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 81000 ;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 6 query from lineitem where l_extendedprice > 80000 ;

\o

--7 Q7 vary l_partkey & l_extendedprice (partkey fixed)
--partkey 100k-2M by 100k incr
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query from lineitem where l_extendedprice > 80000 and l_partkey < 900000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1000000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 1900000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 7 query  from lineitem where l_extendedprice > 80000 and l_partkey < 2000000;

\o
--8 Q8 vary l_suppkey & l_extendedprice (suppkey fixed)
--supkey 5k-75k by 5k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query from lineitem where l_extendedprice > 80000 and l_suppkey < 5000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 10000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 15000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 20000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 25000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 30000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 35000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 40000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 45000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 55000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 60000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 65000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 70000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 8 query  from lineitem where l_extendedprice > 80000 and l_suppkey < 75000;

\o

--9 Q9 vary l_partkey & l_extendedprice (l_extendedprice fixed)
--move l_extendedprice from 75k to 120k in increments of 5k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 75000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 80000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 85000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 90000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query from lineitem where l_extendedprice > 95000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 100000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 105000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 110000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 115000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 9 query  from lineitem where l_extendedprice > 120000 and l_partkey < 100000;

\o
--10 Q10 vary l_suppkey & l_extendedprice (l_extendedprice fixed)
--75k-95k in increments of 2 or 3 k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 75000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 77000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 80000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 82000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 85000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 88000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 92000 and l_suppkey < 50000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 10 query from lineitem where l_extendedprice > 95000 and l_suppkey < 50000;

\o
--11 Q11 vary l_partkey & l_extendedprice & l_suppkey (l_extendedprice & l_partkey fixed)
--vary suppkey 6k-75k by 6k 
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 72000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 66000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 54000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 48000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 42000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 36000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 24000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 18000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 12000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 11 query from lineitem where l_extendedprice > 75000 and l_suppkey < 6000 and l_partkey < 1200000;

\o
--12 Q12 vary l_partkey & l_extendedprice & l_suppkey (l_extendedprice & l_suppkey fixed)
--vary partkey by 100k to 100k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 900000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query  from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1000000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 12 query  from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1100000;

\o
--13 Q13 vary l_partkey & l_extendedprice & l_suppkey (l_suppkey & l_partkey fixed)
--vary price from 75-95k by 3k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 78000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 13 query from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;

\o
--14 Q14 vary l_partkey & l_extendedprice & l_suppkey (l_suppkey fixed)
--l_partkey=1100000 to 2M in incr of 60k,  l_extendedprice=95k to 80 in incr of 1k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 80000 and l_suppkey < 75000 and l_partkey < 1100000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 81000 and l_suppkey < 75000 and l_partkey < 1160000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 82000 and l_suppkey < 75000 and l_partkey < 1220000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 83000 and l_suppkey < 75000 and l_partkey < 1280000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 84000 and l_suppkey < 75000 and l_partkey < 1340000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 85000 and l_suppkey < 75000 and l_partkey < 1400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 86000 and l_suppkey < 75000 and l_partkey < 1460000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 87000 and l_suppkey < 75000 and l_partkey < 1520000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 88000 and l_suppkey < 75000 and l_partkey < 1580000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 89000 and l_suppkey < 75000 and l_partkey < 1640000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 90000 and l_suppkey < 75000 and l_partkey < 1700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 91000 and l_suppkey < 75000 and l_partkey < 1760000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 92000 and l_suppkey < 75000 and l_partkey < 1820000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 93000 and l_suppkey < 75000 and l_partkey < 1880000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 94000 and l_suppkey < 75000 and l_partkey < 1940000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 14 query from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 2000000;

\o
--15 Q15 vary l_partkey & l_extendedprice & l_suppkey (l_partkey fixed)
--l_suppkey=75 to 55 in incr of 1.5k,  l_extendedprice=95k to 80 in incr of 1k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 80000 and l_suppkey < 55000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 81000 and l_suppkey < 56000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 82000 and l_suppkey < 57000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 83000 and l_suppkey < 58000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 84000 and l_suppkey < 59000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 85000 and l_suppkey < 60000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 86000 and l_suppkey < 61000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 87000 and l_suppkey < 62000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 88000 and l_suppkey < 63000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 89000 and l_suppkey < 64000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 90000 and l_suppkey < 65000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 91000 and l_suppkey < 66000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 92000 and l_suppkey < 67000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 93000 and l_suppkey < 68000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 94000 and l_suppkey < 69000 and l_partkey < 1200000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 15 query from lineitem where l_extendedprice > 95000 and l_suppkey < 75000 and l_partkey < 1200000;

\o
--16 Q16 vary l_partkey & l_extendedprice & l_suppkey (l_extendedprice fixed)
--l_suppkey=90k to 25k in incr of 5k,  l_partkey=900k to 250k in incr of 50k
\o | cat - >> /home/ubuntu/export/control-explain.txt

explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 25000 and l_partkey < 250000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 30000 and l_partkey < 300000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 35000 and l_partkey < 350000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 40000 and l_partkey < 400000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 45000 and l_partkey < 450000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 50000 and l_partkey < 500000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 55000 and l_partkey < 550000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 60000 and l_partkey < 600000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 65000 and l_partkey < 650000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 70000 and l_partkey < 700000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 75000 and l_partkey < 750000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 80000 and l_partkey < 800000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 85000 and l_partkey < 850000;
explain select cast (count(l_extendedprice) as float)/59986052 selectivity, 16 query from lineitem where l_extendedprice > 75000 and l_suppkey < 90000 and l_partkey < 900000;

\o

