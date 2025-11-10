using plataforma_ecp.domain.Entities;
using plataforma_ecp.domain.Enumerations;

namespace plataforma_ecp.domain.DTOs
{
    public class LoginDto
    {
        public string run { get; set; }
        public string password { get; set; }
    }
    public class LoginUsuarioDto
    {
        public long consecutivo { get; set; }
        public string nombre { get; set; }
        public string apellido { get; set; }
        public List<Rol> roles { get; set; }
        public string arbol_permisos { get; set; } = string.Empty;

    }
}
