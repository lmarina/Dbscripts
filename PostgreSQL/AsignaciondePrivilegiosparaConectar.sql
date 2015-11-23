/*
REFERENCIA PARA DOCUMENTARSE

http://www.postgresql.org/docs/9.0/static/sql-grant.html

*/

GRANT CONNECT ON DATABASE tablas_comunes TO grupoanalistas;
GRANT TEMPORARY ON DATABASE tablas_comunes TO grupoanalistas;
GRANT CREATE ON DATABASE tablas_comunes TO grupoanalistas;