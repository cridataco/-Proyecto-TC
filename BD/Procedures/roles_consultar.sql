 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure roles_consultar

as

begin

select  consecutivo, nombre
from roles

end