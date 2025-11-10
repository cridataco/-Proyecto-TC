 
CREATE PROCEDURE pagos_y_abonos_consultar_id_curso_estudiante
    @id_curso_estudiante BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT  consecutivo  ,
    id_curso_estudiante ,
    valor ,
    fecha_creacion ,
    usuario_creacion ,
    fecha_modificacion ,
    usuario_modificacion 
    FROM pagos_y_abonos
    WHERE id_curso_estudiante = @id_curso_estudiante
    ORDER BY fecha_creacion DESC;
END