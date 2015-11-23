CREATE OR REPLACE FUNCTION auditoria.autoria_generica()
  RETURNS trigger AS
$BODY$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
    /*  If this actually for real auditing (where you need to log EVERY action),
        then you would need to use something like dblink or plperl that could log outside the transaction,
        regardless of whether the transaction committed or rolled back.
    */
 
    /* This dance with casting the NEW and OLD values to a ROW is not necessary in pg 9.0+ */
 
    IF (TG_OP = 'UPDATE') THEN
        v_old_data := ROW(OLD.*);
        v_new_data := ROW(NEW.*);
        INSERT INTO  auditoria.logtable (tabla,usuario,accion,data_original,data_nueva,query) 
        VALUES (TG_TABLE_SCHEMA||'.'||TG_TABLE_NAME,session_user,TG_OP,v_old_data,v_new_data, current_query());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := ROW(OLD.*);
        INSERT INTO  auditoria.logtable (tabla,usuario,accion,data_original,data_nueva,query)
        VALUES (TG_TABLE_SCHEMA||'.'||TG_TABLE_NAME,session_user,TG_OP,v_old_data,'', current_query());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        v_new_data := ROW(NEW.*);
        INSERT INTO  auditoria.logtable (tabla,usuario,accion,data_original,data_nueva,query)
        VALUES (TG_TABLE_SCHEMA||'.'||TG_TABLE_NAME,session_user,TG_OP,'',v_new_data, current_query());
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now();
        RETURN NULL;
    END IF;
 
EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auditoria.autoria_generica()
  OWNER TO "Supervisor";
GRANT EXECUTE ON FUNCTION auditoria.autoria_generica() TO "Supervisor";
GRANT EXECUTE ON FUNCTION auditoria.autoria_generica() TO public;
GRANT EXECUTE ON FUNCTION auditoria.autoria_generica() TO grupoanalistas;
