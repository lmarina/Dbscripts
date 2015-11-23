-- Table: ejv.t_empresas_vinculadas

-- DROP TABLE ejv.t_empresas_vinculadas;

CREATE TABLE ejv.t_empresas_vinculadas
(
  empresaid integer NOT NULL DEFAULT nextval('ejv."t_empresas_vinculadas_empresaID_seq"'::regclass), -- Identificador único del registro
  personaid integer NOT NULL, -- Identificador de la empresa
  duracion numeric(5,0) NOT NULL,
  capital numeric(18,2) NOT NULL, -- Capital de la empresa
  estatusid integer NOT NULL, -- Código del estatus de la empresa
  expediente integer NOT NULL,
  registroid integer NOT NULL, -- Código del Registro
  fecha_registro date NOT NULL,
  tomo integer NOT NULL,
  folio integer NOT NULL,
  resolucion text NOT NULL,
  fecha_intervencion date NOT NULL,
  gaceta_intervencion integer NOT NULL,
  fecha_liquidacion date NOT NULL,
  gaceta_liquidacion integer,
  fecha_gaceta_liquidacion date,
  usuario character varying(20) NOT NULL DEFAULT "current_user"(), -- Último usuario que modificó el registro
  fecha timestamp without time zone NOT NULL DEFAULT now(), -- Última fecha de modificación del registro
  ipdir character varying(20) NOT NULL DEFAULT inet_client_addr(), -- Dirección IP origen de la conexión
  bancoid integer NOT NULL, -- Banco en Liquidación al cual esta vinculada el Empresa
  CONSTRAINT pk_empresa PRIMARY KEY (empresaid),
  CONSTRAINT fk_bancos FOREIGN KEY (bancoid)
      REFERENCES ejv.t_bancos (bancoid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_estatus FOREIGN KEY (estatusid)
      REFERENCES ejv.t_estatus (estatusid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_personas FOREIGN KEY (personaid)
      REFERENCES ejv.t_personas (personaid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_registros FOREIGN KEY (registroid)
      REFERENCES ejv.t_registros (registroid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ejv.t_empresas_vinculadas
  OWNER TO "Supervisor";
GRANT ALL ON TABLE ejv.t_empresas_vinculadas TO "Supervisor";
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE ejv.t_empresas_vinculadas TO grupoanalistas;
COMMENT ON TABLE ejv.t_empresas_vinculadas
  IS 'Tabla de Empresas Jurídicas Vinculadas';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.empresaid IS 'Identificador único del registro';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.personaid IS 'Identificador de la empresa';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.capital IS 'Capital de la empresa';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.estatusid IS 'Código del estatus de la empresa';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.registroid IS 'Código del Registro';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.usuario IS 'Último usuario que modificó el registro';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.fecha IS 'Última fecha de modificación del registro';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.ipdir IS 'Dirección IP origen de la conexión';
COMMENT ON COLUMN ejv.t_empresas_vinculadas.bancoid IS 'Banco en Liquidación al cual esta vinculada el Empresa';

