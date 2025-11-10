 
CREATE PROCEDURE modulos_consultar
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT consecutivo_modulo, nombre, estado
    FROM modulos
    WHERE estado = 1;
END;