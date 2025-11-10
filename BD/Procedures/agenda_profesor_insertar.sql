 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure agenda_profesor_insertar
--agenda_profesor_insertar 5,2,'2024-06-18 08:20:00,2024-06-18 09:00:00&2024-04-18 08:20:00,2024-04-18 09:00:00&2024-04-18 09:10:00,2024-04-18 09:50:00&2024-04-18 10:45:00,2024-04-18 11:25:00&2024-04-18 13:40:00,2024-04-18 14:20:00&2024-04-19 09:10:00,2024-04-19 09:50:00&2024-04-19 13:00:00,2024-04-19 13:40:00&','sql'
create procedure agenda_profesor_insertar  
@id_profesor int,
@id_tipo_clase tinyint,
@lista_fechas VARCHAR(MAX), 
@usuario_creacion varchar(15)

AS
 
 DECLARE @POSICION SMALLINT
 DECLARE @CONSECUTIVO_ASINGACION BIGINT = 0 --valida si ya está creada la asignacion , si es así solo inserta en detalle
	BEGIN TRAN
	BEGIN TRY
	 
	CREATE TABLE #fechas (
	fecha_inicial datetime,
	fecha_final datetime)
		 
	 SELECT @CONSECUTIVO_ASINGACION = consecutivo  FROM agenda_profesor_asginacion WHERE id_profesor= @id_profesor
	 AND id_tipo_clase= @id_tipo_clase


	SET @POSICION = CHARINDEX('&',@lista_fechas,1)
	WHILE @POSICION > 0
		BEGIN
		--select @lista_fechas as lista
			declare @separador smallint =CHARINDEX(',',@lista_fechas,1)
			--select SUBSTRING(@lista_fechas,1,@separador-1), SUBSTRING(@lista_fechas,@separador+1,@separador-1)
			INSERT INTO #fechas VALUES (SUBSTRING(@lista_fechas,1,@separador-1), SUBSTRING(@lista_fechas,@separador+1,@separador-1))
			SET @lista_fechas = SUBSTRING(@lista_fechas,@POSICION+1,8000) 
			SET @POSICION = CHARINDEX('&',@lista_fechas,1) 
		END
	IF LEN(@lista_fechas) > 0
		BEGIN
			--select @lista_fechas as ultima_vuelta
			SET @separador = CHARINDEX(',',@lista_fechas,1)
			INSERT INTO #fechas VALUES (SUBSTRING(@lista_fechas,1,@separador-1), SUBSTRING(@lista_fechas,@separador+1,@separador-1))
		END

		IF @CONSECUTIVO_ASINGACION =0 
			BEGIN
				insert into agenda_profesor_asginacion(id_profesor, id_tipo_clase, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion)
				values(@id_profesor,@id_tipo_clase, @usuario_creacion, GETDATE(),@usuario_creacion,GETDATE()) 

				SET @CONSECUTIVO_ASINGACION= @@IDENTITY
			END
		 --select temp.fecha_inicial,temp.fecha_final, det.fecha_hora_inicio_clase, det.fecha_hora_fin_clase, DET.consecutivo
		 --from #fechas temp
		 --left join agenda_profesor_asginacion asg on asg.id_profesor= @id_profesor and id_tipo_clase=@id_tipo_clase
		 --left join agenda_profesor_detalle det on det.consecutivo_agenda_profesor_asginacion= asg.consecutivo 
		 --and det.fecha_hora_inicio_clase= temp.fecha_inicial and det.fecha_hora_fin_clase= temp.fecha_final
		 --where det.consecutivo is null
		 insert into
		 agenda_profesor_detalle(consecutivo_agenda_profesor_asginacion
		 ,fecha_hora_inicio_clase, fecha_hora_fin_clase, usuario_creacion, 
		 fecha_creacion, usuario_modificacion, fecha_modificacion)
		 select 
		 @CONSECUTIVO_ASINGACION, fecha_inicial,fecha_final, 
		 @usuario_creacion, GETDATE(),@usuario_creacion,GETDATE()
		 from #fechas temp
		 left join agenda_profesor_asginacion asg on asg.id_profesor= @id_profesor and id_tipo_clase=@id_tipo_clase
		 left join agenda_profesor_detalle det on det.consecutivo_agenda_profesor_asginacion= asg.consecutivo 
		 and det.fecha_hora_inicio_clase= temp.fecha_inicial and det.fecha_hora_fin_clase= temp.fecha_final
		 where det.consecutivo is null --de los registros de fechas solo inserta los nuevos, los que ya existen los omite
  		
		 drop table #fechas
		 
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