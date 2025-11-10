using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.Enumerations
{
    public enum RolType
    {
        Alumno,
        [Description("Profesor Teórico")]
        profesorTeorico,
        [Description("Profesor Práctico")]
        profesorPractico,
        Administrador,
        Secretaria
    }
}
