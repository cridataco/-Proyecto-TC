 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop procedure curso_estudiante_asignar 2,'10|30,20|34,30|45','algo','admin',1,2
CREATE PROCEDURE [dbo].[curso_estudiante_asignar]
    @id_estudiante     INT,
    @lista_cursos      VARCHAR(MAX),    -- IDCURSO|CLASES EJ: 1|12,2|10,3|8
    @comentario        VARCHAR(100) = NULL,
    @usuario_creacion  VARCHAR(15),
    @estado_curso      TINYINT,
    @resultado_curso   TINYINT
AS
BEGIN
    BEGIN TRAN
    BEGIN TRY
        DECLARE @consecutivo_usuario BIGINT = 0;
        DECLARE @POSICION          SMALLINT;
        DECLARE @par               NVARCHAR(100);

        CREATE TABLE #CURSOS
        (
            ID_CURSO       SMALLINT,
            CLASES_CURSO   SMALLINT,
            VALOR_CURSO_REGISTRO DECIMAL(10, 2)
        );
        CREATE NONCLUSTERED INDEX #IX_CURSOS ON #CURSOS (ID_CURSO);

        WHILE CHARINDEX(',', @lista_cursos) > 0
        BEGIN
            SET @POSICION = CHARINDEX(',', @lista_cursos, 1);
            SET @par      = LEFT(@lista_cursos, @POSICION - 1);

            INSERT INTO #CURSOS (ID_CURSO, CLASES_CURSO, VALOR_CURSO_REGISTRO)
            SELECT 
                CONVERT(SMALLINT, PARSENAME(REPLACE(@par, '|', '.'), 3)),
                CONVERT(SMALLINT, PARSENAME(REPLACE(@par, '|', '.'), 2)),
                CONVERT(DECIMAL(10,2), PARSENAME(REPLACE(@par, '|', '.'), 1));

            SET @lista_cursos = SUBSTRING(@lista_cursos, @POSICION + 1, LEN(@lista_cursos));
        END

        IF LEN(@lista_cursos) > 0
        BEGIN
            INSERT INTO #CURSOS (ID_CURSO, CLASES_CURSO, VALOR_CURSO_REGISTRO)
            SELECT 
                CONVERT(SMALLINT, PARSENAME(REPLACE(@lista_cursos, '|', '.'), 3)),
                CONVERT(SMALLINT, PARSENAME(REPLACE(@lista_cursos, '|', '.'), 2)),
                CONVERT(DECIMAL(10,2), PARSENAME(REPLACE(@lista_cursos, '|', '.'), 1));
        END

        -- Inserta en tabla cursos_estudiante, ahora incluyendo estado_curso, resultado_curso y valor_curso_estudiante_registro
        INSERT INTO cursos_estudiante
            (ID_CURSO, ID_ESTUDIANTE, clases_restantes, estado_curso, resultado_curso, valor_curso_estudiante_registro, FECHA_CREACION)
        SELECT
            ID_CURSO,
            @id_estudiante,
            CLASES_CURSO,
            @estado_curso,
            @resultado_curso,
            VALOR_CURSO_REGISTRO,
            GETDATE()
        FROM #CURSOS;

        DROP TABLE #CURSOS;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState    INT;

        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState    = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;

    IF @@TRANCOUNT > 0
        COMMIT TRANSACTION;
END
GO
