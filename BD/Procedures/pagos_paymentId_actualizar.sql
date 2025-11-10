 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure pagos_paymentId_actualizar
@run varchar(15),
@preferenceId varchar(200),
@paymentId varchar(200)
as

begin

update pagos set paymentId=@paymentId, fecha_modificacion= GETDATE()
where run= @run and preferenceId=@preferenceId



end

--drop procedure pagos_preferenceId_insertar