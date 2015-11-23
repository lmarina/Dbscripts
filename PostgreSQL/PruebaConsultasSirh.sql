select eshabil('11/10/2015')
select current_date;

select eshabil(current_date)

select buscar_jubilacion_trabajador(10111557)


select * from trabajador where cedula=7925733;
select * from personal where id_personal=403


select a.id_personal,a.primer_nombre, a.primer_apellido,a.cedula,a.rif,b.sueldo_basico from personal as a
inner join trabajador as b on a.cedula=b.cedula
order by a.primer_apellido

select * from organismo

select * from cargo

select * from dependencia

select * from v_historico where id_trabajador=426
order by fecha


select calcular_anios('15/10/2015','15/11/2010')
select dias_totales('15/10/2015','15/11/2010')
