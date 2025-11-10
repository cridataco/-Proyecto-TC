 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop procedure cursos_consultar
create procedure cursos_consultar

as

begin

	select  consecutivo ,
			nombre ,
			descripcion ,
			cantidad_clases,
			valor ,
			estado
	from cursos

end