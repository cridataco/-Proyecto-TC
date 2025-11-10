 
--drop table cursos
create table cursos(
consecutivo bigint identity(1,1) not null,
nombre varchar(50),
descripcion varchar(200),
cantidad_clases tinyint,
valor decimal(28,0),
estado bit default(1),
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)

INSERT INTO cursos (nombre,descripcion,cantidad_clases,valor,estado,usuario_creacion,fecha_creacion)VALUES ('Curso Teórico','Curso de preparación teórica para conducción.',1,60000,1,'admin',GETDATE());
INSERT INTO cursos (nombre,descripcion,cantidad_clases,valor,estado,usuario_creacion,fecha_creacion)VALUES ('Curso Práctico','Curso de preparación práctica con vehículo.',12,300000,1,'admin',GETDATE());
INSERT INTO cursos (nombre,descripcion,cantidad_clases,valor,estado,usuario_creacion,fecha_creacion)VALUES ('Clases Extras','Clase adicional para refuerzo práctico o teórico.',1,25000,1,'admin',GETDATE());

--consecutivo	nombre	descripcion	estado	usuario_creacion	fecha_creacion	usuario_modificacion	fecha_modificacion
--1	curso conduccion tipo C	curso conduccion tipo C	1	admin	2024-01-01 00:00:00.000	admin	NULL