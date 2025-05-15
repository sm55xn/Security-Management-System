using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Security_Management_Server.Helpers;
using Security_Management_Server.Models;
using Security_Management_Server.db;
using Microsoft.EntityFrameworkCore;

namespace Security_Management_Server.Services
{
    public class OService : IOService
    {
        private readonly ApplicationDbContext _context;
    

        public OService(ApplicationDbContext context)
        {
            _context = context;
          
        }
        public async Task<int> DeliveredAsync(string idReport)
        {
            //handel with Delivereds
            var Emplyees = await _context.accEmployees.Where(p => p.flagOffice == 100).ToListAsync();
            if (Emplyees == null)
                return 0;
            foreach(var E in Emplyees)
            {
                var Delivered = new db.Delivereds { 
                idEmployee = E.IdAcc,
                IdReport = idReport,
                isDelivered = false
                
                };
                await _context.Delivereds.AddAsync(Delivered);
                await _context.SaveChangesAsync();
            }
            return 1;

        }
        }
}