 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Procedimiento almacenado que consulta las clases asignadas por el estudiante
create procedure clases_estudiante

 @id_estudiante int

 as
 begin
 
		select cl.consecutivo as id_clase,
		cl.id_agenda, 
		ce.consecutivo as consecutivo_curso_estudiante,
		ec.estado_clase,
		agdet.fecha_hora_inicio_clase, agdet.fecha_hora_fin_clase,
		isnull(p.nombre+' ' + p.apellido,'') as profesor
		from clases cl 
		inner join cursos_estudiante ce on ce.consecutivo= cl.consecutivo_curso_estudiante
		inner join estados_clase ec on ec.id_estado_clase = cl.id_estado_clase
		inner join agenda_profesor_detalle  agdet on agdet.consecutivo = cl.id_agenda
		inner join agenda_profesor_asginacion agpa on agpa.consecutivo = agdet.consecutivo_agenda_profesor_asginacion
		inner join usuarios p on p.consecutivo = agpa.id_profesor
		where ce.id_estudiante=@id_estudiante order by agdet.fecha_hora_inicio_clase, agdet.fecha_hora_fin_clase

end

