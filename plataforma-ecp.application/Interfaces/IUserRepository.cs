using plataforma_ecp.domain.DTOs;
using plataforma_ecp.domain.Entities;

namespace plataforma_ecp.application.Interfaces
{
    public interface IUserRepository
    {
        Task<BussinesResponse> GetUserLogin(LoginDto credentials);
        Task<BussinesResponse> ObtainUsers(UsuarioQueryFilter filter);
        Task<BussinesResponse> GetUserDetails(int consecutiveUser);
        Task<BussinesResponse> GetCourseStudentParameterUser(int idStudent);
        Task<BussinesResponse> InsertUser(AddUserDTO user);
        Task<BussinesResponse> UpdateUser(int consecutive, UpdateUsuarioDto user);
        Task<BussinesResponse> DeleteUser(int consecutive, string userDelete);
        Task<BussinesResponse> ValidateRun(string run);
        Task<BussinesResponse> ToggleAccess(ToggleAccessDto dto);
    }
}
