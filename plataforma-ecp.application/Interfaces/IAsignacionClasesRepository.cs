using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;

namespace plataforma_ecp.application.Interfaces
{
    public interface IAsignacionClasesRepository
    {
        Task<BussinesResponse> obtenerAgendaClasesAsignaciones(ParametrosAgendaDto parametrosAgendaDto);
        Task<BussinesResponse> obtenerASignacionesActivas();
        Task<BussinesResponse> insertarAsignacionProfesor(AddAsignacionProfesorDto addAgendaProfesorDto);
        Task<BussinesResponse> registarClase(AddClaseDTO createClaseDto);
        Task<BussinesResponse> obtenerAsignacionesClases(AgendaQueryFilter filter);
        Task<BussinesResponse> reprogramarCancelarClase(ReprogramarCancelarClaseDTO EditClaseDTO);
        Task<BussinesResponse> cursoEstudianteAsignar(AddCursoEstudianteDTO addCursoEstudianteDTO);
        Task<BussinesResponse> UpdateCursoEstudianteAsync(UpdateCursoEstudianteDTO dto);
        Task<BussinesResponse> obtenerDiasDisponiblesMesAnio(string fechas);
        Task<BussinesResponse> obtenerEstudiantesAsignacionClases();
    }
}
