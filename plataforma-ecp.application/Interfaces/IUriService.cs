using plataforma_ecp.domain.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.application.Interfaces
{
    public interface IUriService
    {
        Uri GetPostPaginationUri(UsuarioQueryFilter filter);
    }
}
