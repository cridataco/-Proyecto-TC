 
CREATE PROCEDURE modulos_rutas_consultar
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT consecutivo_modulo_ruta, id_modulo, sub_ruta
    FROM modulos_rutas;
END;