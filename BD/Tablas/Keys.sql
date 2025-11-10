 
create table app_keys(
id smallint identity(1,1) not null,
nombre varchar(100),
valor varchar(max)
)

GO

insert into app_keys(nombre,valor)
values('MercadoPagoAccessToken','5546B38D12891265006BFC70056BF06AFC6A0372016BF365F96AFC6CFE66EA71FB63FB6CFC98219AFA66019D2F662471FD67009D309B209A03643169336DED65FA67FD6C026AF66EFE659683')
insert into app_keys(nombre,valor)
values('MercadoPublicKey','???')
insert into app_keys(nombre,valor)
values('JWTIssuer','http://localhost:7200')
insert into app_keys(nombre,valor)
values('JWTAudience','http://localhost:7200')
insert into app_keys(nombre,valor)
values('JWTKey','BECEF3695CEE5947BE3474EC6CF560F64E')
insert into app_keys(nombre,valor)
values('JWTSubject','ecpWebApiSubject')
insert into app_keys(nombre,valor)
values('MercadoPagoPreferenceCurrency','ARG')
insert into app_keys(nombre,valor)
values('MercadoPagoBackUrlSuccess','http://localhost:8080/sucess')
-- aqui