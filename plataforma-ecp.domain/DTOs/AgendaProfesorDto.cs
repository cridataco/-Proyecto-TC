namespace plataforma_ecp.domain.DTOs
{
    public class AgendaAsignacionClases
    {
        public long consecutivo_asignacion { get; set; }
        public long consecutivo_asignacion_detalle { get; set; }
        public int id_profesor { get; set; }
        public string profesor { get; set; }
        public DateTime fecha_hora_inicio_clase { get; set; }
        public DateTime fecha_hora_fin_clase { get; set; }
        public long consecutivo_clase { get; set; }
        public bool clase_asignada { get; set; }
        public int id_tipo_clase { get; set; }
        public string tipo_clase { get; set; }
        public int id_estado_clase { get; set; }
        public string estado_clase { get; set; }
        public int id_estudiante { get; set; }
        public string estudiante { get; set; }
        public string comentario { get; set; }
 
    }
    public class AddAsignacionProfesorDto
    {
        public int id_profesor { get; set; }
        public int id_tipo_clase { get; set; }
        public List<disponibilidadhoraria> disponibilidad { get; set; }
        //public DateTime fecha_hora_inicio_clase { get; set; }
        //public DateTime fecha_hora_fin_clase { get; set; }
        public string usuario_creacion { get; set; }
    }
    public class disponibilidadhoraria
    {
        public DateTime fechaInicial { get; set; }
        public DateTime fechaFinal { get; set; }
    }

    public class ListAsignacionActivaDto
    {
        public long id_asignacion { get; set; }
        public int id_profesor { get; set; }
        public string nombre_profesor { get; set; }
        public string apellido_profesor { get; set; }
    }

    public class ParametrosAgendaDto
    {
        public DateTime fecha_ini { get; set; }
        public DateTime fecha_fin { get; set; }
        public int id_profesor { get; set; }
        public int id_estudiante{ get; set; } 
    }
}
