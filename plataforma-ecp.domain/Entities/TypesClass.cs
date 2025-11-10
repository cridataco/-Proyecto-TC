using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.Entities
{
    public class TypesClass
    {
        [JsonPropertyName("id_class_type")]
        public int id_tipo_clase { get; set; }
        [JsonPropertyName("class_type")]
        public string tipo_clase { get; set; }
    }
}
