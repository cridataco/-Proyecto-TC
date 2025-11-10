using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using plataforma_ecp.application.Interfaces;
using plataforma_ecp.domain.DTOs;

namespace plataforma_ecp.api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AsignacionClasesController : ControllerBase
    {
        private readonly IAsignacionClasesRepository repository;

        public AsignacionClasesController(IAsignacionClasesRepository repository)
        {
            this.repository = repository;
        }

        [HttpGet("GetAgenaClasesAsignaciones")]
        public async Task<IActionResult> GetAsignacionProfesor([FromQuery] ParametrosAgendaDto parametrosAgendaDto)
        {
            var paramsRegistros = await repository.obtenerAgendaClasesAsignaciones(parametrosAgendaDto);
            return Ok(paramsRegistros);
        }

        [HttpGet("GetAsignacionesActivas")]
        public async Task<IActionResult> GetAsignacionesActivas()
        {
            var paramsRegistros = await repository.obtenerASignacionesActivas();
            return Ok(paramsRegistros);
        }

        [HttpPost("InsertAsignacionProfesor")]
        public async Task<IActionResult> InsertAsignacionProfesor(AddAsignacionProfesorDto addAgendaProfesorDto)
        {
            var paramsRegistros = await repository.insertarAsignacionProfesor(addAgendaProfesorDto);
            return Ok(paramsRegistros);
        }

        [HttpPost("InsertClase")]
        public async Task<IActionResult> InsertClase(AddClaseDTO addClaseDto)
        {
            var paramsRegistros = await repository.registarClase(addClaseDto);
            return Ok(paramsRegistros);
        }

        [HttpGet("GetAsignacionesClases")]
        public async Task<IActionResult> GetAsignacionesClases([FromQuery] AgendaQueryFilter filter)
        {
            var paramsRegistros = await repository.obtenerAsignacionesClases(filter);
            return Ok(paramsRegistros);
        }

        [HttpGet("getDiasDisponiblesAgenda")]
        public async Task<IActionResult> getDiasDisponiblesAgenda(string fechas)
        {
            var paramsRegistros = await repository.obtenerDiasDisponiblesMesAnio(fechas);
            return Ok(paramsRegistros);
        }

        [HttpPost("ReprogramarCancelarClase")]
        public async Task<IActionResult> ReprogramarCancelarClase(ReprogramarCancelarClaseDTO reprogramarCancelarClaseDTO)
        {
            var paramsRegistros = await repository.reprogramarCancelarClase(reprogramarCancelarClaseDTO);
            return Ok(paramsRegistros);
        }

        [HttpPost("InsertCursoEstudiante")]
        public async Task<IActionResult> InsertCursoEstudiante(AddCursoEstudianteDTO addCursoEstudianteDTO)
        {
            var paramsRegistros = await repository.cursoEstudianteAsignar(addCursoEstudianteDTO);
            return Ok(paramsRegistros);
        }

        [HttpPut("UpdateCursoEstudiante")]
        public async Task<IActionResult> UpdateCursoEstudiante([FromBody] UpdateCursoEstudianteDTO dto)
        {
            var result = await repository.UpdateCursoEstudianteAsync(dto);
            if (!result.Successful)
                return BadRequest(result);
            return Ok(result);
        }

        [HttpGet("getEstudiantesAsignacionClases")]
        public async Task<IActionResult> GetEstudiantesAsignacionClases()
        {
            var paramsRegistros = await repository.obtenerEstudiantesAsignacionClases();
            return Ok(paramsRegistros);
        }
    }
}
