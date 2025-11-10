 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure asignacion_clases_consultar_alumnos
-- drop procedure asignacion_clases_consultar_alumnos

as

begin

select distinct ce.consecutivo as id_curso_estudiante, u.run+' - '+ u.nombre + ' '+ u.apellido as estudiante, ce.clases_restantes as cantidad_clases from usuarios u
inner join usuarios_roles ur on ur.id_usuario= u.consecutivo
inner join roles r on r.consecutivo= ur.id_rol
inner join cursos_estudiante ce on ce.id_estudiante= u.consecutivo
where ur.id_rol=5 and u.acceso_habilitado=1 

end