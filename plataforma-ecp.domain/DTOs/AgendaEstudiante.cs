using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.DTOs
{
    public class AgendaEstudianteConsultarDto
    {
        public DateTime fecha_ini { get; set; }
        public DateTime fecha_fin { get; set; }
        public int id_estudiante { get; set; }
    }

    public class AgendaEstudianteClasesAsignadas
    {
        public long id_clase { get; set; }

        public long id_agenda { get; set; }
        public long consecutivo_curso_estudiante { get; set; }
        public string estado_clase { get; set; }
        public DateTime fecha_hora_inicio_clase { get; set; }
        public DateTime fecha_hora_fin_clase { get; set; }
        public string profesor { get; set; }
    }

    public class DiasDisponiblesAsignarClase
    {
        public DateTime dias { get; set; }
    }

    public class DisponibilidadxFechaDto
    {
        public long id_disponibilidad { get; set; }
        public string profesor { get; set; }
        public DateTime fecha_hora_inicio_clase { get; set; }
        public DateTime fecha_hora_fin_clase { get; set; }
    }
}
