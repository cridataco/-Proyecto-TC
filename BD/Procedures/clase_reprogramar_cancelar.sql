 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure clase_reprogramar_cancelar 1,1,1,486,'clase REPROGRAMDA','alumno'
CREATE procedure clase_reprogramar_cancelar
@accion tinyint, -- 1 - reprogramar, 2 - cancelar
@consecutivo_curso_estudiante int=null, --necesario para reprogramar
@id_clase int, --id de la clase que se esta cancelando o reprogramando
@id_agenda int=null, --nueva agenda seleccionada, aplica para reprogramar
@comentario VARCHAR(100), 
@usuario_modificacion varchar(15)

AS

BEGIN
 
	BEGIN TRAN
	BEGIN TRY

	declare @claseHistId int=0
	declare @EstadoClase tinyint=0  --estado para la tabla historica 2-cancelada 3 -reprogramada
	declare @idClasenuevo int=0

	
	IF @accion=1 -- REPROGRAMAR
		BEGIN
			set @EstadoClase= 3  
			INSERT INTO clases(  --inserta la nueva clase en estado 1 programada
						id_agenda,
						id_estado_clase ,
						consecutivo_curso_estudiante,
						comentario,
						usuario_creacion,
						fecha_creacion,
						usuario_modificacion,
						fecha_modificacion)	
			VALUES(@id_agenda,1,@consecutivo_curso_estudiante,'',@usuario_modificacion, GETDATE(),@usuario_modificacion,GETDATE()) 
			
			set @idClasenuevo=@@IDENTITY
		
		END

	IF @accion=2 --CANCELAR
		BEGIN
			set @EstadoClase= 2
		END
		   
	
	INSERT INTO clases_hist(
				consecutivo,
				id_clase_nuevo,
				id_agenda,
				id_estado_clase ,
				consecutivo_curso_estudiante,
				comentario,
				usuario_creacion,
				fecha_creacion) 
	SELECT  consecutivo, 
			@idClasenuevo,
			id_agenda,
			id_estado_clase ,
			consecutivo_curso_estudiante,
			@comentario,
			usuario_creacion,
			fecha_creacion FROM clases WHERE consecutivo= @id_clase --INSERTA EL REGISTRO A ELIMINAR EN LA HISTORICA

	DELETE FROM CLASES WHERE consecutivo= @id_clase --ELIMINA LA CLASE, NECESARIO PARA CANCELAR O REPROGRAMAR

	COMMIT TRANSACTION
	END TRY

	BEGIN CATCH 
		IF @@TRANCOUNT > 0
		 BEGIN
			ROLLBACK TRANSACTION
				 
		 END

		 DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		 SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(),@ErrorState = ERROR_STATE()
		 RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
 
	END CATCH

END
	GO