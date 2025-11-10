 
--drop procedure pagos_y_abonos_insertar
CREATE PROCEDURE pagos_y_abonos_insertar
    @pagos_abonos NVARCHAR(MAX), -- Ejemplo: '1|100.00,2|200.00'
    @usuario_creacion VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    -- Crear tabla temporal
    CREATE TABLE #PagosAbonosTemp (
        id_curso_estudiante BIGINT,
        valor DECIMAL(20,2)
    );

    -- Separar los pares id_curso_estudiante|valor
    DECLARE @pos INT = 1, @item NVARCHAR(100), @sep CHAR(1) = ',';
    WHILE LEN(@pagos_abonos) > 0
    BEGIN
        SET @pos = CHARINDEX(@sep, @pagos_abonos);
        IF @pos > 0
            SET @item = LEFT(@pagos_abonos, @pos - 1);
        ELSE
            SET @item = @pagos_abonos;

        -- Separar id y valor
        DECLARE @id_valor NVARCHAR(100), @id BIGINT, @valor DECIMAL(20,2);
        SET @id_valor = @item;
        SET @id = CAST(LEFT(@id_valor, CHARINDEX('|', @id_valor) - 1) AS BIGINT);
        SET @valor = CAST(SUBSTRING(@id_valor, CHARINDEX('|', @id_valor) + 1, LEN(@id_valor)) AS DECIMAL(20,2));

        INSERT INTO #PagosAbonosTemp (id_curso_estudiante, valor)
        VALUES (@id, @valor);

        IF @pos > 0
            SET @pagos_abonos = SUBSTRING(@pagos_abonos, @pos + 1, LEN(@pagos_abonos));
        ELSE
            BREAK;
    END

    -- Insertar los valores de la tabla temporal
    INSERT INTO pagos_y_abonos (
        id_curso_estudiante,
        valor,
        fecha_creacion,
        usuario_creacion,
        fecha_modificacion,
        usuario_modificacion
    )
    SELECT
        id_curso_estudiante,
        valor,
        GETDATE(),
        @usuario_creacion,
        GETDATE(),
        @usuario_creacion
    FROM #PagosAbonosTemp;

    DROP TABLE #PagosAbonosTemp;
END