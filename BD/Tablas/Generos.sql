 
create table generos(
id tinyint not null,
genero varchar(20) not null
)

go

insert into generos(id, genero) values(1,'Masculino')
insert into generos(id, genero) values(2,'Femenino')
insert into generos(id, genero) values(3,'Otro')
insert into generos(id, genero) values(4,'Prefiero no decir')