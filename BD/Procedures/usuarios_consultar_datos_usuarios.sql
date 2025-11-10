 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop PROCEDURE [dbo].[usuarios_consultar_datos_usuarios]
create PROCEDURE [dbo].[usuarios_consultar_datos_usuarios]
	@PageNumber tinyint=1,
	@ItemsPerPage tinyint=10,
	@IdRol tinyint=null,
	@Texto varchar(20)= null
AS
BEGIN
	 declare @total int=0
--filtros tabla usuario
;with Preresult as(
			Select consecutivo,
			isnull(nombre,'') as nombre ,
			isnull(apellido,'') as apellido ,
			isnull(run,'') as run ,
			ur.id_rol,
			telefono ,
			email,
			u.pago_aprobado,
			u.acceso_habilitado  
		    from usuarios u
			left join comunas c on c.id= u.id_comuna
			left join provincias p on p.id = c.provincia_id
			left join regiones r on r.id= p.region_id
			left join generos g on g.id = u.id_genero
			join usuarios_roles ur on ur.id_usuario= u.consecutivo
			where ur.id_rol=(ISNULL(@IdRol, ur.id_rol))
			AND lower(ISNULL(nombre,'')) + ' ' + lower(ISNULL(apellido,'')) +  ' ' + lower(ISNULL(run,''))  +' ' + lower(isnull(telefono,'')) +' ' + lower(isnull(email ,''))
			LIKE '%'+ lower(Isnull(@Texto,'')) + '%' 
			
) 	

			select distinct consecutivo,nombre,apellido,run,telefono,email,id_rol, pago_aprobado, acceso_habilitado
			into #tmpResult
			from Preresult

			SELECT @Total = COUNT(1) FROM #tmpResult
	 
			select @total as total

			select * from #tmpResult
			order by consecutivo 
			OFFSET (@PageNumber-1)*@ItemsPerPage ROWS
			FETCH NEXT @ItemsPerPage ROWS ONLY
	 

END