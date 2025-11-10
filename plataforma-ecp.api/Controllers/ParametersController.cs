using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using plataforma_ecp.application.Interfaces;
using plataforma_ecp.domain.DTOs;

namespace plataforma_ecp.api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ParametersController : ControllerBase
    {
        private readonly IParametersRepository repository;

        public ParametersController(IParametersRepository repository)
        {
            this.repository = repository;
        }

        [HttpGet("GetRegistrationParameters")]
        public async Task<IActionResult> GetRegistrationParameters()
        {
            var paramsRegisters = await repository.ParametersRegister();
            return Ok(paramsRegisters);
        }

        [HttpGet("GetRegions")]
        public async Task<IActionResult> GetRegions()
        {
            var paramsRegisters = await repository.ObtainRegions();
            return Ok(paramsRegisters);
        }

        [HttpGet("GetCommunes")]
        public async Task<IActionResult> GetCommunes(int idRegion)
        {
            var paramsRegisters = await repository.ObtainCommunes(idRegion);
            return Ok(paramsRegisters);
        }

        [HttpGet("GetRoles")]
        public async Task<IActionResult> GetRoles()
        {
            var paramsRegisters = await repository.ObtainRoles();
            return Ok(paramsRegisters);
        }

        [HttpGet("GetTypesClasses")]
        public async Task<IActionResult> GetTypesClasses()
        {
            var paramsRegisters = await repository.ObtainTypesClasses();
            return Ok(paramsRegisters);
        }

        [HttpGet("GetStatesClasses")]
        public async Task<IActionResult> GetStatesClasses()
        {
            var paramsRegisters = await repository.ObtainStatesClasses();
            return Ok(paramsRegisters);
        }

        //Oscar
        [HttpGet("GetCourses")]
        public async Task<IActionResult> GetCourses()
        {
            var paramsRegisters = await repository.GetCourses();
            return Ok(paramsRegisters);
        }

        [HttpPost("PostCourses")]
        public async Task<IActionResult> PostCourses(PostCoursesDTO postCoursesDTO)
        {
            var paramsRegisters = await repository.PostCourses(postCoursesDTO);
            return Ok(paramsRegisters);
        }

        [HttpPut("PutCourses")]
        public async Task<IActionResult> PutCourses(PutCoursesDTO putCoursesDTO)
        {
            var paramsRegisters = await repository.PutCourses(putCoursesDTO);
            return Ok(paramsRegisters);
        }
    }
}
