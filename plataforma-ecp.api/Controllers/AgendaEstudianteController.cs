using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using plataforma_ecp.application.Interfaces;
using plataforma_ecp.domain.DTOs;

namespace plataforma_ecp.api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AgendaEstudianteController : ControllerBase
    {
        private readonly IAgendaEstudianteRepository repository;

        public AgendaEstudianteController(IAgendaEstudianteRepository repository)
        {
            this.repository = repository;
        }


        [HttpGet("GetAgendaEstudiante")]
        public async Task<IActionResult> GetAgendaEstudiante([FromQuery] ParametrosAgendaDto parametrosAgendaDto)
        {
            var paramsRegistros = await repository.obtenerAgendaClasesEstudiante(parametrosAgendaDto);
            return Ok(paramsRegistros);
        }


        [HttpGet("GetAgendaEstudianteAsignada/{idEstudiante}")]
        public async Task<IActionResult> GetAgendaEstudianteAsignada(int idEstudiante)
        {
            var paramsRegistros = await repository.obtenerAgendaClasesEstudianteAsignada(idEstudiante);
            return Ok(paramsRegistros);
        }

        //Consulta las disponibilidades por una fecha especifica
        [HttpGet("GetDisponibilidadxFecha")]
        public async Task<IActionResult> GetDisponibilidadxFecha(DateTime fecha)
        {
            var paramsRegistros = await repository.obtenerDisponibilidadesxFecha(fecha);
            return Ok(paramsRegistros);
        }
    }
}
