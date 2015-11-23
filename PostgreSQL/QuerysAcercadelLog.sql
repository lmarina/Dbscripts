

--Consulta la ubicacion del log
select pg_current_xlog_location()


--Indica el nombre del archiv log
select pg_xlogfile_name(pg_current_xlog_location());


--System Administration Functions
--http://www.postgresql.org/docs/9.1/static/functions-admin.html

