 

CREATE PROCEDURE modulos_rutas_acciones_consultar
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT consecutivo_modulo_ruta_accion, id_modulo_ruta, accion, codigo, estado, 
           usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion
    FROM modulos_rutas_acciones;
END;