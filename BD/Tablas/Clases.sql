-- use [1marchadev];
-- go
--drop table clases
create table clases(
consecutivo bigint identity(1,1) not null,
id_agenda int not null,
id_estado_clase tinyint not null,
--id_tipo_clase int not null,
consecutivo_curso_estudiante int not null,
comentario varchar(100),
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)





