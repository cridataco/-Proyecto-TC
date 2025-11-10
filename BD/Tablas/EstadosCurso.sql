 
--drop table estados_curso
create table estados_curso(
consecutivo bigint identity(1,1) not null,
nombre varchar(50),
estado bit default(1),
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)


insert into estados_curso(nombre,estado,usuario_creacion,fecha_creacion,usuario_modificacion,fecha_modificacion) values('Activo',1,'admin',GETDATE(),'admin',GETDATE())
insert into estados_curso(nombre,estado,usuario_creacion,fecha_creacion,usuario_modificacion,fecha_modificacion) values('Inactivo',1,'admin',GETDATE(),'admin',GETDATE())
insert into estados_curso(nombre,estado,usuario_creacion,fecha_creacion,usuario_modificacion,fecha_modificacion) values('Suspendido',1,'admin',GETDATE(),'admin',GETDATE())
insert into estados_curso(nombre,estado,usuario_creacion,fecha_creacion,usuario_modificacion,fecha_modificacion) values('Anulado',1,'admin',GETDATE(),'admin',GETDATE())