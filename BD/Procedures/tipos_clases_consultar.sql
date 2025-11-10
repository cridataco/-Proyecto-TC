 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure tipos_clases_consultar

as

begin

select  id_tipo_clase, tipo_clase
from tipos_clase where estado=1

end