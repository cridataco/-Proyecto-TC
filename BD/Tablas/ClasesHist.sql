-- use [1marchadev];
-- go
--drop table clases_hist
create table clases_hist(
consecutivo int not null,
id_clase_nuevo int null,  --not null reprogramada , null cancelada
id_agenda int not null,
id_estado_clase tinyint not null,
consecutivo_curso_estudiante int not null,
comentario varchar(100),
usuario_creacion varchar(15),
fecha_creacion datetime
)