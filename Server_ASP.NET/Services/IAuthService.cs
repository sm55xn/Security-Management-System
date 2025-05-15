using System.Threading.Tasks;
using Security_Management_Server.Models;
using Security_Management_Server.db;
using System.IdentityModel.Tokens.Jwt;

namespace Security_Management_Server.Services
{
    public interface IAuthService
    {
        Task<AuthModel> RegisterAsync(CreateAccModel model);
        Task<AuthModel> LoginAsync(PhoneNumber model);
        Task<AuthModel> GetTokenAsync(TokenRequestModel model);
        Task<string> AddRoleAsync(AddRoleModel model);
        Task<JwtSecurityToken> CreateJwtToken(ApplicationUser user);
    }
}