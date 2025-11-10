 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop procedure curso_estudiante_modificar
CREATE OR ALTER PROCEDURE dbo.curso_estudiante_modificar
    @id_curso_estudiante BIGINT,            -- Identificador �nico del registro
    @estado_curso         TINYINT = NULL,   -- 1=activo,0=inactivo (opcional)
    @resultado_curso      TINYINT = NULL,   -- 1=aprobado,2=reprobado,... (opcional)
    @usuario_modificacion VARCHAR(15)       -- Qui�n hace la modificaci�n
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRAN;
    BEGIN TRY
        UPDATE dbo.cursos_estudiante
        SET
            estado_curso      = COALESCE(@estado_curso,     estado_curso),
            resultado_curso   = COALESCE(@resultado_curso,  resultado_curso),
            usuario_modificacion = @usuario_modificacion,
            fecha_modificacion   = GETDATE()
        WHERE consecutivo = @id_curso_estudiante;

        IF @@ROWCOUNT = 0
            THROW 50001, 'No se encontr� el curso_estudiante con ese ID.', 1;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRAN;
        DECLARE
            @msg NVARCHAR(4000) = ERROR_MESSAGE(),
            @sev INT           = ERROR_SEVERITY(),
            @stt INT           = ERROR_STATE();
        RAISERROR(@msg, @sev, @stt);
    END CATCH
END
GO
