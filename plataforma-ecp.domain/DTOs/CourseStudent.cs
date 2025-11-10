using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.DTOs
{
    public class CourseStudentUserDto
    {
        [JsonPropertyName("idcourse")]
        public long id_curso { get; set; }

        [JsonPropertyName("id_student_course")]
        public long id_curso_estudiante { get; set; }

        [JsonPropertyName("course")]
        public string curso { get; set; }

        [JsonPropertyName("cantidad_clases")]
        public int cantidad_clases { get; set; }

        [JsonPropertyName("clases_restantes")]
        public int clases_restantes { get; set; }

        [JsonPropertyName("estado_curso")]
        public int estado_curso { get; set; }

        [JsonPropertyName("resultado_curso")]
        public int resultado_curso { get; set; }

        [JsonPropertyName("valor_curso_pagado")]
        public decimal valor_curso_pagado { get; set; }

        [JsonPropertyName("fecha_creacion")]
        public DateTime fecha_creacion { get; set; }
    }

    public class UpdateCursoEstudianteDTO
    {
        public long id_curso_estudiante { get; set; }  
        public byte? estado_curso { get; set; }   
        public byte? resultado_curso { get; set; }  
        public string usuario_modificacion { get; set; }  
    }
}
