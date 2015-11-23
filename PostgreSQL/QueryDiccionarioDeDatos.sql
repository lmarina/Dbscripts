
copy (
SELECT
 isc.table_name,
 isc.ordinal_position::integer AS ordinal_position,
 isc.column_name::character varying AS column_name,
 isc.column_default::character varying AS column_default,
 isc.data_type::character varying AS data_type,
 isc.character_maximum_length::integer AS str_length,
        CASE
            WHEN isc.udt_name::text = 'int4'::text OR isc.udt_name::text = 
'bool'::text THEN isc.data_type::character varying
            ELSE isc.udt_name::character varying
        END AS udt_name
   FROM information_schema.columns isc
  WHERE isc.table_schema::text = 'ejv'::text
  ORDER BY isc.table_name, isc.ordinal_position
  )
  to '/var/lib/postgresql/Diccionario1.txt' DELIMITER ';';

-- Version 2

copy (
 SELECT  c.table_name,
         c.ordinal_position,
         c.column_name::character varying AS column_name,
         pgd.description,
         c.column_default::character varying AS column_default,
         c.data_type::character varying AS data_type,
         c.character_maximum_length::integer AS str_length,
         ccu.constraint_name,
         tc.constraint_type
FROM pg_catalog.pg_statio_all_tables AS st
  INNER JOIN pg_catalog.pg_description pgd ON (pgd.objoid=st.relid)
    LEFT JOIN information_schema.columns c ON (pgd.objsubid=c.ordinal_position
    AND c.table_schema = 'ejv'::text AND c.table_name=st.relname)
    LEFT JOIN information_schema.constraint_column_usage AS ccu ON (ccu.column_name = c.column_name AND ccu.table_name = c.table_name)
    LEFT JOIN information_schema.table_constraints tc ON (c.table_schema = tc.constraint_schema AND tc.table_name = c.table_name and ccu.constraint_name = tc.constraint_name)
WHERE c.table_name is not null
ORDER BY c.table_name, c.ordinal_position
)
to '/var/lib/postgresql/Diccionario3.txt' DELIMITER ';';
