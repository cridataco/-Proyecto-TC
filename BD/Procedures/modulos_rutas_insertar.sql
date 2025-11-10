 
CREATE PROCEDURE modulos_rutas_insertar
    @id_modulo SMALLINT,
    @sub_ruta VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO modulos_rutas (id_modulo, sub_ruta)
    VALUES (@id_modulo, @sub_ruta);
END;