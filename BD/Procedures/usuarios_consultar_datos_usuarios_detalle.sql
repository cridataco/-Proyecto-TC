 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop PROCEDURE [dbo].[usuarios_consultar_datos_usuarios_detalle]
Create PROCEDURE [dbo].[usuarios_consultar_datos_usuarios_detalle]
	@consecutivo int
AS
BEGIN
	
 

--filtros tabla usuario
with result as(
	Select consecutivo,
			isnull(nombre,'') as nombre ,
			isnull(apellido,'') as apellido ,
			isnull(run,'') as run ,
			fecha_nacimiento,
			id_genero,
			isnull(g.genero,'') as genero,
			telefono ,
			email ,
			isnull(password,'') as password,
			direccion ,
			isnull(direccion_detalle,'') as direccion_detalle ,
			r.id as id_region,
			isnull(r.region,'') as region,
			p.id as id_provincia,
			isnull(p.provincia,'') as provincia,
			c.id as id_comuna,
			isnull(c.comuna,'') as comuna,
			isnull(oficio,'') as oficio ,
			isnull(medio_enterar,0) as medio_enterar,
			isnull(observaciones_especiales, '') as observaciones_especiales, 
			isnull (medicamentos_alergias, '') as medicamentos_alergias,
			embarazo as embarazo,
			isnull (meses_embarazo, 0) as meses_embarazo,
			examen_visual as examen_visual
		    from usuarios u
			left join comunas c on c.id= u.id_comuna
			left join provincias p on p.id = c.provincia_id
			left join regiones r on r.id= p.region_id
			left join generos g on g.id = u.id_genero

		 -- join usuarios_roles ur on ur.id_usuario= u.consecutivo
			where consecutivo=@consecutivo

) 

	select consecutivo,
			nombre ,
			apellido ,
			run ,
			fecha_nacimiento,
			id_genero,
			 genero,
			telefono ,
			email ,
			password,
			direccion ,
			isnull(direccion_detalle,'') as direccion_detalle ,
			id_region,
			region,
			id_provincia,
			provincia,
			id_comuna,
			comuna,
			oficio ,
			medio_enterar,
			observaciones_especiales, 
			medicamentos_alergias,
			embarazo,
			meses_embarazo,
			examen_visual
			into #tmpusuer
			from result
			
	select * from #tmpusuer

	select id_usuario,id_rol,r.nombre  from usuarios_roles ur inner join roles r on r.consecutivo = ur.id_rol
	where ur.id_usuario in(select consecutivo from #tmpusuer) 

	select id_usuario,id_sede,s.nombre_sede  from usuarios_sedes us inner join sedes s on s.consecutivo= us.id_sede
	where us.id_usuario in(select consecutivo from #tmpusuer)

END