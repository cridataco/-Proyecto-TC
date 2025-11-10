using Microsoft.IdentityModel.Tokens;
using plataforma_ecp.domain.DTOs;
using plataforma_ecp.infrastructure.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace plataforma_ecp.api.JWTHelper
{
    public class JWT
    {
        public string GenerateToken(LoginUsuarioDto loginUsuarios)
        {
            try
            {
                var symetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(AppKeys.Instance.keysLists.FirstOrDefault(x => x.nombre == "JWTKey").valor));
                var signingCredentials = new SigningCredentials(symetricSecurityKey, SecurityAlgorithms.HmacSha256);
                var header = new JwtHeader(signingCredentials);

                //Claims
                var claims = new List<Claim> {
                new Claim(JwtRegisteredClaimNames.Sub, AppKeys.Instance.keysLists.FirstOrDefault(x => x.nombre == "JWTSubject").valor),
                 new Claim(JwtRegisteredClaimNames.Jti, new Guid().ToString()),
                 new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
                 new Claim("consecutivo", loginUsuarios.consecutivo.ToString()),
                 new Claim("nombre",loginUsuarios.nombre),
                 new Claim("apellido",loginUsuarios.apellido)

                };
                foreach (var userRole in loginUsuarios.roles)
                {
                    claims.Add(new Claim(ClaimTypes.Role, userRole.nombre));
                }

                //Payload
                var payload = new JwtPayload
                (

                    AppKeys.Instance.keysLists.FirstOrDefault(x => x.nombre == "JWTIssuer").valor,
                    AppKeys.Instance.keysLists.FirstOrDefault(x => x.nombre == "JWTAudience").valor,
                    claims,
                    DateTime.Now,
                    DateTime.UtcNow.AddMinutes(60) //Aqui
                );

                var token = new JwtSecurityToken(header, payload);

                return new JwtSecurityTokenHandler().WriteToken(token);
            }
            catch (Exception ex)
            {

                throw new Exception(ex.Message);
            }

        }

    }
}
