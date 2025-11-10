 
CREATE TABLE pagos_y_abonos(
  consecutivo  bigint identity(1,1) not null,
  id_curso_estudiante bigint not null,
  valor decimal(20,2),
  fecha_creacion DATE,
  usuario_creacion varchar(15),
  fecha_modificacion DATE,
  usuario_modificacion varchar(15)
)