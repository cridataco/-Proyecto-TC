using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.Entities
{
    public class Rol
    {
        [JsonPropertyName("consecutive")]  
        public int consecutivo { get; set; }
        [JsonPropertyName("name")]  
        public string nombre { get; set; }
    }
}
