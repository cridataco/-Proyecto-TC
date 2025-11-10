using plataforma_ecp.domain.Entities;
using plataforma_ecp.domain.Validators;
using System.Text.Json.Serialization;

namespace plataforma_ecp.domain.DTOs
{
    public class ListUsuariosDTO
    {
        [JsonPropertyName("consecutive")]
        public long consecutivo { get; set; }
        [JsonPropertyName("name")]
        public string? nombre { get; set; }
        [JsonPropertyName("last_name")]
        public string? apellido { get; set; }
        public string? run { get; set; }
        [JsonPropertyName("phone")]
        public string? telefono { get; set; }
        public string? email { get; set; }
        [JsonPropertyName("payment_approved")]
        public bool? pago_aprobado { get; set; }
        [JsonPropertyName("access_enabled")]
        public bool? acceso_habilitado { get; set; }
        [JsonPropertyName("rol")]
        public int id_rol { get; set; }
    }
    public class AddUserDTO
    {
        [JsonPropertyName("name")]
        public string? nombre { get; set; }
        [JsonPropertyName("last_name")]
        public string? apellido { get; set; }
        //[RutValidador]
        public string? run { get; set; }
        [JsonPropertyName("id_genre")]
        public int id_genero { get; set; }
        [JsonPropertyName("date_born")]
        public DateTime fecha_nacimiento { get; set; }
        [JsonPropertyName("phone")]
        public string? telefono { get; set; }
        public string? email { get; set; }
        [JsonPropertyName("address")]
        public string? direccion { get; set; }
        public string? password { get; set; }
        [JsonPropertyName("address_detail")]
        public string? direccion_detalle { get; set; }
        [JsonPropertyName("id_commune")]
        public int id_comuna { get; set; }
        [JsonPropertyName("job")]
        public string? oficio { get; set; }
        [JsonPropertyName("medium_enter")]
        public int medio_enterar { get; set; }
        [JsonPropertyName("allergy_medications")]
        public string medicamentos_alergias { get; set; }
        [JsonPropertyName("pregnancy")]
        public bool embarazo { get; set; }
        [JsonPropertyName("months_pregnancy")]
        public int meses_embarazo { get; set; }
        [JsonPropertyName("special_observations")]
        public string observaciones_especiales { get; set; }
        [JsonPropertyName("visual_examination")]
        public bool examen_visual { get; set; }
        public int[] roles { get; set; }
        [JsonPropertyName("locations")]
        public int[] sedes { get; set; }
        [JsonPropertyName("user_creation")]
        public string usuario_creacion { get; set; }

    }

    public class UpdateUsuarioDto
    {
        [JsonPropertyName("name")]
        public string? nombre { get; set; }
        [JsonPropertyName("last_name")]
        public string? apellido { get; set; }
        [JsonPropertyName("id_genre")]
        public int id_genero { get; set; }
        [JsonPropertyName("date_born")]
        public DateTime fecha_nacimiento { get; set; }
        [JsonPropertyName("phone")]
        public string? telefono { get; set; }
        public string? email { get; set; }
        [JsonPropertyName("address")]
        public string? direccion { get; set; }
        [JsonPropertyName("address_detail")]
        public string? direccion_detalle { get; set; }
        [JsonPropertyName("id_commune")]
        public int id_comuna { get; set; }
        [JsonPropertyName("job")]
        public string? oficio { get; set; }
        [JsonPropertyName("medium_enter")]
        public int medio_enterar { get; set; }
        [JsonPropertyName("allergy_medications")]
        public string medicamentos_alergias { get; set; }
        public bool embarazo { get; set; }
        [JsonPropertyName("months_pregnancy")]
        public int meses_embarazo { get; set; }
        [JsonPropertyName("special_observations")]
        public string observaciones_especiales { get; set; }
        public bool examen_visual { get; set; }
        public int[] roles { get; set; }
        [JsonPropertyName("locations")]
        public int[] sedes { get; set; }
        //public int id_rol { get; set; }
        [JsonPropertyName("user_modification")]
        public string usuario_modificacion { get; set; }
    }

    public class ToggleAccessDto
    {
        [JsonPropertyName("consecutive")]
        public long consecutivo { get; set; }

        [JsonPropertyName("access_enabled")]
        public bool acceso_habilitado { get; set; }

        [JsonPropertyName("user_modification")]
        public string usuario_modificacion { get; set; }
    }
}
