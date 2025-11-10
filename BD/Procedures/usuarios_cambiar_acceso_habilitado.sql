 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- DROP PROCEDURE IF EXISTS [dbo].[usuarios_cambiar_acceso_habilitado];
CREATE PROCEDURE [dbo].[usuarios_cambiar_acceso_habilitado]
    @consecutivo BIGINT,
    @acceso_habilitado BIT,
    @usuario_modificacion VARCHAR(50),
    @resultado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRAN;
    BEGIN TRY
        UPDATE dbo.usuarios
        SET 
            acceso_habilitado   = @acceso_habilitado,
            usuario_modificacion = @usuario_modificacion,
            fecha_modificacion   = GETDATE()
        WHERE consecutivo = @consecutivo;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No se encontr� usuario con consecutivo %d', 16, 1, @consecutivo);
        END

        SET @resultado = @@ROWCOUNT;
        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        DECLARE 
            @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(),
            @ErrorSeverity INT         = ERROR_SEVERITY(),
            @ErrorState INT            = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
