using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.domain.Entities
{
    public class BussinesResponse
    {
        public int Total { get; set; }
        public bool Successful { get; set; }
        public string ?Error { get; set; }
        public object ?Entity { get; set; }

    }
}
