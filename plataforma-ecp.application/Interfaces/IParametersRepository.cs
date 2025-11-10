using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plataforma_ecp.application.Interfaces
{
    public interface IParametersRepository
    {
        Task<BussinesResponse> ParametersRegister();
        Task<BussinesResponse> ObtainRegions();
        Task<BussinesResponse> ObtainCommunes(int idRegion);
        Task<BussinesResponse> ObtainRoles();
        Task<BussinesResponse> ObtainTypesClasses();
        Task<BussinesResponse> ObtainStatesClasses();

        //Oscar
        Task<BussinesResponse> GetCourses();
        Task<BussinesResponse> PostCourses(PostCoursesDTO postCoursesDTO);
        Task<BussinesResponse> PutCourses(PutCoursesDTO putCoursesDTO);
    }
}
