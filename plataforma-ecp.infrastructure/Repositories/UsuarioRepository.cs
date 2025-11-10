using plataforma_ecp.application.Interfaces;
using plataforma_ecp.application.Services;
using plataforma_ecp.domain;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using plataforma_ecp.infrastructure.Data;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;

namespace plataforma_ecp.infrastructure.Repositories
{
    public class UsuarioRepository : IUserRepository
    {
        private readonly Connection _conexion;

        public UsuarioRepository()
        {
            _conexion = new Connection(AppKeys.Instance._cadenaConexion);
        }

        public async Task<BussinesResponse> GetUserLogin(LoginDto credenciales)
        {

            BussinesResponse response = new BussinesResponse();
            DataSet Data = new DataSet();
            try
            {
                SqlParameter[] parameters =
                {
                    new SqlParameter{ParameterName= "run", Value=credenciales.run},
                    new SqlParameter{ParameterName= "password", Value=credenciales.password}
                };

                string mensajeDeError = string.Empty;
                Data = await Task.Run(() => _conexion.GetDataSet("usuarios_consultar_login", ref mensajeDeError, parameters));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    response.Successful = false;
                    response.Error = mensajeDeError;
                    return response;
                }
                var listadoUsuarios = DataTableHelper.ConvertDataTable<LoginUsuarioDto>(Data.Tables[0]);
                listadoUsuarios.ForEach(x =>
                {
                    x.roles = DataTableHelper.ConvertDataTable<Rol>(Data.Tables[1]);
                    // x.arbol_permisos = Data.Tables[2].Rows[0][0].ToString();
                });


                var count = listadoUsuarios.Count();

                response.Entity = count > 0 ? listadoUsuarios.First() : null;
                response.Successful = true;
                response.Error = count > 0 ? string.Empty : "Credenciales incorrectas";
                response.Total = count;
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
        public async Task<BussinesResponse> GetPermissionsApplicationUser(int consecutiveUser)
        {

            BussinesResponse response = new BussinesResponse();
            DataSet Data = new DataSet();

            try
            {
                SqlParameter[] parameters =
                {
                    new SqlParameter{ParameterName= "run", Value=consecutiveUser }

                };

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _conexion.GetDataSet("usuarios_consultar_login", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }
                var listUsers = DataTableHelper.ConvertDataTable<LoginUsuarioDto>(Data.Tables[0]);
                var count = listUsers.Count();

                response.Entity = count > 0 ? listUsers.First() : null;
                response.Successful = true;
                response.Error = count > 0 ? string.Empty : "Credenciales incorrectas";
                response.Total = count;
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
        public async Task<BussinesResponse> ObtainUsers(UsuarioQueryFilter filter)
        {

            BussinesResponse response = new BussinesResponse();
            DataSet Data = new DataSet();

            try
            {
                SqlParameter[] parameters =
                {
                    new SqlParameter{ParameterName= "@PageNumber", Value=filter.PageNumber==0 ? DBNull.Value:filter.PageNumber},
                    new SqlParameter{ParameterName= "@ItemsPerPage", Value= filter.PageSize==0 ? DBNull.Value:filter.PageSize },
                    new SqlParameter{ParameterName= "@IdRol", Value= filter.idRol==0 ? DBNull.Value:filter.idRol },
                    new SqlParameter{ParameterName= "@Texto", Value= filter.text=="" ? DBNull.Value:filter.text }
                };

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _conexion.GetDataSet("usuarios_consultar_datos_usuarios", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }
                var total = Data.Tables[0].Rows[0][0];
                var listUsers = DataTableHelper.ConvertDataTable<ListUsuariosDTO>(Data.Tables[1]);

                response.Entity = listUsers;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = (int)total;
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
        public async Task<BussinesResponse> GetUserDetails(int consecutiveUser)
        {

            BussinesResponse response = new BussinesResponse();
            DataSet Data = new DataSet();

            try
            {
                SqlParameter[] parameters =
                {
                    new SqlParameter{ParameterName= "consecutivo", Value=consecutiveUser }
                };

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _conexion.GetDataSet("usuarios_consultar_datos_usuarios_detalle", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }
                var usersList = DataTableHelper.ConvertDataTable<User>(Data.Tables[0]);
                var rolesList = DataTableHelper.ConvertDataTable<RolDTO>(Data.Tables[1]);
                var locationsList = DataTableHelper.ConvertDataTable<LocationDTO>(Data.Tables[2]);

                usersList.ForEach(u =>
                {
                    u.roles = rolesList.Where(x => x.id_usuario == u.consecutivo).ToList();
                    u.sedes = locationsList.Where(x => x.id_usuario == u.consecutivo).ToList();
                });

                response.Entity = usersList;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = usersList.Count();
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
        public async Task<BussinesResponse> GetCourseStudentParameterUser(int idEstudiante)
        {

            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {
                SqlParameter[] parameters =
                {
                    new SqlParameter{ParameterName= "@id_estudiante", Value=idEstudiante }

                };

                string errorMessage = string.Empty;
                Data = await Task.Run(() => _conexion.GetDataTable("curso_estudiante_consultar_id_usuario", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }
                var list = DataTableHelper.ConvertDataTable<CourseStudentUserDto>(Data);
                var count = list.Count();

                response.Entity = list;
                response.Successful = true;
                response.Error = string.Empty;
                response.Total = count;
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
        public async Task<BussinesResponse> InsertUser(AddUserDTO user)
        {

            BussinesResponse response = new BussinesResponse();
            bool result = false;

            try
            {
                string errorMessage = string.Empty;
                Int64 id_usuario_creado = 0;
                SqlParameter[] parameters =
                {
                    new SqlParameter {ParameterName= "nombre", Value=user.nombre },
                    new SqlParameter {ParameterName= "apellido", Value=user.apellido},
                    new SqlParameter {ParameterName= "run", Value=user.run},
                    new SqlParameter {ParameterName= "id_genero", Value=user.id_genero},
                    new SqlParameter {ParameterName= "fecha_nacimiento", Value=user.fecha_nacimiento},
                    new SqlParameter {ParameterName= "telefono", Value=user.telefono},
                    new SqlParameter {ParameterName= "email", Value=user.email },
                    new SqlParameter {ParameterName= "direccion", Value=user.direccion },
                    new SqlParameter {ParameterName= "direccion_detalle", Value=user.direccion_detalle },
                    new SqlParameter {ParameterName= "id_comuna", Value=user.id_comuna },
                    new SqlParameter {ParameterName= "oficio", Value=user.oficio},
                    new SqlParameter {ParameterName= "medio_enterar", Value=user.medio_enterar },


                    new SqlParameter {ParameterName= "medicamentos_alergias", Value=user.medicamentos_alergias },
                    new SqlParameter {ParameterName= "embarazo", Value=user.embarazo },
                    new SqlParameter {ParameterName= "meses_embarazo", Value=user.meses_embarazo },
                    new SqlParameter {ParameterName= "observaciones_especiales", Value=user.observaciones_especiales },
                    new SqlParameter {ParameterName= "examen_visual", Value=user.examen_visual },

                    new SqlParameter {ParameterName= "id_rol", Value= string.Join(",",user.roles)  },
                    new SqlParameter {ParameterName= "id_sede", Value=string.Join(",",user.sedes) },
                    new SqlParameter {ParameterName= "usuario_creacion", Value=user.usuario_creacion},

                    new SqlParameter {ParameterName= "id_usuario_creado", Direction=ParameterDirection.Output , DbType= DbType.Int64 },

                };
 

                result = await Task.Run(() => _conexion.InsertUpdateDelete("usuarios_insertar_datos_usuarios", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }
                id_usuario_creado= Convert.ToInt64(parameters.First(p => p.ParameterName == "id_usuario_creado").Value);
                response.Entity = id_usuario_creado;
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
        public async Task<BussinesResponse> UpdateUser(int consecutive, UpdateUsuarioDto user)
        {

            BussinesResponse response = new BussinesResponse();
            bool result = false;

            try
            {
                string mensajeDeError = string.Empty;

                SqlParameter[] parameters =
                {
                    new SqlParameter {ParameterName= "consecutivo", Value=consecutive },
                    new SqlParameter {ParameterName= "nombre", Value=user.nombre },
                    new SqlParameter {ParameterName= "apellido", Value=user.apellido},
                    new SqlParameter {ParameterName= "id_genero", Value=user.id_genero},
                    new SqlParameter {ParameterName= "fecha_nacimiento", Value=user.fecha_nacimiento},
                    new SqlParameter {ParameterName= "telefono", Value=user.telefono},
                    new SqlParameter {ParameterName= "email", Value=user.email },
                    new SqlParameter {ParameterName= "direccion", Value=user.direccion },
                    new SqlParameter {ParameterName= "direccion_detalle", Value=user.direccion_detalle },
                    new SqlParameter {ParameterName= "id_comuna", Value=user.id_comuna },
                    new SqlParameter {ParameterName= "oficio", Value=user.oficio},
                    new SqlParameter {ParameterName= "medio_enterar", Value=user.medio_enterar },

                    new SqlParameter {ParameterName= "medicamentos_alergias", Value=user.medicamentos_alergias },
                    new SqlParameter {ParameterName= "embarazo", Value=user.embarazo },
                    new SqlParameter {ParameterName= "meses_embarazo", Value=user.meses_embarazo },
                    new SqlParameter {ParameterName= "observaciones_especiales", Value=user.observaciones_especiales },
                    new SqlParameter {ParameterName= "examen_visual", Value=user.examen_visual },

                    new SqlParameter {ParameterName= "id_rol", Value= string.Join(",",user.roles)  },
                    new SqlParameter {ParameterName= "id_sede", Value=string.Join(",",user.sedes) },
                    new SqlParameter {ParameterName= "usuario_modificacion", Value=user.usuario_modificacion }
                };
                result = await Task.Run(() => _conexion.InsertUpdateDelete("usuarios_actualizar_datos_usuarios", ref mensajeDeError, parameters));

                if (!string.IsNullOrWhiteSpace(mensajeDeError))
                {
                    response.Successful = false;
                    response.Error = mensajeDeError;
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
        public async Task<BussinesResponse> DeleteUser(int consecutive, string userDelete)
        {

            BussinesResponse response = new BussinesResponse();
            bool result = false;

            try
            {
                string errorMessage = string.Empty;

                SqlParameter[] parameters =
                {
                    new SqlParameter {ParameterName= "consecutivo", Value=consecutive},
                    new SqlParameter {ParameterName= "usuario_modificacion", Value=userDelete},
                };
                result = await Task.Run(() => _conexion.InsertUpdateDelete("usuarios_eliminar_datos_usuarios", ref errorMessage, parameters));

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
        public async Task<BussinesResponse> ValidateRun(string run)
        {

            BussinesResponse response = new BussinesResponse();
            DataTable Data = new DataTable();

            try
            {
                string errorMessage = string.Empty;

                SqlParameter[] parameters =
                {
                    new SqlParameter {ParameterName= "run", Value=run}
                };
                Data = await Task.Run(() => _conexion.GetDataTable("usuarios_validar_run", ref errorMessage, parameters));

                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                response.Entity = null;
                if (Data.Rows.Count > 0)
                {
                    response.Entity = new { pago_aprobado = (bool)Data.Rows[0][0] };
                    response.Total = 1;
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

        public async Task<BussinesResponse> ToggleAccess(ToggleAccessDto dto)
        {
            var response = new BussinesResponse();
            try
            {
                string errorMessage = string.Empty;
                int filasAfectadas = 0;

                SqlParameter[] parameters = {
            new SqlParameter { ParameterName = "consecutivo", Value = dto.consecutivo },
            new SqlParameter { ParameterName = "acceso_habilitado", Value = dto.acceso_habilitado },
            new SqlParameter { ParameterName = "usuario_modificacion", Value = dto.usuario_modificacion },
            new SqlParameter { ParameterName = "resultado", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Output }
        };

                bool ok = await Task.Run(() =>
                    _conexion.InsertUpdateDelete(
                        "usuarios_cambiar_acceso_habilitado",
                        ref errorMessage,
                        parameters
                    )
                );

                if (!string.IsNullOrEmpty(errorMessage))
                {
                    response.Successful = false;
                    response.Error = errorMessage;
                    return response;
                }

                filasAfectadas = Convert.ToInt32(parameters.First(p => p.ParameterName == "resultado").Value);
                response.Successful = filasAfectadas == 1;
                response.Entity = filasAfectadas;        
                response.Error = response.Successful ? string.Empty : "No se actualizó ninguna fila.";
                return response;
            }
            catch (Exception ex)
            {
                return new BussinesResponse
                {
                    Successful = false,
                    Error = ex.Message,
                    Entity = null
                };
            }
        }
    }
}
