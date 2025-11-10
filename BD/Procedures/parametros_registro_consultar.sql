 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure parametros_registro_consultar

as

begin

select consecutivo, nombre_sede, direccion
from sedes

select id,genero
from generos

select id,medio
from medios

end