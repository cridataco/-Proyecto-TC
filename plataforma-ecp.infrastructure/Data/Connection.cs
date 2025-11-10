using plataforma_ecp.domain;
using System.Data;
using System.Data.SqlClient;

namespace plataforma_ecp.infrastructure.Data
{
    internal class Connection
    {
        protected readonly string connection = string.Empty;

        public Connection(string connectioString)
        {
            // connection = Encrypta.DesencriptarCandena(connectioString);
            connection = connectioString;
        }


        /// <summary>
        /// Metodo para obtener informacion
        /// </summary>
        /// <param name="procedimiento"></param>
        /// <param name="mensajeDeError"></param>
        /// <param name="parametros"></param>
        /// <returns>DataTable</returns>
        public DataTable GetDataTable(string procedimiento, ref string mensajeDeError, SqlParameter[] parametros = null)
        {
            Console.WriteLine("Conectando a la base de datos con la cadena: " + connection);
            DataTable datos = new DataTable();

            using (var sqlConnection = new SqlConnection(connection))
            using (var sqlCommand = new SqlCommand(procedimiento, sqlConnection))
            {
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.CommandTimeout = 3600;

                if (parametros != null)
                {
                    sqlCommand.Parameters.AddRange(parametros);
                }

                try
                {
                    sqlConnection.Open();
                    using (var adapter = new SqlDataAdapter(sqlCommand))
                    {
                        adapter.Fill(datos);
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine("SqlException Message: " + ex.Message);
                    Console.WriteLine("Number: " + ex.Number);
                    Console.WriteLine("State: " + ex.State);
                    Console.WriteLine("ErrorCode: " + ex.ErrorCode);
                    Console.WriteLine("StackTrace: " + ex.StackTrace);

                    foreach (SqlError error in ex.Errors)
                    {
                        Console.WriteLine($"SQL Error: {error.Message}, Line: {error.LineNumber}, Server: {error.Server}, Procedure: {error.Procedure}");
                    }
                }
                catch (Exception ex)
                {
                    mensajeDeError = ex.Message;
                    Console.WriteLine("Tipo de excepción: " + ex.GetType().FullName);
                    Console.WriteLine("Mensaje: " + ex.Message);
                    Console.WriteLine("StackTrace: " + ex.StackTrace);

                    if (ex.InnerException != null)
                    {
                        Console.WriteLine("InnerException: " + ex.InnerException.GetType().FullName);
                        Console.WriteLine("InnerException mensaje: " + ex.InnerException.Message);
                    }
                }
            }

            return datos;
        }

        public DataSet GetDataSet(string procedimiento, ref string mensajeDeError, SqlParameter[] parametros = null)
        {
            DataSet ds = new DataSet();

            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(procedimiento, connection);

            try
            {
                sqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlDataAdapter.SelectCommand.CommandTimeout = 3600;

                if (parametros != null)
                {
                    sqlDataAdapter.SelectCommand.Parameters.AddRange(parametros);
                }
                sqlDataAdapter.SelectCommand.Connection.Open();
                sqlDataAdapter.Fill(ds);
            }
            catch (Exception excepcion)
            {
                mensajeDeError = excepcion.Message;
            }
            finally
            {
                sqlDataAdapter.SelectCommand.Connection.Close();
                sqlDataAdapter.SelectCommand.Dispose();
            }

            return ds;
        }

        public bool InsertUpdateDelete(string procedimiento, ref string mensajeDeError, SqlParameter[] parametros = null)
        {
            bool result = false;

            using (SqlConnection conn = new SqlConnection(connection))
            using (SqlCommand cmd = new SqlCommand(procedimiento, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 3600;

                if (parametros != null)
                {
                    cmd.Parameters.AddRange(parametros);
                }

                try
                {
                    conn.Open();
                    result = cmd.ExecuteNonQuery() > 0;
                }
                catch (Exception ex)
                {
                    mensajeDeError = ex.Message;
                }
            }

            return result;
        }
    }
}
