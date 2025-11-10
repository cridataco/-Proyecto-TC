 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure curso_estudiante_consultar_id_usuario 
CREATE PROCEDURE curso_estudiante_consultar_id_usuario
    @id_estudiante INT
AS
BEGIN
    SELECT
        c.consecutivo                 AS id_curso,
        ce.consecutivo                AS id_curso_estudiante,
        c.nombre                      AS curso,
        COALESCE(c.cantidad_clases, 0)      AS cantidad_clases,
        COALESCE(ce.clases_restantes, 0)      AS clases_restantes,
        COALESCE(ce.estado_curso, 0)          AS estado_curso,
        COALESCE(ce.resultado_curso, 0)       AS resultado_curso,
        ce.valor_curso_estudiante_registro as valor_curso_pagado,
        COALESCE(ce.fecha_creacion, GETDATE()) AS fecha_creacion
    FROM cursos_estudiante ce
    INNER JOIN cursos c
        ON c.consecutivo = ce.id_curso
    WHERE ce.id_estudiante = @id_estudiante;
END
