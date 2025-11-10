



declare @idUsuario int;

insert into usuarios 
values('primeramarchaadmin','primeramarchaadmin','0000000000',1
,'1993-08-26 22:29:00.280','000000','correo@admin.com','calle 123','detalle'
,1,'admin',1
,null,null,null,'n/a',null,
'abc123',0,0,'admin',getdate(),null,getdate())
set @idUsuario= SCOPE_IDENTITY() 

insert into usuarios_roles values(@idUsuario,1,1)