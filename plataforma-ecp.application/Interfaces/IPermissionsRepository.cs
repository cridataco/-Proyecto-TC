using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.application.Interfaces
{
    public interface IPermissionsRepository
    {
        Task<BussinesResponse> obtenerModulos();
        Task<BussinesResponse> insertarModulos(ParametrosAgendaDto parametrosAgendaDto);
        Task<BussinesResponse> obtenerModulosRutas();
        Task<BussinesResponse> insertarModulosRutas(ParametrosAgendaDto parametrosAgendaDto);
        Task<BussinesResponse> obtenerModulosRutasAcciones();
        Task<BussinesResponse> insertarModulosRutasAcciones(ParametrosAgendaDto parametrosAgendaDto);
        Task<BussinesResponse> obtenerRolesPermisos(int idRol, string modulo, string ruta);
    }
}
