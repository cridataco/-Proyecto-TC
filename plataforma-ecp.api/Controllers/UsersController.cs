using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using plataforma_ecp.api.Response;
using plataforma_ecp.application.Interfaces;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using plataforma_ecp.infrastructure.Repositories;

namespace plataforma_ecp.api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly ILogger<UsersController> _logger;
        private readonly IUserRepository usuarioRepository;
        private readonly IUriService uriService;

        public UsersController(ILogger<UsersController> logger, IUserRepository userRepository, IUriService uriService)
        {
            _logger = logger;
            this.usuarioRepository = userRepository;
            this.uriService = uriService;
        }

        [HttpGet("GetUsers")]
        public async Task<IActionResult> GetUsers([FromQuery] UsuarioQueryFilter filter)
        {
            var users = await this.usuarioRepository.ObtainUsers(filter);
            return Ok(users);
        }

        [HttpGet("GetUsersDetail")]
        public async Task<IActionResult> GetUsersDetail([FromQuery] int consecutive)
        {
            var users = await this.usuarioRepository.GetUserDetails(consecutive);
            return Ok(users);
        }

        [HttpGet("GetUsersCourseStudent")]
        public async Task<IActionResult> GetUsersCourseStudent([FromQuery] int idStudent)
        {
            var users = await this.usuarioRepository.GetCourseStudentParameterUser(idStudent);
            return Ok(users);
        }

        [HttpPost]
        public async Task<IActionResult> PostUser(AddUserDTO user)
        {
            var result = await this.usuarioRepository.InsertUser(user);
            return Ok(result);
        }

        [HttpPut]
        public async Task<IActionResult> PutUser([FromQuery][Required(ErrorMessage = "El parámetro consecutivo es requerido")] int consecutive, [FromBody] UpdateUsuarioDto userDTO)
        {
            var result = await this.usuarioRepository.UpdateUser(consecutive, userDTO);
            return Ok(result);
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteUser([FromQuery][Required(ErrorMessage = "El parámetro consecutivo es requerido")] int consecutive, string userDelete)
        {
            var result = await this.usuarioRepository.DeleteUser(consecutive, userDelete);
            return Ok(result);
        }

        [HttpGet("ValidateUser")]
        public async Task<IActionResult> ValidateUser([FromQuery][Required(ErrorMessage = "El parámetro run es requerido")] string run)
        {
            var result = await this.usuarioRepository.ValidateRun(run);
            return Ok(result);
        }

        [HttpPut("ToggleAccess")]
        public async Task<IActionResult> ToggleAccess([FromBody] ToggleAccessDto dto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var result = await this.usuarioRepository.ToggleAccess(dto);
            return Ok(result);
        }
    }
}
