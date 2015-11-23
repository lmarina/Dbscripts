/* Ubicacion de Los Archivos de Configuracion */
select name,setting from pg_settings where category = 'File Locations';

/* Signos Vitales del servidor*/
select name, context, unit, setting,boot_val,reset_val from pg_settings where name in
('listen_addresses','max_connections','shared_buffers','effective_cache_size','work_mem','maintenance_work_mem')
order by context,name;


/* Actividad del Servidor e identificacion de procesos (PID)*/
select * from pg_stat_activity;

/* Cancelar queries de una coneccion (PId) */

select pg_cancel_backend(pid);

/*Kill a specific connection */

select pg_terminate_backend(pid);

/* Backing up Roles and TableSpaces */

pg_dumpall -h localhost -U postgres -port=5432 -f myglobals.sql -globals-only

/* Backing up Roles */

pg_dumpall -h 10.100.10.90 -U postgres -port=5432 -f myroles.sql --roles-only

/* Backup de un esquema completo y varios mas */

pg_dump -h 10.100.10.90 -p 5432 -U Supervisor -F c -b -v -n hr -n donacion -f
donacion_schemas.backup B_DONACIONES

pg_dump -h l0.100.10.90  -p 5432 -U postgres -F d -f /somepath/a_directory B_DONACIONES
