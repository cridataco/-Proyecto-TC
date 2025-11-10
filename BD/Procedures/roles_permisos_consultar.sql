 
--drop procedure roles_permisos_consultar
CREATE PROCEDURE roles_permisos_consultar
    @id_rol SMALLINT,
	@modulo varchar(20),
	@ruta varchar(30)
AS
BEGIN

select m.nombre as modulo, mr.sub_ruta as ruta, mra.accion, rp.activo as acceso  from modulos m
inner join modulos_rutas mr on mr.id_modulo= m.consecutivo_modulo
inner join modulos_rutas_acciones mra on mra.id_modulo_ruta = mr.consecutivo_modulo_ruta
inner join roles_permisos rp on rp.id_modulo_ruta_accion= mra.consecutivo_modulo_ruta_accion
where rp.id_rol= @id_rol and m.nombre=@modulo and mr.sub_ruta=@ruta

END;