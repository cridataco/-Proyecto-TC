-- use [1marchadev];
-- go
--drop table agenda_profesor_asginacion

create table agenda_profesor_asginacion(
consecutivo bigint identity(1,1) not null,
id_profesor int not null,
id_tipo_clase tinyint not null,
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)