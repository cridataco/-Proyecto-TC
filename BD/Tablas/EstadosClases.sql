 
--drop table estados_clase
create table estados_clase(
id_estado_clase smallint,
estado_clase varchar(20),
estado bit,
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)

insert into estados_clase values(1,'Programada',1,'admin', getdate(),'admin',getdate())
insert into estados_clase values (2,'Cancelada',1,'admin', getdate(),'admin',getdate())
insert into estados_clase values (3,'Reprogramada',1,'admin', getdate(),'admin',getdate()) 
insert into estados_clase values (4,'Finalizada',1,'admin', getdate(),'admin',getdate()) 