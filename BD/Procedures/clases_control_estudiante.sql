 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure clases_control_estudiante 1
create procedure clases_control_estudiante
@id_curso_estudiante int
as

begin
	create table #tmp_control_clases(
	cantidad_clases_curso tinyint,
	clases_registradas tinyint,
	clases_disponibles_registro tinyint,
	clases_aprobadas tinyint

	)
	-- cantidad de clases y clases registradas
	insert into #tmp_control_clases(cantidad_clases_curso, clases_registradas)
	select cantidad_clases, count(cl.consecutivo_curso_estudiante) as clases_registradas
	from cursos_estudiante ce
	inner join clases cl on cl.consecutivo_curso_estudiante = ce.consecutivo
	where  ce.consecutivo= @id_curso_estudiante
	group by cantidad_clases

	--clases disponible para registrar

	update #tmp_control_clases set clases_disponibles_registro= cantidad_clases_curso - clases_registradas

	-- clases aprobadas
	update #tmp_control_clases set clases_aprobadas =(
	select count(1)
	from clases cl
	where cl.consecutivo_curso_estudiante = @id_curso_estudiante and cl.id_estado_clase=4)
 
 
	 select cantidad_clases_curso,clases_registradas,clases_disponibles_registro,clases_aprobadas from #tmp_control_clases
end