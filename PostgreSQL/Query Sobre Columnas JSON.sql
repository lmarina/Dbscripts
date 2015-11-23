select data_nueva from auditoria.logtable where logid=195
select * from donacion.m_donaciones LIMIT 1
select * from auditoria.logtable
select data_nueva, data_original from auditoria.logtable where logid=195
select data_nueva, data_original->'donacionid' as donacionid from auditoria.logtable where logid=200

select data_nueva->'donacionid' as DonacionIdCambio, data_original->'donacionid' as DonacionIdOriginal from auditoria.logtable where logid=195

select  * from auditoria.logtable where logid=195

select data_original->'donacionid' as DonacionIdOriginal,
       data_original->'fecha_formulario' as fecha_formulario,
       data_original->'numref' as numref,
       data_original->'unidad' as unidad,
       data_original->'personaids' as personaids,
       data_original->'personaidb' as personaidb,
       data_original->'tipodid' as tipodid,
       data_original->'estatusid' as estatusid,
       data_original->'fecha_donacion' as fecha_donacion,
       data_original->'monto_donacion' as monto_donacion,
       data_original->'fecha_comite' as fecha_comite,
       data_original->'monto_comite' as monto_comite,
       data_original->'porc_sugerido' as porc_sugerido,
       data_original->'fecha_presidente' as fecha_presidente,
       data_original->'monto_presidente' as monto_presidente,
       data_original->'porc_aprobado' as porc_aprobado,
       data_original->'fecha_rechazo' as fecha_rechazo,
       data_original->'motivo_rechazo' as motivo_rechazo,
       data_original->'usuario' as usuario,
       data_original->'fecha' as fecha,
       data_original->'ipdir' as ipdir,
       data_original->'origenid' as origenid,     
       data_original->'institucionid' as institucionid,
       data_original->'fecha_remision' as fecha_remision,
       data_original->'motivo_remision' as motivo_remision,
       data_original->'unidad_origen' as unidad_origen,
       data_original->'observaciones_remision' as observaciones_remision,
       data_original->'numexp' as numexp,
       data_original->'ano' as ano,
       data_original->'remision' as remision,
       data_original->'usuariologin' as usuariologin
 from auditoria.logtable where logid=206
 union all
select data_nueva->'donacionid' as DonacionIdOriginal,
       data_nueva->'fecha_formulario' as fecha_formulario,
       data_nueva->'numref' as numref,
       data_nueva->'unidad' as unidad,
       data_nueva->'personaids' as personaids,
       data_nueva->'personaidb' as personaidb,
       data_nueva->'tipodid' as tipodid,
       data_nueva->'estatusid' as estatusid,
       data_nueva->'fecha_donacion' as fecha_donacion,
       data_nueva->'monto_donacion' as monto_donacion,
       data_nueva->'fecha_comite' as fecha_comite,
       data_nueva->'monto_comite' as monto_comite,
       data_nueva->'porc_sugerido' as porc_sugerido,
       data_nueva->'fecha_presidente' as fecha_presidente,
       data_nueva->'monto_presidente' as monto_presidente,
       data_nueva->'porc_aprobado' as porc_aprobado,
       data_nueva->'fecha_rechazo' as fecha_rechazo,
       data_nueva->'motivo_rechazo' as motivo_rechazo,
       data_nueva->'usuario' as usuario,
       data_nueva->'fecha' as fecha,
       data_nueva->'ipdir' as ipdir,
       data_nueva->'origenid' as origenid,     
       data_nueva->'institucionid' as institucionid,
       data_nueva->'fecha_remision' as fecha_remision,
       data_nueva->'motivo_remision' as motivo_remision,
       data_nueva->'unidad_origen' as unidad_origen,
       data_nueva->'observaciones_remision' as observaciones_remision,
       data_nueva->'numexp' as numexp,
       data_nueva->'ano' as ano,
       data_nueva->'remision' as remision,
       data_nueva->'usuariologin' as usuariologin
 from auditoria.logtable where logid=206