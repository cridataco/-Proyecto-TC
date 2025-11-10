namespace plataforma_ecp.domain.Entities
{
    public class Auditoria
    {
        
        public string? usuario_creacion { get; set; }
        public DateTime? fecha_creacion { get; set; }
        public string? usuario_modificacion { get; set; }
        public DateTime? fecha_modificacion { get; set; }
    }
}
