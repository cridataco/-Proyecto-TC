using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.infrastructure.Data
{
    public class DataBaseResponse
    {
        public bool success { get; set; }
        public string ?message { get; set; }
        public object ?data { get; set; }
    }
}
