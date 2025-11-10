 
--drop table cursos_estudiante
create table cursos_estudiante(
consecutivo bigint identity(1,1) not null,
id_curso tinyint not null,
id_estudiante int not null,
clases_restantes tinyint,
estado_curso tinyint,
resultado_curso tinyint,
valor_curso_estudiante_registro decimal(10,2), --guarda el valor del curso al momento de la inscripción
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)

