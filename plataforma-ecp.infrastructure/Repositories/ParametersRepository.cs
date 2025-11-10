using plataforma_ecp.application.Interfaces;
using plataforma_ecp.application.Services;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using plataforma_ecp.infrastructure.Data;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace plataforma_ecp.infrastructure.Repositories
{
    public class ParametersRepository : IParametersRepository
    {
        private readonly Connection _connection;
        public ParametersRepository()
        {
            _connection = new Connection(AppKeys.Instance._cadenaConexion);
        }

        public async Task<BussinesResponse> ObtainCommunes(int idRegion)
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {
                SqlParameter[] parameters =
                 {
                    new SqlParameter{ParameterName= "id_region", Value=idRegion }
                };
                string errorMessage = string.Empty;
                Data = await Task.Run(() => _connection.GetDataTable("comunas_consultar_region", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var listed = DataTableHelper.ConvertDataTableToList<Communes>(Data);

                response.Entity = listed;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = listed.Count;
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

        public async Task<BussinesResponse> ObtainRegions()
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _connection.GetDataTable("regiones_consultar", ref errorMessage));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var listed = DataTableHelper.ConvertDataTableToList<Regions>(Data);

                response.Entity = listed;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = listed.Count;
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

        public async Task<BussinesResponse> ParametersRegister()
        {

            BussinesResponse response = new BussinesResponse();
            DataSet Data = new DataSet();

            try
            {
                string errorMessage = string.Empty;
                Data = await Task.Run(() => _connection.GetDataSet("parametros_registro_consultar", ref errorMessage));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }
                var locations = DataTableHelper.ConvertDataTable<Location>(Data.Tables[0]);
                var genres = DataTableHelper.ConvertDataTable<Genres>(Data.Tables[1]);
                var media = DataTableHelper.ConvertDataTable<Media>(Data.Tables[2]);

                ParametersRegister parametersRegister = new ParametersRegister()
                {
                    sedes = locations,
                    generos = genres,
                    medios = media
                };

                response.Entity = parametersRegister;
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

        public async Task<BussinesResponse> ObtainRoles()
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _connection.GetDataTable("roles_consultar", ref errorMessage));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var listed = DataTableHelper.ConvertDataTableToList<Rol>(Data);

                response.Entity = listed;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = listed.Count;
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
        public async Task<BussinesResponse> ObtainTypesClasses()
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _connection.GetDataTable("tipos_clases_consultar", ref errorMessage));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var listed = DataTableHelper.ConvertDataTableToList<TypesClass>(Data);

                response.Entity = listed;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = listed.Count;
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
        public async Task<BussinesResponse> ObtainStatesClasses()
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _connection.GetDataTable("estados_clases_consultar", ref errorMessage));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var listed = DataTableHelper.ConvertDataTableToList<StatesClass>(Data);

                response.Entity = listed;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = listed.Count;
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

        //Oscar
        public async Task<BussinesResponse> GetCourses()
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _connection.GetDataTable("cursos_consultar", ref errorMessage));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var listed = DataTableHelper.ConvertDataTableToList<GetCoursesDTO>(Data);

                response.Entity = listed;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = listed.Count;
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

        public async Task<BussinesResponse> PostCourses(PostCoursesDTO postCoursesDTO)
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Datos = new DataTable();

            try
            {

                string errorMessage = string.Empty;

                SqlParameter[] parameters =
                 {
                    new SqlParameter{ParameterName= "nombre", Value=postCoursesDTO.nombre },
                    new SqlParameter{ParameterName= "descripcion", Value= postCoursesDTO.descripcion },
                    new SqlParameter{ParameterName= "valor", Value= postCoursesDTO.valor },
                    new SqlParameter{ParameterName= "cantidad_clases", Value= postCoursesDTO.cantidad_clases }, 
                    new SqlParameter{ParameterName= "estado", Value= postCoursesDTO.estado },
                    new SqlParameter{ParameterName= "usuario_creacion", Value= postCoursesDTO.usuario_creacion  }
                };

                var result = await Task.Run(() => _connection.InsertUpdateDelete("cursos_insertar", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }


                response.Entity = result;
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

        public async Task<BussinesResponse> PutCourses(PutCoursesDTO putCoursesDTO)
        {
            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {

                string errorMessage = string.Empty;

                SqlParameter[] parameters =
                 {
                    new SqlParameter{ParameterName= "consecutivo", Value=putCoursesDTO.consecutivo},
                    new SqlParameter{ParameterName= "nombre", Value=putCoursesDTO.nombre },
                    new SqlParameter{ParameterName= "descripcion", Value= putCoursesDTO.descripcion },
                    new SqlParameter{ParameterName= "cantidad_clases", Value= putCoursesDTO.cantidad_clases },
                    new SqlParameter{ParameterName= "valor", Value= putCoursesDTO.valor },
                    new SqlParameter{ParameterName= "estado", Value= putCoursesDTO.estado },
                    new SqlParameter{ParameterName= "usuario_creacion", Value= putCoursesDTO.usuario_creacion  }
                };

                Data = await Task.Run(() => _connection.GetDataTable("cursos_actualizar", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                var listed = DataTableHelper.ConvertDataTableToList<TypesClass>(Data);

                response.Entity = listed;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = listed.Count;
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
