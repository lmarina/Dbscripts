
/*
Por: Luis Marin
*/

CREATE TABLE ejv.t_cargo
(
  "cargoID" serial NOT NULL, -- Indentificador �nico del registro
   descripcion character varying(100) COLLATE pg_catalog."es_VE.utf8" NOT NULL, -- Descripcion
  usuario character varying(20) NOT NULL DEFAULT "current_user"(), -- �ltimo usuario que modific� el registro
  "ipDir" character varying(20) NOT NULL DEFAULT inet_client_addr(), -- Direcci�n IP origen de la conexi�n
  fecha timestamp without time zone DEFAULT now(),
  CONSTRAINT pk_cargo PRIMARY KEY ("cargoID")
)
