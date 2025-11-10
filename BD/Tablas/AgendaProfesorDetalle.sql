-- use [1marchadev];
-- go
--drop table agenda_profesor_detalle
create table agenda_profesor_detalle(
consecutivo bigint identity(1,1) not null,
consecutivo_agenda_profesor_asginacion bigint,
fecha_hora_inicio_clase datetime,
fecha_hora_fin_clase datetime,
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)