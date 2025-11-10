 
/****** Object:  StoredProcedure [dbo].[usuarios_insertar_datos_usuarios]    Script Date: 17/6/2023 20:33:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop PROCEDURE [dbo].[usuarios_insertar_datos_usuarios]
CREATE PROCEDURE [dbo].[usuarios_insertar_datos_usuarios]
	 @nombre varchar(100)
    ,@apellido varchar(100)
    ,@run varchar(15)
    ,@id_genero	tinyint
    ,@fecha_nacimiento DATETIME
    ,@telefono varchar(15)
    ,@email varchar(100)
    ,@direccion varchar(100)
    ,@direccion_detalle varchar(100)=null
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
    ,@usuario_creacion varchar(50)
	,@id_usuario_creado bigint OUTPUT
AS
BEGIN
BEGIN TRAN
	BEGIN TRY
		declare @consecutivo_usuario bigint= 0
		DECLARE @POSICIONROLES SMALLINT
		DECLARE @POSICIONSEDES SMALLINT
	
		CREATE TABLE #ROLES (
		ID_ROL SMALLINT , id_usuario smallint)
		CREATE NONCLUSTERED INDEX #IX_ROLES ON #ROLES (ID_ROL,id_usuario)

		CREATE TABLE #SEDES (
		ID_SEDE SMALLINT , id_usuario smallint)
		CREATE NONCLUSTERED INDEX #IX_SEDES ON #SEDES (ID_SEDE,id_usuario)

		INSERT INTO [dbo].[usuarios]
           ([nombre]
           ,[apellido]
           ,[run]
           ,[id_genero]
           ,[fecha_nacimiento]
           ,[telefono]
           ,[email]
           ,[direccion]
           ,[direccion_detalle]
           ,[id_comuna]
           ,[oficio]
           ,[medio_enterar] 
		   ,medicamentos_alergias 
		   ,embarazo 
		   ,meses_embarazo 
	       ,observaciones_especiales 
	       ,examen_visual 
		   ,[password]
           ,[usuario_creacion]
           ,[fecha_creacion])
     VALUES
           (@nombre
           ,@apellido
           ,@run
           ,@id_genero
           ,@fecha_nacimiento
           ,@telefono
           ,@email
           ,@direccion
           ,@direccion_detalle
           ,@id_comuna
           ,@oficio
           ,@medio_enterar 
		   ,@medicamentos_alergias 
			,@embarazo 
			,@meses_embarazo 
			,@observaciones_especiales 
			,@examen_visual 
		   ,null
           ,@usuario_creacion
           ,GETDATE()
           )
		set @consecutivo_usuario= @@IDENTITY
		IF @@ROWCOUNT=1 and @consecutivo_usuario>0
			BEGIN --inicio IF @@ROWCOUNT=1 and @consecutivo_usuario>0
				SET @POSICIONROLES = CHARINDEX(',',@id_rol,1)

				WHILE @POSICIONROLES > 0
					BEGIN
						INSERT INTO #ROLES VALUES (CONVERT(SMALLINT,SUBSTRING(@id_rol,1,@POSICIONROLES-1)), @consecutivo_usuario)
						SET @id_rol = SUBSTRING(@id_rol,@POSICIONROLES+1,8000)
						SET @POSICIONROLES = CHARINDEX(',',@id_rol,1)
					END

				IF LEN(@id_rol) > 0
					BEGIN
						INSERT INTO #ROLES VALUES (CONVERT(SMALLINT,@id_rol),@consecutivo_usuario)
					END

			
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
								INSERT INTO #SEDES VALUES (CONVERT(SMALLINT,SUBSTRING(@id_sede,1,@POSICIONSEDES-1)), @consecutivo_usuario)
								SET @id_sede = SUBSTRING(@id_sede,@POSICIONSEDES+1,8000)
								SET @POSICIONSEDES = CHARINDEX(',',@id_sede,1)
							END

						IF LEN(@id_sede) > 0
							BEGIN
								INSERT INTO #SEDES VALUES (CONVERT(SMALLINT,@id_sede),@consecutivo_usuario)
							END

			
						insert into usuarios_sedes(id_usuario, id_sede)
						select id_usuario , ID_SEDE
						from #SEDES

						if @@ROWCOUNT=0
							BEGIN
								RAISERROR ('Error al asingar la sede', 16,  1 );
							END	

			

		--retorna id_usuario
		SET @id_usuario_creado= @consecutivo_usuario

			END --fin IF @@ROWCOUNT=1 and @consecutivo_usuario>0
		ELSE
			BEGIN
				RAISERROR ('Error al insertar el usuario', 16,  1 );
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