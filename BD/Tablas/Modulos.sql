 
--drop table modulos
create table modulos(
consecutivo_modulo smallint identity(1,1) not null,
nombre varchar(30) not null,
estado bit
)

insert into modulos values('usuarios',1)
insert into modulos values('calendario',1)
insert into modulos values('parametrizacion',1)