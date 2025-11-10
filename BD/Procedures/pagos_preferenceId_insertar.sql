 
/****** Object:  StoredProcedure [dbo].[usuarios_consultar_datos_usuarios]    Script Date: 17/6/2023 20:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure pagos_preferenceId_insertar
@run varchar(15),
@preferenceId varchar(200)
as

begin

insert into pagos(run,preferenceId ,fecha_creacion)
values (@run, @preferenceId, getdate())

end

--drop procedure pagos_preferenceId_insertar