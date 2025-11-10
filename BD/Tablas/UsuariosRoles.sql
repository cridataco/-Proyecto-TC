 
--drop table usuarios_roles
create table usuarios_roles(
id_usuario int NOT NULL, id_rol smallint NOT NULL, estado bit default 1)

GO 

INSERT INTO usuarios_roles (
    id_usuario,
    id_rol,
    estado
)
VALUES (
    1, 
    1,  
    1  
);