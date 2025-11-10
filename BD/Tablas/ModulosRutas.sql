 
--drop table modulos_rutas
create table modulos_rutas(
consecutivo_modulo_ruta bigint identity(1,1) not null,
id_modulo smallint,
sub_ruta varchar(30) 
)

insert into modulos_rutas values(1,'/')
insert into modulos_rutas values(1,'/detalles')
insert into modulos_rutas values(1,'/editar')
insert into modulos_rutas values(1,'/nuevo')

insert into modulos_rutas values(2,'/')
insert into modulos_rutas values(2,'/clases/asignar')
insert into modulos_rutas values(2,'/clases/consultar')
insert into modulos_rutas values(2,'/disponibilidad')
insert into modulos_rutas values(2,'/reasignar')

insert into modulos_rutas values(3,'/')
insert into modulos_rutas values(3,'/contrato')
insert into modulos_rutas values(3,'/cursos')
insert into modulos_rutas values(3,'/pagos')