 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Procedimiento almacenado que consulta la agenda del estudiante
--retorna las fechas para asignar clases disponibles en el mes y anio 
--drop procedure clases_fechas_disponibles_asignacion_anio_mes '2024-01-02,2024-03-01,2020-04-01' 
create procedure clases_fechas_disponibles_asignacion_anio_mes
 @fechas varchar(max)

 as
 begin
 
		
		create table #fechas(
		fecha date
		)

		DECLARE @POSICION SMALLINT
		SET @POSICION = CHARINDEX(',',@fechas,1)

			WHILE @POSICION > 0
				BEGIN
					INSERT INTO #fechas VALUES (SUBSTRING(@fechas,1,@POSICION-1))
					SET @fechas = SUBSTRING(@fechas,@POSICION+1,8000)
					SET @POSICION = CHARINDEX(',',@fechas,1)
				END

			IF LEN(@fechas) > 0
				BEGIN
					INSERT INTO #fechas VALUES (@fechas)
				END

		
		--select * from #fechas

		select distinct
		CAST(agpd.fecha_hora_inicio_clase AS DATE) AS dias
		from agenda_profesor_asginacion agpa 
		inner join agenda_profesor_detalle agpd on agpd.consecutivo_agenda_profesor_asginacion= agpa.consecutivo
		inner join usuarios p on p.consecutivo = agpa.id_profesor
		inner join tipos_clase tc on tc.id_tipo_clase= agpa.id_tipo_clase
		left join clases cl  on agpd.consecutivo= cl.id_agenda
		left join cursos_estudiante ce on ce.consecutivo= cl.consecutivo_curso_estudiante
	    left join usuarios est on est.consecutivo = ce.id_estudiante
		left join estados_clase ec on ec.id_estado_clase= cl.id_estado_clase
		where cl.consecutivo IS NULL
		and YEAR(agpd.fecha_hora_inicio_clase) in(select Year(fecha) from #fechas) 
		AND MONTH(agpd.fecha_hora_inicio_clase) in(select Month(fecha) from #fechas) 
		order by 1
end