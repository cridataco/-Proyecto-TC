using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.DTOs
{
    public class ParametersDTO
    {
    }

    public class Communes
    {
        public int id { get; set; }
        [JsonPropertyName("commune")]   
        public string comuna { get; set; }
    }
    public class Regions
    {
        public int id { get; set; }
        public string region { get; set; }
    }
    public class Location
    {
        [JsonPropertyName("consecutive")]   
        public int consecutivo { get; set; }
        [JsonPropertyName("location_name")] 
        public string? nombre_sede { get; set; }
        [JsonPropertyName("address")] 
        public string? direccion { get; set; }
    }

    public class Genres
    {
        public int id { get; set; } 
        [JsonPropertyName("genre")]
        public string? genero { get; set; }  
    }

    public class Media
    {
        public int id { get; set; }
        [JsonPropertyName("media")]
        public string? medio { get; set; }
    }

    public class ParametersRegister {
        [JsonPropertyName("locations")]   
        public List<Location>? sedes { get; set; }
        [JsonPropertyName("genres")]   
        public List<Genres>? generos { get; set; }
        [JsonPropertyName("media")]
        public List<Media>? medios { get; set; }
    }
}
