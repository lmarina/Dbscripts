
CREATE TABLE auditoria.logtable
(
  logid serial NOT NULL,
  tabla auditoria.tablas,
  fecha timestamp without time zone DEFAULT now(),
  usuario usuario,
  accion auditoria.accion,
  query text,
  ipdir ipdir,
  data_original json,
  data_nueva json
)
WITH (
  OIDS=FALSE
);
ALTER TABLE auditoria.logtable
  OWNER TO postgres;
GRANT ALL ON TABLE auditoria.logtable TO postgres;
--GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE auditoria.logtable TO "UsuarioDonaciones";


CREATE OR REPLACE FUNCTION auditoria.autoria_generica()
  RETURNS trigger AS
$BODY$
DECLARE
    v_old_data json := NULL;
    v_new_data json := NULL;
BEGIN

    IF TG_OP IN ('UPDATE','DELETE') THEN 
        v_old_data = row_to_json(OLD); 
    END IF; 
    IF TG_OP IN ('INSERT','UPDATE') THEN 
        v_new_data = row_to_json(NEW); 
    END IF; 
    INSERT INTO  auditoria.logtable (tabla,usuario,accion,query,data_nueva,data_original)
    VALUES (TG_TABLE_SCHEMA||'.'||TG_TABLE_NAME,session_user,TG_OP, current_query(),v_new_data,v_old_data);
    RETURN NEW;
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auditoria.autoria_generica()
  OWNER TO lmarin;
GRANT EXECUTE ON FUNCTION auditoria.autoria_generica() TO public;
GRANT EXECUTE ON FUNCTION auditoria.autoria_generica() TO lmarin;
COMMENT ON FUNCTION auditoria.autoria_generica() IS 'Version 1';


CREATE TRIGGER auditlog
  AFTER INSERT OR UPDATE OR DELETE
  ON ejv.t_empresas_vinculadas
  FOR EACH ROW
  EXECUTE PROCEDURE auditoria.auditoria_generica();
