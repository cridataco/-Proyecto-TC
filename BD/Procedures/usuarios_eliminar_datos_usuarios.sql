 
/****** Object:  StoredProcedure [dbo].[usuarios_insertar_datos_usuarios]    Script Date: 17/6/2023 20:33:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop PROCEDURE [dbo].[usuarios_eliminar_datos_usuarios]
CREATE PROCEDURE [dbo].[usuarios_eliminar_datos_usuarios]
	 @consecutivo bigint,
	 @usuario_modificacion varchar(15)
AS
BEGIN
	
BEGIN TRAN
BEGIN TRY

	  insert into  usuarios_eliminados
	  SELECT [consecutivo]
      ,[nombre]
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
      ,[password]
      ,[usuario_creacion]
      ,[fecha_creacion]
      ,@usuario_modificacion
      ,getdate()
  FROM [dbo].[usuarios] where consecutivo=@consecutivo
	
	 

	IF @@ROWCOUNT=1 
		BEGIN
			delete from usuarios where consecutivo=@consecutivo
			Delete from usuarios_roles where id_usuario=@consecutivo
			Delete from usuarios_sedes where id_usuario=@consecutivo
		
		END
		ELSE
		BEGIN
			RAISERROR ('No se encuentra el usuario ', 16,  1 );
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