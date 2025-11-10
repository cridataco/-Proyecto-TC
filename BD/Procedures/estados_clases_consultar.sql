 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure estados_clases_consultar

as

begin

select  id_estado_clase, estado_clase
from estados_clase where estado=1

end