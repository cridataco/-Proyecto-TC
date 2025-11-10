using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.application.Interfaces
{
    public interface IAgendaEstudianteRepository
    {
        Task<BussinesResponse> obtenerAgendaClasesEstudiante(ParametrosAgendaDto agendaEstudianteConsultarDto);
        Task<BussinesResponse> obtenerAgendaClasesEstudianteAsignada(int idEstudiante);
        Task<BussinesResponse> obtenerDisponibilidadesxFecha(DateTime fecha);
    }
}
