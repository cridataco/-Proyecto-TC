 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure documentos_consultar_codigo
create procedure documentos_consultar_codigo
@codigo varchar(3)

as
 
begin

SELECT nombre_documento, base64_doc  FROM documentos WHERE codigo= @codigo
      


 

end

 

