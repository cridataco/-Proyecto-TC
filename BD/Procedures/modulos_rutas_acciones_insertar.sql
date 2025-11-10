 
CREATE PROCEDURE modulos_rutas_acciones_insertar
    @id_modulo_ruta SMALLINT,
    @accion VARCHAR(50),
    @codigo VARCHAR(5),
    @estado BIT,
    @usuario_creacion VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, 
                                        usuario_creacion, fecha_creacion)
    VALUES (@id_modulo_ruta, @accion, @codigo, @estado, 
            @usuario_creacion, GETDATE());
END;