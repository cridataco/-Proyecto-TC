using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using plataforma_ecp.application.Interfaces;

namespace plataforma_ecp.api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class PermissionsController : ControllerBase
    {
        private readonly IPermissionsRepository repository;
        public PermissionsController(IPermissionsRepository _repository)
        {
            repository = _repository;
        }

        [HttpGet("GetPermissionsbyRol")]
        public async Task<IActionResult> GetPermissionsbyRol(int idRol, string modulo, string ruta)
        {
            var paramsRegisters = await repository.obtenerRolesPermisos(idRol, modulo, ruta);
            return Ok(paramsRegisters);
        }

    }
}
