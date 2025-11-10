 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Consulta el listado de disponibilidades para ser asignadas con una fecha como parametro de entrada
--drop procedure agenda_consultar_disponibilidad_xfecha  '2024-06-18 00:00:00.000' 
create procedure agenda_consultar_disponibilidad_xfecha   --consulta desde el lado administrativo 
@fecha datetime
as
begin
	select  
		agpd.consecutivo  as id_disponibilidad, 
		isnull(p.nombre+' ' + p.apellido,'') as profesor,
		--p.nombre as nombre_profesor, p.apellido as apellido_profesor,
		agpd.fecha_hora_inicio_clase,
		agpd.fecha_hora_fin_clase,
		CAST(agpd.fecha_hora_inicio_clase AS DATE) AS dias
		from agenda_profesor_asginacion agpa 
		inner join agenda_profesor_detalle agpd on agpd.consecutivo_agenda_profesor_asginacion= agpa.consecutivo
		inner join usuarios p on p.consecutivo = agpa.id_profesor
		inner join tipos_clase tc on tc.id_tipo_clase= agpa.id_tipo_clase
		left join clases cl  on agpd.consecutivo= cl.id_agenda
		left join cursos_estudiante ce on ce.consecutivo= cl.consecutivo_curso_estudiante
	    left join usuarios est on est.consecutivo = ce.id_estudiante
		left join estados_clase ec on ec.id_estado_clase= cl.id_estado_clase
		where cl.consecutivo IS NULL and CAST(agpd.fecha_hora_inicio_clase AS DATE) = CAST(@fecha AS DATE)
		order by agpd.fecha_hora_inicio_clase

end