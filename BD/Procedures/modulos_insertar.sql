 
CREATE PROCEDURE modulos_insertar
    @nombre VARCHAR(30),
    @estado BIT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO modulos (nombre, estado)
    VALUES (@nombre, @estado);
END;