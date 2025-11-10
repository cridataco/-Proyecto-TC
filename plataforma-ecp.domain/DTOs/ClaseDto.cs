using plataforma_ecp.domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.DTOs
{
    public class AddClaseDTO
    {
        public List<int> listado_disponibilidad { get; set; }
        public int consecutivo_curso_estudiante { get; set; }
        public string usuario_creacion { get; set; }

    }

    public class ReprogramarCancelarClaseDTO
    {
        public int accion { get; set; }
        public int consecutivo_curso_estudiante { get; set; }
        public int id_clase { get; set; }
        public int id_agenda { get; set; }
        public string comentario { get; set; }
        public DateTime fecha_hora_solicitud { get; set; }
        public string usuario_modificacion { get; set; }

    }

    public class GetAgendaClaseDTO
    {
        public long consecutivo_agenda { get; set; }
        public long consecutivo_clase { get; set; }
        public int id_tipo_clase { get; set; }
        public string? tipo_clase { get; set; }
        public int id_estado_clase { get; set; }
        public string? estado_clase { get; set; }
        public int id_estudiante { get; set; }
        public string? estudiante { get; set; }
        public int id_profesor { get; set; }
        public string? profesor { get; set; }
        public DateTime fecha_hora_inicio_clase { get; set; }
        public DateTime fecha_hora_fin_clase { get; set; }
        public string? comentario { get; set; }

    }

    public class AddCursoEstudianteDTO
    {
        public int id_estudiante { get; set; }
        public List<ClasesCurso>? lista_cursos { get; set; }
        public string? comentario { get; set; }
        public string? usuario_creacion { get; set; }
        public byte estado_curso { get; set; }
        public byte resultado_curso { get; set; }
    }

    public class ClasesCurso
    {
        public int id_curso { get; set; }
        public int cantidad_clases { get; set; }
        public decimal valor_curso_registrado { get; set; }
    }
    
}
