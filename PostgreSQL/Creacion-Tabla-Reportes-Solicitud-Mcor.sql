SELECT 
  b.nombre, 
  t_grupo_financiero.nombre AS grupo, 
  a.duracion, 
  a.capital, 
  a.expediente, 
  a.fecha_registro, 
  a.tomo, 
  a.folio, 
  a.resolucion, 
  a.fecha_intervencion, 
  a.gaceta_intervencion, 
  a.fecha_liquidacion, 
  a.gaceta_liquidacion, 
  a.fecha_gaceta_liquidacion, 
  c.nombre AS empresa, 
  t_estatus.nombre AS estatus, 
  t_registros.nombre AS registro, 
  aa.numero AS nro_intervencion, 
  aa.fecha_designacion AS go_des_int, 
  aa.gaceta AS go_int, 
  aa.fecha_gaceta AS fecha_go_int,
  c1.nombre as interventor, 
  a.empresaid, 
  aaa.personaid AS persona, 
  aaa.tipo_directivo, 
  aaa.fecha_nombramiento AS fecha_nomb_jd,
  c2.nombre as junta
FROM 
  ejv.t_empresas_vinculadas AS a, 
  ejv.t_bancos AS b, 
  ejv.t_grupo_financiero, 
  ejv.t_personas AS c, 
  ejv.t_estatus, 
  ejv.t_registros, 
  ejv.t_intervencion as aa, 
  ejv.t_junta_directiva as aaa,
  ejv.t_personas AS c1,
  ejv.t_personas AS c2
WHERE 
  a.bancoid = b.bancoid AND
  a.empresaid = aa.empresaid AND
  a.empresaid = aaa.empresaid AND
  b.grupoid = t_grupo_financiero."grupoID" AND
  t_estatus.estatusid = a.estatusid AND
  t_registros.registroid = a.registroid AND
  a.personaid = c.personaid AND
  aa.personaid = c1.personaid AND
  aaa.personaid = c2.personaid
  ;

  alter table ejv.t_junta_directiva alter column cargo set data  type int using cargo::int;

create table ejv.t_reportes (
reporteid serial,
empresa character varying (100),
subempresa character varying (100),
nivel integer,
acciones numeric(7,2),
porcentaje numeric(7,2),
estatus character varying (80),
usuario character varying(20) NOT NULL DEFAULT "current_user"(),
ipdir character varying(20) NOT NULL DEFAULT inet_client_addr(),
fecha timestamp without time zone DEFAULT now()
)


GRANT ALL ON TABLE ejv.t_reportes TO "Supervisor";
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ejv.t_reportes TO grupoanalistas;
COMMENT ON TABLE ejv.t_reportes
  IS 'Tabla para los reportes';

GRANT ALL ON TABLE ejv."t_reportes_reporteid_seq" TO "Supervisor";
GRANT ALL ON TABLE ejv."t_reportes_reporteid_seq" TO grupoanalistas;
