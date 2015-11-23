--Tamaño de la bd
select pg_size_pretty(pg_database_size(current_database()));
-- 05/11/2014 32 mb
--Tamaño de las mayores tablas
select table_name,pg_size_pretty(pg_relation_size(table_name)) as size from information_schema.tables
where table_schema not in ('information_schema','pg_catalog')
order by size desc limit 20;