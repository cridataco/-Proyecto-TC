 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE agendas_clases_consultar
--drop procedure agendas_clases_consultar
    @IdProfesor INT = NULL,
    @IdEstudiante INT = NULL,
    @Horario VARCHAR(10) = NULL, -- 'morning' , 'afternoon' o 'night' 
    @ClaseDisponible INT = 0, -- 0: sin filtro, 1: clases activas, 2: clases libres
    @FechaIni DATETIME = NULL,
    @FechaFin DATETIME = NULL
AS
BEGIN
    SELECT 
        agpa.consecutivo AS consecutivo_asignacion, 
        agpd.consecutivo AS consecutivo_agenda,
        agpa.id_profesor,
        ISNULL(p.nombre + ' ' + p.apellido, '') AS profesor,
        agpd.fecha_hora_inicio_clase,
        agpd.fecha_hora_fin_clase,
        ISNULL(cl.consecutivo, 0) AS consecutivo_clase,
        CASE 
            WHEN cl.consecutivo IS NOT NULL THEN CONVERT(BIT, 1) 
            ELSE CONVERT(BIT, 0) 
        END AS clase_asignada,
        agpa.id_tipo_clase,
        tc.tipo_clase,
        ISNULL(cl.id_estado_clase, 0) AS id_estado_clase,
        ISNULL(ec.estado_clase, '') AS estado_clase,
        ISNULL(ce.id_estudiante, 0) AS id_estudiante,
        ISNULL(est.nombre + ' ' + est.apellido, '') AS estudiante,
        ISNULL(cl.comentario, '') AS comentario
    FROM 
        agenda_profesor_asginacion agpa
        INNER JOIN agenda_profesor_detalle agpd ON agpd.consecutivo_agenda_profesor_asginacion = agpa.consecutivo
        INNER JOIN usuarios p ON p.consecutivo = agpa.id_profesor
        INNER JOIN tipos_clase tc ON tc.id_tipo_clase = agpa.id_tipo_clase
        LEFT JOIN clases cl ON agpd.consecutivo = cl.id_agenda
        LEFT JOIN cursos_estudiante ce ON ce.consecutivo = cl.consecutivo_curso_estudiante
        LEFT JOIN usuarios est ON est.consecutivo = ce.id_estudiante
        LEFT JOIN estados_clase ec ON ec.id_estado_clase = cl.id_estado_clase
    WHERE 
        (@IdProfesor IS NULL OR agpa.id_profesor = @IdProfesor)
        AND (@IdEstudiante IS NULL OR ce.id_estudiante = @IdEstudiante)
        AND (@Horario IS NULL OR 
            (@Horario = 'morning' AND CONVERT(TIME, agpd.fecha_hora_inicio_clase) BETWEEN '00:00:00' AND '11:59:59')
            OR (@Horario = 'afternoon' AND CONVERT(TIME, agpd.fecha_hora_inicio_clase) BETWEEN '12:00:00' AND '18:59:59')
            OR (@Horario = 'night' AND CONVERT(TIME, agpd.fecha_hora_inicio_clase) BETWEEN '19:00:00' AND '23:59:59'))
        AND (
            (@ClaseDisponible = 0) 
            OR (@ClaseDisponible = 1 AND ce.id_estudiante IS NOT NULL) 
            OR (@ClaseDisponible = 2 AND ce.id_estudiante IS NULL) 
        )
        AND (
            (@FechaIni IS NULL OR @FechaFin IS NULL) 
            OR (agpd.fecha_hora_inicio_clase BETWEEN @FechaIni AND @FechaFin)
            OR (agpd.fecha_hora_fin_clase BETWEEN @FechaIni AND @FechaFin)
        )
END