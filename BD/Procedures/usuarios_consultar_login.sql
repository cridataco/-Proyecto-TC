 
--drop procedure [dbo].[usuarios_consultar_login]
Create PROCEDURE [dbo].[usuarios_consultar_login] 
	@run VARCHAR(20),
	@password VARCHAR(100)
AS
BEGIN
	Select consecutivo,
			nombre ,
			apellido 
			into #tmp
		    from usuarios u
			where u.run=@run and u.password=@password

		select * from #tmp

		select r.consecutivo,r.nombre  
		into #tmp_roles
		from usuarios_roles ur inner join roles r on r.consecutivo = ur.id_rol
		where ur.id_usuario in( select consecutivo from #tmp )

		select * from #tmp_roles

		--select arbol_permisos
		--from roles_permisos where id_rol in(select consecutivo from #tmp_roles)
	
END