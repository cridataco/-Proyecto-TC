 
--truncate table roles
--drop table roles
create table roles(
consecutivo TINYINT IDENTITY(1,1) NOT NULL,
nombre varchar(100) NOT NULL,
codigo varchar(3) not null,
estado bit default 1
)
insert into roles(nombre,codigo) values('Super Usuario','SU')
insert into roles(nombre,codigo) values('Administrativo','ADM')
insert into roles(nombre,codigo) values('Secretaria','SEC')
insert into roles(nombre,codigo) values('Profesor Teórico Práctico','PRF')
insert into roles(nombre,codigo) values('Alumno','ALN')