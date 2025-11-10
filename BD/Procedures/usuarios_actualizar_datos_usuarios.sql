 
/****** Object:  StoredProcedure [dbo].[usuarios_insertar_datos_usuarios]    Script Date: 17/6/2023 20:33:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop PROCEDURE [dbo].[usuarios_actualizar_datos_usuarios]
CREATE PROCEDURE [dbo].[usuarios_actualizar_datos_usuarios]
	 @consecutivo bigint
	,@nombre varchar(100)
    ,@apellido varchar(100)
    ,@id_genero	tinyint
    ,@fecha_nacimiento DATETIME
    ,@telefono varchar(15)
    ,@email varchar(100)
    ,@direccion varchar(100)
    ,@direccion_detalle varchar(100)
    ,@id_comuna smallint
    ,@oficio varchar(50)
    ,@medio_enterar smallint
	,@medicamentos_alergias varchar(200)
	,@embarazo bit
	,@meses_embarazo tinyint
	,@observaciones_especiales varchar(max)
	,@examen_visual bit
    ,@id_rol varchar(1000)
	,@id_sede varchar(1000)
    ,@usuario_modificacion varchar(50)
AS
BEGIN

BEGIN TRAN
	BEGIN TRY

		DECLARE @POSICIONROLES SMALLINT
		DECLARE @POSICIONSEDES SMALLINT

		CREATE TABLE #ROLES (
		ID_ROL SMALLINT , id_usuario smallint)
		CREATE NONCLUSTERED INDEX #IX_ROLES ON #ROLES (ID_ROL,id_usuario)

		CREATE TABLE #SEDES (
		ID_SEDE SMALLINT , id_usuario smallint)
		CREATE NONCLUSTERED INDEX #IX_SEDES ON #SEDES (ID_SEDE,id_usuario)

		update [dbo].[usuarios] set
			[nombre]= @nombre
           ,[apellido]= @apellido
           ,[id_genero]= @id_genero
           ,[fecha_nacimiento]= @fecha_nacimiento
           ,[telefono]=@telefono
           ,[email]= @email
           ,[direccion]=@direccion
           ,[direccion_detalle]=@direccion_detalle
           ,[id_comuna]=@id_comuna
           ,[oficio]=@oficio
           ,[medio_enterar]=@medio_enterar
		   ,medicamentos_alergias =@medicamentos_alergias
		   ,embarazo =@embarazo
		   ,meses_embarazo =@meses_embarazo
	       ,observaciones_especiales =@observaciones_especiales
	       ,examen_visual =@examen_visual
           ,[usuario_modificacion]=@usuario_modificacion
           ,[fecha_modificacion]= getdate()
		   where consecutivo= @consecutivo
	
		IF @@ROWCOUNT=1
			BEGIN
				SET @POSICIONROLES = CHARINDEX(',',@id_rol,1)

				WHILE @POSICIONROLES > 0
					BEGIN
						INSERT INTO #ROLES VALUES (CONVERT(SMALLINT,SUBSTRING(@id_rol,1,@POSICIONROLES-1)), @consecutivo)
						SET @id_rol = SUBSTRING(@id_rol,@POSICIONROLES+1,8000)
						SET @POSICIONROLES = CHARINDEX(',',@id_rol,1)
					END

				IF LEN(@id_rol) > 0
					BEGIN
						INSERT INTO #ROLES VALUES (CONVERT(SMALLINT,@id_rol),@consecutivo)
					END
				
				--Elimina los roles anteriores
				Delete from usuarios_roles where id_usuario=@consecutivo

				--Inserta la nueva informacion
				insert into usuarios_roles(id_usuario, id_rol)
				select id_usuario , ID_ROL
				from #ROLES

				if @@ROWCOUNT=0
					BEGIN
						RAISERROR ('Error al asingar el rol', 16,  1 );
					END
					
				SET @POSICIONSEDES = CHARINDEX(',',@id_sede,1)

						WHILE @POSICIONSEDES > 0
							BEGIN
								INSERT INTO #SEDES VALUES (CONVERT(SMALLINT,SUBSTRING(@id_sede,1,@POSICIONSEDES-1)), @consecutivo)
								SET @id_sede = SUBSTRING(@id_sede,@POSICIONSEDES+1,8000)
								SET @POSICIONSEDES = CHARINDEX(',',@id_sede,1)
							END

						IF LEN(@id_sede) > 0
							BEGIN
								INSERT INTO #SEDES VALUES (CONVERT(SMALLINT,@id_sede),@consecutivo)
							END

						--Elimina los roles anteriores
						Delete from usuarios_sedes where id_usuario=@consecutivo

						--Inserta la nueva informacion
						insert into usuarios_sedes(id_usuario, id_sede) select id_usuario , ID_SEDE from #SEDES

						if @@ROWCOUNT=0
							BEGIN
								RAISERROR ('Error al asingar la sede', 16,  1 );
							END	

							 

			END
		ELSE
			BEGIN
				RAISERROR ('Error al actualizar el usuario', 16,  1 );
			END
	COMMIT TRAN	   
END TRY
BEGIN CATCH 
	ROLLBACK TRAN
    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
	SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(),@ErrorState = ERROR_STATE()
	RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
END CATCH


	 
   
END