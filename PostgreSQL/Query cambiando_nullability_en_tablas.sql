alter table ejv.t_empresas_vinculadas alter column fecha_gaceta_liquidacion drop not null;
alter table ejv.t_empresas_vinculadas alter column fecha_gaceta_liquidacion set default null;