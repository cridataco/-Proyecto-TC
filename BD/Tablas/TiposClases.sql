 
--drop table tipos_clase
create table tipos_clase(
id_tipo_clase smallint,
tipo_clase varchar(20),
estado bit,
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)

insert into tipos_clase values(1,'Teórica',1,'admin', getdate(),'admin',getdate())
insert into tipos_clase values (2,'Práctica',1,'admin', getdate(),'admin',getdate())
insert into tipos_clase values (3,'Teórica Extra',1,'admin', getdate(),'admin',getdate())
insert into tipos_clase values (4,'Práctica Extra',1,'admin', getdate(),'admin',getdate())
insert into tipos_clase values (5,'Teórica Evaluación',1,'admin', getdate(),'admin',getdate())