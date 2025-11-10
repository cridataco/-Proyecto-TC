using plataforma_ecp.application.Interfaces;
using plataforma_ecp.domain.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.application.Services
{
    public class UriService : IUriService
    {
        private readonly string _baseUri;
        private readonly string _queryString;

        public UriService(string  baseUri)
        {
            _baseUri = baseUri;
        }

        public Uri GetPostPaginationUri(UsuarioQueryFilter filter)
        {
            throw new NotImplementedException();
        }

        //public Uri GetUserPaginationUri(UsuarioQueryFilter filter)
        //{
          
        //    string baseUrl = $"{_baseUri}";

        //    return new Uri(baseUrl);
        //}
    }
}
