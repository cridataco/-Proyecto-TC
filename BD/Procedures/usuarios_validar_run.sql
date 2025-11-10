 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure usuarios_validar_run
@run varchar(15)
as

begin

select pago_aprobado
from usuarios where run= @run

end