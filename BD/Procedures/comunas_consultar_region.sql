 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure comunas_consultar_region 
@id_region tinyint
as

begin

select  c.id, c.comuna
from  comunas c
join provincias p on p.id = c.provincia_id
join regiones r on r.id= p.region_id
where r.id=@id_region
end