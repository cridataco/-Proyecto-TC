using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.infrastructure.Data
{
    public class BaseRepository
    {
        private string _cadenaWebApi = string.Empty;
        public BaseRepository(string cadenaWebApi)
        {
            _cadenaWebApi = cadenaWebApi;
        }
        public string ConnectionWebApi()
        {
            return _cadenaWebApi;
        }
        public bool HuboError(string error)
        {
            return !string.IsNullOrWhiteSpace(error);
        }
    }
}
