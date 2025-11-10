using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.DTOs
{
	public class EstudiantesActivosDTO
	{
        public long id_curso_estudiante { get; set; }
        public string estudiante { get; set; }
        public int cantidad_clases { get; set; }
    }
}
