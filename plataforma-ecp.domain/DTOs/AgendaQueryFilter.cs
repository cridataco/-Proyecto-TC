namespace plataforma_ecp.domain.DTOs
{
    public class AgendaQueryFilter
    {
        public int IdProfesor { get; set; }
        public int IdEstudiante { get; set; }
        public string? Horario { get; set; }
        public byte ClaseDisponible { get; set; }
        public DateTime? FechaIni { get; set; }  
        public DateTime? FechaFin { get; set; }
    }
}