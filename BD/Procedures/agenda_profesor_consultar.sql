 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--drop procedure agenda_profesor_consultar  '2024-03-05 00:00:00.000','2024-03-07 23:59:59.999',null,2
create procedure agenda_profesor_consultar   --consulta desde el lado administrativo 
@fecha_ini datetime,
@fecha_fin datetime,
@id_profesor int= null,
@id_estudiante int= null,
@origen smallint = null --origen de la consulta 1- administrativo 2- estudiante
as

begin
 if @id_estudiante is null  -- consulta por profesores si viene null el parametro muestra todos los registros de todos los profesores
							--para el rango de fecha específico
	begin 
		print 'entra condicion 1'
		select agpa.consecutivo as consecutivo_asignacion, 
		agpd.consecutivo as consecutivo_asignacion_detalle, 
		agpa.id_profesor,
		isnull(p.nombre+' ' + p.apellido,'') as profesor,
		--p.nombre as nombre_profesor, p.apellido as apellido_profesor,
		agpd.fecha_hora_inicio_clase,
		agpd.fecha_hora_fin_clase,
		isnull(cl.consecutivo,0 )as consecutivo_clase,
		case when cl.consecutivo<>0 then CONVERT(bit,1) else CONVERT(bit,0) end as  clase_asignada,
		agpa.id_tipo_clase,
		tc.tipo_clase ,
		isnull(cl.id_estado_clase,0) as id_estado_clase ,
		isnull(ec.estado_clase,'') as estado_clase,
		isnull(ce.id_estudiante, 0) as id_estudiante,
		id_estudiante,
		isnull(est.nombre+' ' + est.apellido,'') as estudiante,
		isnull(cl.comentario,'') as comentario
		from agenda_profesor_asginacion agpa 
		inner join agenda_profesor_detalle agpd on agpd.consecutivo_agenda_profesor_asginacion= agpa.consecutivo
		inner join usuarios p on p.consecutivo = agpa.id_profesor
		inner join tipos_clase tc on tc.id_tipo_clase= agpa.id_tipo_clase
		left join clases cl  on agpd.consecutivo= cl.id_agenda
		left join cursos_estudiante ce on ce.consecutivo= cl.consecutivo_curso_estudiante
		left join usuarios est on est.consecutivo = ce.id_estudiante
		left join estados_clase ec on ec.id_estado_clase= cl.id_estado_clase
		where agpa.id_profesor= isnull(@id_profesor, agpa.id_profesor)
		and (agpd.fecha_hora_inicio_clase between @fecha_ini and @fecha_fin)  or (agpd.fecha_hora_fin_clase  between @fecha_ini and  @fecha_fin)
	end
	

	if @id_estudiante is not null  --consulta los registros teniendo en cuenta el id_estudiante (left join usuarios --> join usuarios)
	begin
	print 'entra condicion 2'
		select agpa.consecutivo as consecutivo_asignacion, 
		agpd.consecutivo as consecutivo_asignacion_detalle, 
		agpa.id_profesor,
		isnull(p.nombre+' ' + p.apellido,'') as profesor,
		--p.nombre as nombre_profesor, p.apellido as apellido_profesor,
		agpd.fecha_hora_inicio_clase,
		agpd.fecha_hora_fin_clase,
		isnull(cl.consecutivo,0 )as consecutivo_clase,
		case when cl.consecutivo<>0 then CONVERT(bit,1) else CONVERT(bit,0) end as  clase_asignada,
		agpa.id_tipo_clase,
		tc.tipo_clase ,
		isnull(cl.id_estado_clase,0) as id_estado_clase ,
		isnull(ec.estado_clase,'') as estado_clase,
		isnull(ce.id_estudiante, 0) as id_estudiante,
		id_estudiante,
		isnull(est.nombre+' ' + est.apellido,'') as estudiante,
		isnull(cl.comentario,'') as comentario
		from agenda_profesor_asginacion agpa 
		inner join agenda_profesor_detalle agpd on agpd.consecutivo_agenda_profesor_asginacion= agpa.consecutivo
		inner join usuarios p on p.consecutivo = agpa.id_profesor
		inner join tipos_clase tc on tc.id_tipo_clase= agpa.id_tipo_clase
		left join clases cl  on agpd.consecutivo= cl.id_agenda
		left join cursos_estudiante ce on ce.consecutivo= cl.consecutivo_curso_estudiante
	    join usuarios est on est.consecutivo = ce.id_estudiante
		left join estados_clase ec on ec.id_estado_clase= cl.id_estado_clase
		where ce.id_estudiante= isnull(@id_estudiante, ce.id_estudiante)
		and (agpd.fecha_hora_inicio_clase between @fecha_ini and @fecha_fin)  or (agpd.fecha_hora_fin_clase  between @fecha_ini and  @fecha_fin)
	end

end

