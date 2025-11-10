using plataforma_ecp.domain.DTOs;
using System.Text.Json.Serialization;

namespace plataforma_ecp.domain.Entities
{
    public class User
    {
        [JsonPropertyName("consecutive")]
        public long consecutivo { get; set; }
        [JsonPropertyName("name")]
        public string ? nombre { get; set; }
        [JsonPropertyName("last_name")]
        public string? apellido { get; set; }
        public string? run { get; set; }
        [JsonPropertyName("id_genre")]
        public int id_genero { get; set; }
        [JsonPropertyName("genre")]
        public string ?genero { get; set; }
        [JsonPropertyName("date_born")]
        public DateTime fecha_nacimiento { get; set; }
        [JsonPropertyName("phone")]
        public string? telefono { get; set; }
        public string? email { get; set; }
        public string? password { get; set; }
        [JsonPropertyName("address")]
        public string? direccion { get; set; }
        [JsonPropertyName("address_detail")]
        public string? direccion_detalle { get; set; }
        [JsonPropertyName("region_id")]
        public int id_region { get; set; }
        public string? region { get; set; }
        [JsonPropertyName("id_province_")]
        public int id_provincia { get; set; }
        [JsonPropertyName("province")]
        public string? provincia { get; set; }
        [JsonPropertyName("id_commune")]
        public int id_comuna { get; set; }
        [JsonPropertyName("commune")]
        public string ?comuna { get; set; }
        [JsonPropertyName("job")]
        public string? oficio { get; set; }
        [JsonPropertyName("medium_enter")]
        public int medio_enterar { get; set; }
        public List<RolDTO> roles { get; set; }
        [JsonPropertyName("locations")]
        public List<LocationDTO> sedes { get; set; }
        [JsonPropertyName("allergy_medications")]
        public string? medicamentos_alergias { get; set; }
        [JsonPropertyName("pregnancy")]
        public bool embarazo { get; set; }
        [JsonPropertyName("months_pregnancy")]
        public int meses_embarazo { get; set; }
        [JsonPropertyName("special_observations")]
        public string? observaciones_especiales { get; set; }
        [JsonPropertyName("visual_examination")]
        public bool examen_visual { get; set; }
        //public int id_rol { get; set; } 
    }

    public class RolDTO {
        [JsonPropertyName("id_user")]
        public int id_usuario { get; set; }
        public int id_rol { get; set; }
        [JsonPropertyName("name")]
        public string nombre { get; set; }
    }

    public class LocationDTO {
        [JsonPropertyName("id_user")]
        public int id_usuario { get; set; }
        [JsonPropertyName("id_location")]
        public int id_sede { get; set; }
        [JsonPropertyName("location_name")]
        public string nombre_sede { get; set; }
    }
}
