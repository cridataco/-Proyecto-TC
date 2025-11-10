 
--drop table documentos
create table documentos(
consecutivo bigint identity(1,1) not null,
codigo varchar(3),
nombre_documento varchar(100),
base64_doc VARBINARY(MAX),
usuario_creacion varchar(15),
fecha_creacion datetime,
usuario_modificacion varchar(15),
fecha_modificacion datetime,
)





