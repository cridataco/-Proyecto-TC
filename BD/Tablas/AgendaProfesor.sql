-- use [1marchadev];
-- go
--drop table agenda_profesor
create table agenda_profesor(
consecutivo bigint identity(1,1) not null,
id_profesor int not null,
id_tipo_clase tinyint not null,
fecha_hora_inicio_clase datetime,
fecha_hora_fin_clase datetime,
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)




