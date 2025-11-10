 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--drop procedure agenda_profesor_consultar_asignados
create procedure agenda_profesor_consultar_asignados

as

begin

select agd.consecutivo as id_asignacion, agd.id_profesor,p.nombre as nombre_profesor, p.apellido as apellido_profesor
from agenda_profesor_asginacion agd 
inner join usuarios p on p.consecutivo = agd.id_profesor
inner join tipos_clase tc on tc.id_tipo_clase= agd.id_tipo_clase

end