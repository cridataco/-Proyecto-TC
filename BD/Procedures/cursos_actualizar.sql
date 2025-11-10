 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure cursos_actualizar
CREATE PROCEDURE cursos_actualizar
    @consecutivo smallint,
    @nombre varchar(50),
    @descripcion varchar(200),
    @valor decimal(28,0),
    @cantidad_clases tinyint,
    @estado bit,
    @usuario_creacion varchar(15)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[cursos]
    SET 
        [nombre] = @nombre,
        [descripcion] = @descripcion,
        [cantidad_clases] = @cantidad_clases,  
        [valor] = @valor,
        [estado] = @estado,
        [usuario_modificacion] = @usuario_creacion,
        [fecha_modificacion] = GETDATE()
    WHERE consecutivo = @consecutivo;
END
GO

