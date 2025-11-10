using plataforma_ecp.application.Services;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;

namespace plataforma_ecp.infrastructure.Data
{
    public class AppKeys
    {
        #region Singleton
        /// <summary>
        /// Gets the instance.
        /// </summary>
        /// <value>The instance.</value>
        public static AppKeys Instance
        {
            get
            {
                lock (Padlock)
                {
                    return _instance ?? (_instance = new AppKeys());
                }
            }
        }

        private static AppKeys _instance;
        private static readonly object Padlock = new object();
        #endregion Singleton

        public string? _cadenaConexion { get; set; }
        public List<keysList> keysLists { get; set; }

        public  void setcadena(string cadena)
        {
            _cadenaConexion = cadena;
        }

        public  void obtenerKeysApp()
        {
            try
            {
                string mensajeDeError = string.Empty;
                Connection connection = new Connection(_cadenaConexion);
                var datos = connection.GetDataTable("app_keys_consultar", ref mensajeDeError);
                keysLists = DataTableHelper.ConvertDataTable<keysList>(datos);
                Console.WriteLine("Se consultaron" + keysLists.Count + " llaves de base de datos");
            }
            catch (Exception ex)
            {

                Console.WriteLine("Error en consulta de llaves de base de datos " + ex.Message);
            }
            

        }

    }
}
