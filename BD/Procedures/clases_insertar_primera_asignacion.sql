 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--clases_insertar_primera_asignacion 2,'300,301,302','admin'
-- drop procedure clases_insertar_primera_asignacion
create procedure clases_insertar_primera_asignacion
@consecutivo_curso_estudiante int,
@listado_disponibilidad varchar(max), 
@usuario_creacion varchar(15)
as

 

BEGIN TRAN
	BEGIN TRY


		 DECLARE @POSICION SMALLINT
		 DECLARE @CONSECUTIVO_ASINGACION BIGINT = 0  
		 DECLARE @COMENTARIO varchar(15)='Clase asignada'
		 DECLARE @ESTADOCLASE tinyint =1

		CREATE TABLE #clasesTMP (
		id_agenda int,
		id_estado_clase tinyint,
		consecutivo_curso_estudiante int,
		comentario varchar(100) 
		)


		SET @POSICION = CHARINDEX(',',@listado_disponibilidad,1)
		WHILE @POSICION > 0
			BEGIN
			    INSERT INTO #clasesTMP VALUES (CONVERT(SMALLINT,SUBSTRING(@listado_disponibilidad,1,@POSICION-1)), @ESTADOCLASE,
				@consecutivo_curso_estudiante, @COMENTARIO)
				SET @listado_disponibilidad = SUBSTRING(@listado_disponibilidad,@POSICION+1,8000) 
				SET @POSICION = CHARINDEX(',',@listado_disponibilidad,1) 
				
				 
		END
		IF LEN(@listado_disponibilidad) > 0
			BEGIN
				 INSERT INTO #clasesTMP VALUES  (CONVERT(SMALLINT,@listado_disponibilidad), @ESTADOCLASE
				,@consecutivo_curso_estudiante, @COMENTARIO) 
				 
			END
			 
		INSERT INTO [dbo].[clases]
           ([id_agenda]
           ,[id_estado_clase]
           ,[consecutivo_curso_estudiante]
           ,[comentario]
           ,[usuario_creacion]
           ,[fecha_creacion]
           ,[usuario_modificacion]
           ,[fecha_modificacion])
		SELECT id_agenda,id_estado_clase,@consecutivo_curso_estudiante,comentario,@usuario_creacion,GETDATE(),@usuario_creacion,GETDATE()
		FROM #clasesTMP

 	  
END TRY
 
BEGIN CATCH 
		IF @@TRANCOUNT > 0
		 BEGIN
			ROLLBACK TRANSACTION
			DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
			SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(),@ErrorState = ERROR_STATE()
			RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState) 
		 END

 
	END CATCH

	IF @@TRANCOUNT > 0
			BEGIN
				COMMIT TRANSACTION
			END 
	GO