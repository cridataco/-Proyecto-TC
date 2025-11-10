using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using plataforma_ecp.api.JWTHelper;
using plataforma_ecp.application.Interfaces;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;

namespace plataforma_ecp.api.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IUserRepository usuarioRepository;
        private readonly IWebHostEnvironment _environment; // Inyección de IWebHostEnvironment

        public AuthController(IUserRepository usuarioRepository, IWebHostEnvironment environment)
        {
            this.usuarioRepository = usuarioRepository;
            this._environment = environment;  // Asigna la inyección al campo
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login([FromBody] LoginDto credenciales)
        {
            var response = new BussinesResponse();
            response.Successful = true;
            response.Entity = null;

            try
            {
                // Obtener el usuario desde el repositorio
                var usuario = await this.usuarioRepository.GetUserLogin(credenciales);

                if (usuario.Successful && usuario.Entity != null && string.IsNullOrEmpty(usuario.Error))
                {
                    // Convertir el usuario a DTO
                    var userString = JsonConvert.SerializeObject(usuario.Entity);
                    var usuarioDto = JsonConvert.DeserializeObject<LoginUsuarioDto>(userString);

                    // Generar el token JWT
                    string token = new JWT().GenerateToken(usuarioDto);

                    // Crear la respuesta que contiene los datos del usuario, sin el token
                    var loginResponse = new
                    {
                        arbolPermisos = usuarioDto,
                        token = token ?? ""
                    };

                    // Devolver la respuesta exitosa con la información del usuario
                    response.Error = "";
                    response.Entity = loginResponse;
                    return Ok(response);
                }

                // En caso de error, devolver un 404 con el mensaje correspondiente
                response.Error = usuario.Error;
                response.Successful = false;
                return NotFound(response);
            }
            catch (Exception ex)
            {
                // En caso de excepción, devolver un error 400 con el mensaje
                response.Successful = false;
                response.Error = ex.Message;
                return BadRequest(response);
            }
        }
    }
}
