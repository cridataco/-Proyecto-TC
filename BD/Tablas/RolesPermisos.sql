--drop table roles_permisos
create table roles_permisos(
id_rol smallint not null,
id_modulo_ruta_accion bigint,
activo bit,
usuario_creacion varchar(50),
fecha_creacion DATETIME,
usuario_modificacion varchar(50),
fecha_modificacion DATETIME
)

-- SUPER USUARIO (ID: 1) - Todos los permisos
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 1, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 2, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 3, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 4, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 5, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 6, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 7, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 8, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 9, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 10, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 11, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 12, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 13, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 14, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 15, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 16, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 17, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 18, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 19, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 20, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 21, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 22, 1, 'admin', GETDATE(), 'admin', GETDATE());

-- ADMINISTRATIVO (ID: 2) - Acceso completo a gestión de usuarios, calendario y parametrización
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 1, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 2, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 3, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 4, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 5, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 6, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 7, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 8, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 9, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 10, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 11, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 12, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 13, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 14, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 15, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 16, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 17, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 18, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 19, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 20, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 21, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 22, 1, 'admin', GETDATE(), 'admin', GETDATE());

-- SECRETARIA (ID: 3) - Gestión limitada de usuarios, calendario y acceso a parametrización
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 1, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 2, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ crear_usuario
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 3, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ ver
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 4, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ editar
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 5, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ asignar_clase
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 6, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ asignar_disponibilidad
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 8, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/detalles acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 9, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/editar acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 10, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- usuarios/nuevo acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 11, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/ acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 12, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/ crear_clase
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 13, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/ reasignar_clase
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 14, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/ cancelar_clase
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 15, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/ modificar_clase
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 16, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/clases/asignar acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 20, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- parametrizacion/ acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 21, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- parametrizacion/contrato acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (3, 22, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- parametrizacion/pagos acceso

-- PROFESOR TEÓRICO PRÁCTICO (ID: 4) - Solo consulta de datos de alumnos y calendario
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (4, 1, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (4, 3, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ ver
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (4, 8, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/detalles acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (4, 11, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/ acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (4, 16, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/clases/asignar acceso

-- ALUMNO (ID: 5) - Solo sus propios datos y asignación de clases
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 1, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 3, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/ ver
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 8, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/detalles acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 9, 1, 'admin', GETDATE(), 'admin', GETDATE());  -- usuarios/editar acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 16, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/clases/asignar acceso
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (5, 17, 1, 'admin', GETDATE(), 'admin', GETDATE()); -- calendario/clases/consultar acceso

-- Para que el administrador pueda acceder a cursos (será el ID 23)
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (1, 23, 1, 'admin', GETDATE(), 'admin', GETDATE());
INSERT INTO roles_permisos (id_rol, id_modulo_ruta_accion, activo, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) VALUES (2, 23, 1, 'admin', GETDATE(), 'admin', GETDATE());