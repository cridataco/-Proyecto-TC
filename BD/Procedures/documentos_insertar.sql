 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure documentos_insertar
CREATE PROCEDURE documentos_insertar
    @codigo VARCHAR(3),
    @nombre_documento VARCHAR(100),
    @base64_doc VARBINARY(MAX),
    @usuario_creacion VARCHAR(15)
AS
BEGIN
    -- Comienza una transacción
    BEGIN TRANSACTION;

    -- Verifica si ya existe un registro con el código dado
    IF EXISTS (SELECT 1 FROM [dbo].[documentos] WHERE [codigo] = @codigo)
    BEGIN
        -- Si existe, realiza una actualización
        UPDATE [dbo].[documentos]
        SET 
            [nombre_documento] = @nombre_documento,
            [base64_doc] = @base64_doc,
            [usuario_modificacion] = @usuario_creacion,
            [fecha_modificacion] = GETDATE()
        WHERE 
            [codigo] = @codigo;
    END
    ELSE
    BEGIN
        -- Si no existe, realiza una inserción
        INSERT INTO [dbo].[documentos] (
            [codigo],
            [nombre_documento],
            [base64_doc],
            [usuario_creacion],
            [fecha_creacion],
            [usuario_modificacion],
            [fecha_modificacion]
        )
        VALUES (
            @codigo,
            @nombre_documento,
            @base64_doc,
            @usuario_creacion,
            GETDATE(),
            @usuario_creacion,
            GETDATE()
        );
    END

    -- Finaliza la transacción si todo es exitoso
    COMMIT TRANSACTION;
END
 

