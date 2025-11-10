using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace plataforma_ecp.domain.Entities
{
    public class Region 
    {
         
        [Key]
        public int id { get; set; }
        public string? region { get; set; }
        public string? abreviatura { get; set; }
        public string? capital { get; set; }

        public virtual  User? Usuario { get; set; }
    }
}
