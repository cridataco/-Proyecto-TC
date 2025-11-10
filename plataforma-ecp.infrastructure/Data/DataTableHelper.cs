using System.Data;
using System.Reflection;
using System.Xml.Serialization;

namespace plataforma_ecp.application.Services
{
    public class DataTableHelper
    {
        /// <summary>
        /// Convierte un datatable en una lista de la entidad que querramos
        /// a los nombres que estan en su procedimiento almacenado
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static List<T> ConvertDataTable<T>(DataTable dt)
        {
            List<T> data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                T item = GetItem<T>(row);
                data.Add(item);
            }
            return data;
        }


        public static List<T> ConvertDataTableToList<T>(DataTable dt)
        {
            List<T> data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                T item = GetItemList<T>(row);
                data.Add(item);
            }
            return data;
        }

        public static object ConvertListToXml<T>(List<T> lista, string xmlRootAttribute)
        {
            try
            {
                var serializer = new XmlSerializer(typeof(List<T>), new XmlRootAttribute(xmlRootAttribute));
                using (var stream = new StringWriter())
                {
                    serializer.Serialize(stream, lista);
                    return stream.ToString();
                }
            }
            catch (Exception ex)
            {
                string ee = ex.Message;
                throw;
            }

        }

        /// <summary>
        /// Convierte un datatable en entidad
        /// las columnas deben llamarse igual a las variables de la entidad que queremos que retorne.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static T ConvertEntity<T>(DataTable dt)
        {
            T entitie = default;
            foreach (DataRow row in dt.Rows)
            {
                entitie = GetItem<T>(row);
            }
            return entitie;
        }

        /// <summary>
        /// Retorna una entidad del tipo que le enviemos.
        /// las columnas deben llamarse igual a las variables de la entidad que queremos que retorne.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dr"></param>
        /// <returns></returns>
        private static T GetItem<T>(DataRow dr)
        {
            Type temp = typeof(T);
            T obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
            {
                foreach (PropertyInfo pro in temp.GetProperties())
                {
                    if (pro.Name == column.ColumnName)
                        pro.SetValue(obj, dr[column.ColumnName], null);
                    else
                        continue;
                }
            }
            return obj;
        }

        private static T GetItemList<T>(DataRow dr)
        {
            Type temp = typeof(T);
            T obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
            {
                foreach (PropertyInfo pro in temp.GetProperties())
                {
                    if (pro.Name == column.ColumnName)
                        pro.SetValue(obj, dr[column.ColumnName], null);
                    else
                        continue;
                }
            }
            return obj;
        }
    }
}
