using System.Threading.Tasks;
using Security_Management_Server.Models;
using Security_Management_Server.db;
using System.IdentityModel.Tokens.Jwt;

namespace Security_Management_Server.Services
{
    public interface IOService
    {
        Task<int> DeliveredAsync(string idReport);
       
    }
}