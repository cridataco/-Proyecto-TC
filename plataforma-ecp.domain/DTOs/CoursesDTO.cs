using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.DTOs
{
    public class Courses
    {
        [JsonPropertyName("name")]
        public string nombre { get; set; }
        [JsonPropertyName("description")]
        public string descripcion { get; set; }
        [JsonPropertyName("value")]
        public decimal valor { get; set; }
        [JsonPropertyName("number_of_classes")]
        public byte cantidad_clases { get; set; }
        [JsonPropertyName("state")]
        public bool estado { get; set; }
    }
    public class GetCoursesDTO : Courses
    {
        [JsonPropertyName("consecutive")]
        public long consecutivo { get; set; }

    }

    public class PostCoursesDTO : Courses
    {
        [JsonPropertyName("user_creation")]
        public string usuario_creacion { get; set; }
    }

    public class PutCoursesDTO : Courses
    {
        [JsonPropertyName("consecutive")]
        public long consecutivo { get; set; }
        [JsonPropertyName("user_creation")]
        public string usuario_creacion { get; set; }
    }
}
