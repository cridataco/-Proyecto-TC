--drop table modulos_rutas_acciones
create table modulos_rutas_acciones(
consecutivo_modulo_ruta_accion bigint identity(1,1) not null,
id_modulo_ruta smallint,
accion varchar(50),
codigo varchar(10),
estado bit,
usuario_creacion varchar(15)  null,
fecha_creacion datetime  null,
usuario_modificacion varchar(15)  null,
fecha_modificacion datetime  null,
)

-- MÓDULO USUARIOS
-- usuarios/ (id_modulo_ruta = 1) - todos los roles menos estudiante
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 'crear_usuario', 'CUS', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 'ver', 'VUS', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 'editar', 'EDUS', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 'asignar_clase', 'ASCLA', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 'asignar_disponibilidad', 'ASDSP', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 'eliminar_usuario', 'EUS', 1, NULL, NULL, NULL, NULL);

-- usuarios/detalles (id_modulo_ruta = 2)
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- usuarios/editar (id_modulo_ruta = 3)
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- usuarios/nuevo (id_modulo_ruta = 4)
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (4, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- MÓDULO CALENDARIO
-- calendario/ (id_modulo_ruta = 5) - administrativos, recepción
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 'crear_clase', 'CCLA', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 'reasignar_clase', 'RCLA', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 'cancelar_clase', 'CANCLA', 1, NULL, NULL, NULL, NULL);
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 'modificar_clase', 'MCLA', 1, NULL, NULL, NULL, NULL);

-- calendario/clases/asignar (id_modulo_ruta = 6) - solo estudiante
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (6, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- calendario/clases/consultar (id_modulo_ruta = 7)
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (7, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- calendario/disponibilidad (id_modulo_ruta = 8) - administrativos, recepción
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (8, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- calendario/reasignar (id_modulo_ruta = 9) - estudiante
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (9, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- MÓDULO PARAMETRIZACIÓN
-- parametrizacion/ (id_modulo_ruta = 10)
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (10, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- parametrizacion/contrato (id_modulo_ruta = 11)
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (11, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- parametrizacion/cursos (id_modulo_ruta = accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (12, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- parametrizacion/pagos (id_modulo_ruta = 13)
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (13, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);

-- Agregar la acción faltante para parametrizacion/cursos
INSERT INTO modulos_rutas_acciones (id_modulo_ruta, accion, codigo, estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (12, 'acceso', 'ACC', 1, NULL, NULL, NULL, NULL);