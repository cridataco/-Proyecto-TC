using plataforma_ecp.application.Interfaces;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using plataforma_ecp.infrastructure.Data;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using plataforma_ecp.application.Services;

namespace plataforma_ecp.infrastructure.Repositories
{
    public class PermissionsRepository : IPermissionsRepository
    {
        private readonly Connection _connection;
        public PermissionsRepository()
        {
            _connection = new Connection(AppKeys.Instance._cadenaConexion);
        }

        public Task<BussinesResponse> insertarModulos(ParametrosAgendaDto parametrosAgendaDto)
        {
            throw new NotImplementedException();
        }

        public Task<BussinesResponse> insertarModulosRutas(ParametrosAgendaDto parametrosAgendaDto)
        {
            throw new NotImplementedException();
        }

        public Task<BussinesResponse> insertarModulosRutasAcciones(ParametrosAgendaDto parametrosAgendaDto)
        {
            throw new NotImplementedException();
        }

        public Task<BussinesResponse> obtenerModulos()
        {
            throw new NotImplementedException();
        }

        public Task<BussinesResponse> obtenerModulosRutas()
        {
            throw new NotImplementedException();
        }

        public Task<BussinesResponse> obtenerModulosRutasAcciones()
        {
            throw new NotImplementedException();
        }

        public async Task<BussinesResponse> obtenerRolesPermisos(int idRol, string modulo, string ruta)
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Datos = new DataTable();

            try
            {

                string errorMessage = string.Empty;

                SqlParameter[] parameters =
                 {
                    new SqlParameter{ParameterName= "@id_rol", Value=idRol },
                    new SqlParameter{ParameterName= "@modulo", Value=modulo },
                    new SqlParameter{ParameterName= "@ruta", Value=ruta }
                };

                Datos = await Task.Run(() => _connection.GetDataTable("roles_permisos_consultar", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var result = DataTableHelper.ConvertDataTableToList<GetRolesPermisos>(Datos);
                if (result.Count > 0)
                {
                    var resultado = result
                  .GroupBy(d => new { d.modulo, d.ruta })
                  .Select(g => new
                  {
                      modulo = g.Key.modulo,
                      ruta = g.Key.ruta,
                      accion = g.ToDictionary(x => x.accion, x => x.acceso)
                  })
                  .ToList();
                    response.Entity = resultado;
                }


                response.Successful = true;
                response.Error = string.Empty;
                return response;
            }
            catch (Exception ex)
            {
                response.Entity = null;
                response.Successful = false;
                response.Error = ex.Message;
                return response;
            }
        }
    }
}
