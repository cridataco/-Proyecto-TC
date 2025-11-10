using plataforma_ecp.domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.DTOs
{
    public class PermissionsDTO
    {

    }

    public class GetModulosDTO
    {
        public int consecutivo_modulo { get; set; }
        public string nombre { get; set; }
        public string estado { get; set; }
    }
    public class AddModulosDTO
    {
        public string nombre { get; set; }
        public string estado { get; set; }
    }
    public class GetModulosRutasDTO
    {
        public int consecutivo_modulo_ruta { get; set; }
        public int id_modulo { get; set; }
        public string sub_ruta { get; set; }

    }
    public class AddModulosRutasDTO
    {
        public int id_modulo { get; set; }
        public string sub_ruta { get; set; }
    }
    public class GetModulosRutasAccionesDTO : Auditoria
    {

        public int consecutivo_modulo_ruta_accion { get; set; }
        public int id_modulo_ruta { get; set; }
        public string accion { get; set; }
        public string codigo { get; set; }
        public bool estado { get; set; }

    }
    public class AddModulosRutasAccionesDTO : Auditoria
    {
        public int id_modulo_ruta { get; set; }
        public string accion { get; set; }
        public string codigo { get; set; }
        public bool estado { get; set; }
    }
    public class GetRolesPermisos
    {
        public string modulo { get; set; }
        public string ruta { get; set; }
        public string accion { get; set; }
        public bool acceso { get; set; }
    }
}
