 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure cursos_insertar
create procedure cursos_insertar

@nombre varchar(50)
,@descripcion varchar(200)
,@valor decimal(28,0)
,@cantidad_clases tinyint
,@estado bit
,@usuario_creacion varchar(15) 

as
 
begin

		INSERT INTO [dbo].[cursos]
				   ([nombre]
				   ,[descripcion]
				   ,[valor]
				   ,[estado]
				   ,[usuario_creacion]
				   ,[cantidad_clases]
				   ,[fecha_creacion]
				   ,[usuario_modificacion]
				   ,[fecha_modificacion])
			 VALUES
				   (@nombre 
					,@descripcion
					,@valor
					,@estado 
				    ,@usuario_creacion
					,@cantidad_clases
				    ,GETDATE()
				    ,@usuario_creacion
				    ,GETDATE())

end

