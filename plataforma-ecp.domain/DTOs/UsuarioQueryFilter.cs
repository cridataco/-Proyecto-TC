using plataforma_ecp.domain.CustomEntities;

namespace plataforma_ecp.domain.DTOs
{
    public class UsuarioQueryFilter : PaginationOptions
    {
        public int idRol { get; set; }
        public string? text { get; set; } 
    }
}
