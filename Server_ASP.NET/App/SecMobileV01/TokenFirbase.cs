using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Security_Management_Server.Models;

namespace Security_Management_Server.App.SecMobileV01.Auth
{
    [Authorize(Roles ="User")]
    [Route("SecMobileV01/[Controller]")]
    [ApiController]
    public class TokenFirebase : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
       public TokenFirebase(ApplicationDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }
        [HttpGet]
        public async Task<IActionResult> _setTokenFirebase(string token)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
           string id = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
           
           var _token = await _context.firebaseTokens.FindAsync(id);
           if (_token == null)
            {
                var _fb = new db.FirebaseTokens
                {
                    Id = id,
                    Token = token

                };

                await _context.firebaseTokens.AddAsync(_fb);
                await _context.SaveChangesAsync();
                return Ok();

            }
           else
            {
               _token.Token = token;
                await _context.SaveChangesAsync();
                return Ok();
            }
            
            
        }
    }
}
