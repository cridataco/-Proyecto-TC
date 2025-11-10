using plataforma_ecp.application.Interfaces;
using plataforma_ecp.application.Services;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using plataforma_ecp.infrastructure.Data;
using System.Data;
using System.Data.SqlClient;

namespace plataforma_ecp.infrastructure.Repositories
{
    public class AsignacionClasesRepository : IAsignacionClasesRepository
    {
        private readonly Connection _conexion;
        public AsignacionClasesRepository()
        {
            _conexion = new Connection(AppKeys.Instance._cadenaConexion);
        }

        /// <summary>
        /// Método encargado de consultar toda la agenda de acuerdo a un rango de fechas
        /// </summary>
        /// <param nombre="idProfesor"></param>
        /// <returns></returns>
        public async Task<BussinesResponse> obtenerAgendaClasesAsignaciones(ParametrosAgendaDto parametrosAgendaDto)
        {

            BussinesResponse respuesta = new BussinesResponse();
            DataTable Datos = new DataTable();
            var fechaIniSP = Convert.ToDateTime(parametrosAgendaDto.fecha_ini.ToString("yyyy-MM-dd"));
            var fechaFinSP = Convert.ToDateTime(parametrosAgendaDto.fecha_fin.ToString("yyyy-MM-dd")).Add(new TimeSpan(23, 59, 59));
            try
            {
                SqlParameter[] parametros =
                 {
                    new SqlParameter{ParameterName= "fecha_ini", Value=fechaIniSP.ToString("yyyy-MM-dd HH:mm:ss") },
                    new SqlParameter{ParameterName= "fecha_fin", Value=fechaFinSP.ToString("yyyy-MM-dd HH:mm:ss") },
                    new SqlParameter{ParameterName= "id_profesor", Value=parametrosAgendaDto.id_profesor==0 ? DBNull.Value: parametrosAgendaDto.id_profesor },
                    new SqlParameter{ParameterName= "id_estudiante", Value=parametrosAgendaDto.id_estudiante==0 ? DBNull.Value: parametrosAgendaDto.id_estudiante }
                };
                string mensajeDeError = string.Empty;
                Datos = await Task.Run(() => _conexion.GetDataTable("agenda_profesor_consultar", ref mensajeDeError, parametros));

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
        public async Task<BussinesResponse> obtenerASignacionesActivas()
        {

            BussinesResponse respuesta = new BussinesResponse();
            DataTable Datos = new DataTable();

            try
            {

                string mensajeDeError = string.Empty;
                Datos = await Task.Run(() => _conexion.GetDataTable("agenda_profesor_consultar_asignados", ref mensajeDeError));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }

                var listado = DataTableHelper.ConvertDataTableToList<ListAsignacionActivaDto>(Datos);

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
        public async Task<BussinesResponse> insertarAsignacionProfesor(AddAsignacionProfesorDto addAgendaProfesorDto)
        {
            BussinesResponse respuesta = new BussinesResponse();
            bool result = false;

            try
            {
                string mensajeDeError = string.Empty;
                string listadoFechas = string.Empty;
                addAgendaProfesorDto.disponibilidad.ForEach(x =>
                    {
                        listadoFechas += string.Concat(x.fechaInicial.ToString("yyyy-MM-dd HH:mm:ss"), ",", x.fechaFinal.ToString("yyyy-MM-dd HH:mm:ss"), "&");
                    });
                listadoFechas.Remove(listadoFechas.Length - 1, 1);

                SqlParameter[] parametros =
                {
                    new SqlParameter {ParameterName= "@id_profesor", Value=addAgendaProfesorDto.id_profesor },
                    new SqlParameter {ParameterName= "@id_tipo_clase", Value=addAgendaProfesorDto.id_tipo_clase },
                    new SqlParameter {ParameterName= "@lista_fechas", Value= listadoFechas},
                    new SqlParameter {ParameterName= "@usuario_creacion", Value=addAgendaProfesorDto.usuario_creacion},


                };
                result = await Task.Run(() => _conexion.InsertUpdateDelete("agenda_profesor_insertar", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }
                respuesta.Entity = result;
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
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
        public async Task<BussinesResponse> registarClase(AddClaseDTO createClaseDto)
        {
            BussinesResponse respuesta = new BussinesResponse();
            bool result = false;

            try
            {
                string mensajeDeError = string.Empty;
                string listadoDisponibilidad = string.Join(", ", createClaseDto.listado_disponibilidad);


                SqlParameter[] parametros =
                {

                    new SqlParameter {ParameterName= "@consecutivo_curso_estudiante", Value=createClaseDto.consecutivo_curso_estudiante},
                    new SqlParameter {ParameterName= "@listado_disponibilidad", Value=listadoDisponibilidad },
                    new SqlParameter {ParameterName= "@usuario_creacion", Value=createClaseDto.usuario_creacion},


                };
                result = await Task.Run(() => _conexion.InsertUpdateDelete("clases_insertar_primera_asignacion", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }
                respuesta.Entity = result;
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
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
        public async Task<BussinesResponse> obtenerAsignacionesClases(AgendaQueryFilter filter)
        {
            BussinesResponse respuesta = new BussinesResponse();
            DataTable Datos = new DataTable();

            try
            {
                var fechaIniSP = filter.FechaIni.HasValue ? Convert.ToDateTime(filter.FechaIni.Value.ToString("yyyy-MM-dd")) : (DateTime?)null;
                var fechaFinSP = filter.FechaFin.HasValue ? Convert.ToDateTime(filter.FechaFin.Value.ToString("yyyy-MM-dd")).Add(new TimeSpan(23, 59, 59)) : (DateTime?)null;

                SqlParameter[] parametros =
                {
            new SqlParameter{ ParameterName= "@IdProfesor", Value= filter.IdProfesor == 0 ? DBNull.Value : (object)filter.IdProfesor },
            new SqlParameter{ ParameterName= "@IdEstudiante", Value= filter.IdEstudiante == 0 ? DBNull.Value : (object)filter.IdEstudiante },
            new SqlParameter{ ParameterName= "@Horario", Value= string.IsNullOrEmpty(filter.Horario) ? DBNull.Value : (object)filter.Horario },
            new SqlParameter{ ParameterName= "@ClaseDisponible", Value= filter.ClaseDisponible == null ? DBNull.Value : (object)filter.ClaseDisponible },
            new SqlParameter{ ParameterName= "@FechaIni", Value= fechaIniSP.HasValue ? (object)fechaIniSP.Value.ToString("yyyy-MM-dd HH:mm:ss") : DBNull.Value },
            new SqlParameter{ ParameterName= "@FechaFin", Value= fechaFinSP.HasValue ? (object)fechaFinSP.Value.ToString("yyyy-MM-dd HH:mm:ss") : DBNull.Value }
        };

                string mensajeDeError = string.Empty;
                Datos = await Task.Run(() => _conexion.GetDataTable("agendas_clases_consultar", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }

                var listado = DataTableHelper.ConvertDataTableToList<GetAgendaClaseDTO>(Datos);

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

        public async Task<BussinesResponse> reprogramarCancelarClase(ReprogramarCancelarClaseDTO reprogramarCancelarClaseDTO)
        {
            BussinesResponse respuesta = new BussinesResponse();
            bool result = false;

            try
            {
                string mensajeDeError = string.Empty;

                SqlParameter[] parametros =
                {
                    new SqlParameter {ParameterName= "@accion", Value=reprogramarCancelarClaseDTO.accion },
                    new SqlParameter {ParameterName= "@consecutivo_curso_estudiante", Value=reprogramarCancelarClaseDTO.consecutivo_curso_estudiante },
                    new SqlParameter {ParameterName= "@id_clase", Value=reprogramarCancelarClaseDTO.id_clase },
                    new SqlParameter {ParameterName= "@id_agenda", Value=reprogramarCancelarClaseDTO.id_agenda },
                    new SqlParameter {ParameterName= "@comentario", Value=reprogramarCancelarClaseDTO.comentario},
                    new SqlParameter {ParameterName= "@usuario_modificacion", Value=reprogramarCancelarClaseDTO.usuario_modificacion},


                };
                result = await Task.Run(() => _conexion.InsertUpdateDelete("clase_reprogramar_cancelar", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }
                respuesta.Entity = result;
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
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
        public async Task<BussinesResponse> cursoEstudianteAsignar(AddCursoEstudianteDTO addCursoEstudianteDTO)
        {
            BussinesResponse respuesta = new BussinesResponse();
            try
            {
                string mensajeDeError = string.Empty;
                string listadoCursos = string.Empty;

                foreach (var item in addCursoEstudianteDTO.lista_cursos)
                    listadoCursos += $"{item.id_curso}|{item.cantidad_clases}|{item.valor_curso_registrado},";

                SqlParameter[] parametros =
                {
            new SqlParameter { ParameterName = "@id_estudiante",    Value = addCursoEstudianteDTO.id_estudiante },
            new SqlParameter { ParameterName = "@lista_cursos",     Value = listadoCursos },
            new SqlParameter { ParameterName = "@comentario",       Value = addCursoEstudianteDTO.comentario },
            new SqlParameter { ParameterName = "@usuario_creacion", Value = addCursoEstudianteDTO.usuario_creacion },
            new SqlParameter { ParameterName = "@estado_curso",     Value = addCursoEstudianteDTO.estado_curso },
            new SqlParameter { ParameterName = "@resultado_curso",  Value = addCursoEstudianteDTO.resultado_curso }
        };

                bool result = await Task.Run(() =>
                    _conexion.InsertUpdateDelete("curso_estudiante_asignar", ref mensajeDeError, parametros)
                );

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                    return new BussinesResponse { Successful = false, Error = mensajeDeError };

                return new BussinesResponse
                {
                    Entity = result,
                    Successful = true,
                    Error = string.Empty
                };
            }
            catch (Exception ex)
            {
                return new BussinesResponse { Entity = null, Successful = false, Error = ex.Message };
            }
        }

        public async Task<BussinesResponse> UpdateCursoEstudianteAsync(UpdateCursoEstudianteDTO dto)
        {
            var response = new BussinesResponse();
            try
            {
                string errorMsg = string.Empty;
                SqlParameter[] parameters =
                {
            new SqlParameter("@id_curso_estudiante", dto.id_curso_estudiante),
            new SqlParameter("@estado_curso",        dto.estado_curso.HasValue
                                                      ? (object)dto.estado_curso.Value
                                                      : DBNull.Value),
            new SqlParameter("@resultado_curso",     dto.resultado_curso.HasValue
                                                      ? (object)dto.resultado_curso.Value
                                                      : DBNull.Value),
            new SqlParameter("@usuario_modificacion", dto.usuario_modificacion)
        };

                bool result = await Task.Run(() =>
                    _conexion.InsertUpdateDelete(
                        "curso_estudiante_modificar",
                        ref errorMsg,
                        parameters
                    )
                );

                if (!string.IsNullOrEmpty(errorMsg))
                    return new BussinesResponse { Successful = false, Error = errorMsg };

                return new BussinesResponse
                {
                    Entity = result,
                    Successful = true,
                    Error = string.Empty
                };
            }
            catch (Exception ex)
            {
                return new BussinesResponse
                {
                    Entity = null,
                    Successful = false,
                    Error = ex.Message
                };
            }
        }


        public async Task<BussinesResponse> obtenerDiasDisponiblesMesAnio(string fechas)
        {
            BussinesResponse respuesta = new BussinesResponse();
            DataTable result = new DataTable();

            try
            {
                string mensajeDeError = string.Empty;

                SqlParameter[] parametros =
                {
                    new SqlParameter {ParameterName= "@fechas", Value=fechas }



                };
                result = await Task.Run(() => _conexion.GetDataTable("clases_fechas_disponibles_asignacion_anio_mes", ref mensajeDeError, parametros));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }


                var listado = DataTableHelper.ConvertDataTableToList<DiasDisponiblesAsignarClase>(result);

                respuesta.Entity = listado;
                respuesta.Total = listado.Count;
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
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
        public async Task<BussinesResponse> obtenerEstudiantesAsignacionClases()
        {
            BussinesResponse respuesta = new BussinesResponse();
            DataTable result = new DataTable();

            try
            {
                string mensajeDeError = string.Empty;
                result = await Task.Run(() => _conexion.GetDataTable("asignacion_clases_consultar_alumnos", ref mensajeDeError));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    respuesta.Successful = false;
                    respuesta.Error = mensajeDeError;
                    return respuesta;
                }


                var listado = DataTableHelper.ConvertDataTableToList<EstudiantesActivosDTO>(result);

                respuesta.Entity = listado;
                respuesta.Total = listado.Count;
                respuesta.Successful = true;
                respuesta.Error = string.Empty;
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
