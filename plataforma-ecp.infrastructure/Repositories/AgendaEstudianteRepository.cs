using plataforma_ecp.application.Interfaces;
using plataforma_ecp.application.Services;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using plataforma_ecp.infrastructure.Data;

namespace plataforma_ecp.infrastructure.Repositories
{
    public class AgendaEstudianteRepository : IAgendaEstudianteRepository
    {
        private readonly Connection _conexion;
        public AgendaEstudianteRepository()
        {
            _conexion = new Connection(AppKeys.Instance._cadenaConexion);
        }

        public async Task<BussinesResponse> obtenerAgendaClasesEstudiante(ParametrosAgendaDto agendaEstudianteConsultarDto)
        {

            BussinesResponse respuesta = new BussinesResponse();
            DataTable Datos = new DataTable();
            var fechaIniSP = Convert.ToDateTime(agendaEstudianteConsultarDto.fecha_ini.ToString("yyyy-MM-dd"));
            var fechaFinSP = Convert.ToDateTime(agendaEstudianteConsultarDto.fecha_fin.ToString("yyyy-MM-dd")).Add(new TimeSpan(23, 59, 59));
            try
            {
                SqlParameter[] parametros =
                 {
                    new SqlParameter{ParameterName= "fecha_ini", Value=fechaIniSP.ToString("yyyy-MM-dd HH:mm:ss") },
                    new SqlParameter{ParameterName= "fecha_fin", Value=fechaFinSP.ToString("yyyy-MM-dd HH:mm:ss") },
                    new SqlParameter{ParameterName= "id_estudiante", Value=agendaEstudianteConsultarDto.id_estudiante==0 ? DBNull.Value: agendaEstudianteConsultarDto.id_estudiante }
                };
                string mensajeDeError = string.Empty;
                Datos = await Task.Run(() => _conexion.GetDataTable("clases_agenda_consultar_asignados_estudiante", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }

                var listado = DataTableHelper.ConvertDataTableToList<AgendaAsignacionClases>(Datos);

                respuesta.Entity = listado.OrderBy(x => x.fecha_hora_inicio_clase);
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
                respuesta.Total = listado.Count;
                return respuesta;
            }
            catch (Exception ex)
            {
                respuesta.Entity = null;
                respuesta.Successful = false;
                respuesta.Error = ex.Message;
                return respuesta;
            }
        }

        public async Task<BussinesResponse> obtenerAgendaClasesEstudianteAsignada(int idEstudiante)
        {
            BussinesResponse respuesta = new BussinesResponse();
            DataTable Datos = new DataTable();
            try
            {
                SqlParameter[] parametros =
                 {
                    new SqlParameter{ParameterName= "id_estudiante", Value=idEstudiante }
                };
                string mensajeDeError = string.Empty;
                Datos = await Task.Run(() => _conexion.GetDataTable("clases_estudiante", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }

                var listado = DataTableHelper.ConvertDataTableToList<AgendaEstudianteClasesAsignadas>(Datos);

                respuesta.Entity = listado;
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
                respuesta.Total = listado.Count;
                return respuesta;
            }
            catch (Exception ex)
            {
                respuesta.Entity = null;
                respuesta.Successful = false;
                respuesta.Error = ex.Message;
                return respuesta;
            }
        }
        public async Task<BussinesResponse> obtenerDisponibilidadesxFecha(DateTime fecha)
        {
            BussinesResponse respuesta = new BussinesResponse();
            DataTable Datos = new DataTable();
            try
            {
                SqlParameter[] parametros =
                 {
                    new SqlParameter{ParameterName= "@fecha", Value=fecha }
                };
                string mensajeDeError = string.Empty;
                Datos = await Task.Run(() => _conexion.GetDataTable("agenda_consultar_disponibilidad_xfecha", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }

                var listado = DataTableHelper.ConvertDataTableToList<DisponibilidadxFechaDto>(Datos);

                respuesta.Entity = listado;
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
                respuesta.Total = listado.Count;
                return respuesta;
            }
            catch (Exception ex)
            {
                respuesta.Entity = null;
                respuesta.Successful = false;
                respuesta.Error = ex.Message;
                return respuesta;
            }
        }
    }
}
