use [1marchadev];
go 
--drop table usuarios
select * from usuarios
--delete from usuarios where consecutivo= 5
select * from regiones
select * from comunas
--truncate table usuarios_roles
select * from usuarios_roles
select * from roles
select * from modulos m join modulos_rutas mr on mr.id_modulo= m.consecutivo inner join modulos_rutas_acciones
mra on mra.id_modulo_ruta = mr.consecutivo
--truncate table cursos
select * from modulos
select * from modulos_rutas
select * from modulos_rutas_acciones
select * from roles_permisos
select * from cursos
 select * from cursos_estudiante
 select * from app_keys
select * from agenda_profesor_asginacion order by fecha_creacion desc
--truncate table agenda_profesor_detalle
select * from agenda_profesor_detalle order by fecha_creacion desc
--truncate table clases
--truncate table clases_hist
select * from clases
select * from clases_hist
select * from estados_clase
select * from estados_curso
select * from tipos_clase
insert into usuarios values('Ross','Geller','98765421',1,'1993-08-26 22:29:00.280','6717237','ross@admin.com','calle 123','casa F',12,'Profesor',1,'abc123',0,0,'admin',getdate(),null,null)
insert into usuarios values('eduardo','tarazona','109131231',1,'1993-08-26 22:29:00.280','6717237','correo@admin.com','calle 123','casa F',12,'Estudiante',1,'abc123',0,0,'admin',getdate(),null,null)
insert into usuarios_roles values(6,3,1)
insert into usuarios_roles values(2,1,1)
insert into agenda_profesor values(15,2,'2024-05-01 08:00:00.000','2024-05-01 09:00:00.000','admin',GETDATE(),null,null)
insert into agenda_profesor values(15,2,'2024-05-01 09:00:00.000','2024-05-01 10:00:00.000','admin',GETDATE(),null,null)
insert into agenda_profesor values(15,2,'2024-05-01 00:18:00.000','2024-05-01 00:00:00.000','admin',GETDATE(),null,null)
insert into agenda_profesor values(15,2,'2024-05-01 00:18:00.000','2024-05-01 00:00:00.000','admin',GETDATE(),null,null)
insert into agenda_profesor values(15,'2023-01-2 16:00:00','2023-01-2 18:00:00','admin',GETDATE(),null,null) 
insert into agenda_profesor values(1,'2023-01-2 08:00:00','2023-01-2 10:00:00','admin',GETDATE(),null,null)
insert into agenda_profesor values(1,'2023-01-2 10:00:00','2023-01-2 12:00:00','admin',GETDATE(),null,null)
insert into agenda_profesor values(1,'2023-01-2 14:00:00','2023-01-2 16:00:00','admin',GETDATE(),null,null)
insert into agenda_profesor values(1,'2023-01-2 16:00:00','2023-01-2 18:00:00','admin',GETDATE(),null,null) 
go
--
--select * from agenda_p
--inner join usuarios e on e.consecutivo= h.id_estudiante
--inner join agenda_profesor ag on ag.consecutivo= h.consecutivo_agenda_profesor
--inner join usuarios p on p.consecutivo = ag.id_profesor
--truncate table agenda_profesor
--update agenda_profesor set id_profesor=5 , id_tipo_clase= 2
 --truncate table cursos_estudiante
 update clases set consecutivo_curso_estudiante = 1
 TRUNCATE TABLE CLASES
 delete agenda_profesor_asginacion where consecutivo in(437,438)
 delete agenda_profesor_detalle where consecutivo in(437,438)

 select agd.id_profesor,p.nombre as nombre_profesor, p.apellido as apellido_profesor
from agenda_profesor_asginacion agd 
inner join usuarios p on p.consecutivo = agd.id_profesor
inner join tipos_clase tc on tc.id_tipo_clase= agd.id_tipo_clase
group by ag.id_profesor, p.nombre, p.apellido 

insert into agenda_profesor 
select 5,id_tipo_clase, fecha_hora_inicio_clase, fecha_hora_fin_clase, usuario_creacion,
fecha_creacion, usuario_modificacion, fecha_modificacion
from agenda_profesor


 SELECT  consecutivo  FROM agenda_profesor_asginacion WHERE id_profesor= @id_profesor
	 AND id_tipo_clase= @id_tipo_clase

select * from pagos_y_abonos

select * from app_keys