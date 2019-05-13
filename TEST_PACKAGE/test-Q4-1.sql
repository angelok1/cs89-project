/*
select
o_orderpriority,
count(*) as order_count from
orders where
o_orderdate >= date '[DATE]'
and o_orderdate < date '[DATE]' + interval '3' month and exists (
) group by
o_orderpriority order by
o_orderpriority;
*/