using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.Entities
{
    public class StatesClass
    {
        [JsonPropertyName("id_class_state")]
        public int id_estado_clase { get; set; }
        [JsonPropertyName("class_status")]
        public string estado_clase { get; set; }
    }
}
