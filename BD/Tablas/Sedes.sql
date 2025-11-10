 
create table sedes(
consecutivo TINYINT IDENTITY(1,1) NOT NULL,
nombre_sede varchar(100),
id_comuna smallint NOT NULL,
direccion varchar(100)
)

insert into sedes(nombre_sede,id_comuna, direccion)
values('Sucursal metro protectora de la infancia',118,'Avenida Concha y Toro #2498. Puente Alto')
insert into sedes(nombre_sede,id_comuna, direccion)
values('Sucursal metro plaza de Pte. Alto',118,'Avenida José Manuel Irarrázaval 0147. Puente Alto')
