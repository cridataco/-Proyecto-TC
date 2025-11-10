 
--drop table resultado_curso
create table resultado_curso(
consecutivo bigint identity(1,1) not null,
nombre varchar(50),
estado bit default(1),
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)


insert into resultado_curso(nombre,estado,usuario_creacion,fecha_creacion,usuario_modificacion,fecha_modificacion) values('Aprobado',1,'admin',GETDATE(),'admin',GETDATE())
insert into resultado_curso(nombre,estado,usuario_creacion,fecha_creacion,usuario_modificacion,fecha_modificacion) values('Reprobado',1,'admin',GETDATE(),'admin',GETDATE())
