using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Security_Management_Server.Models;

namespace Security_Management_Server.App.SecMobileV01.Auth
{
    [Authorize(Roles ="User")]
    [Route("SecMobileV01/Auth/[Controller]")]
    [ApiController]
    public class Profile : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
       public Profile(ApplicationDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }
        [HttpPost("addProfile")]
        public async Task<IActionResult> _addProfile([FromForm] ProfileModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
           string id = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
           var user = await _context.Users.FindAsync(id);
            if (user == null)
                return NotFound();
            var _token = await _context.firebaseTokens.FindAsync(id);
            if (_token == null)
            {
                var _fb = new db.FirebaseTokens
                {
                    Id = id,
                    Token = model.TokenFirebase

                };
                await _context.firebaseTokens.AddAsync(_fb);
                await _context.SaveChangesAsync();
            }
            else
            {
                _token.Token = model.TokenFirebase;
                await _context.SaveChangesAsync();
            }
            user.Name = model.name;
            user.Gender = model.Gender;
            user.DateOfBirth = model.DateOfBirth;
            await _context.SaveChangesAsync();

            if (model.Profile != null)
            {
                var folder = Directory.CreateDirectory("D:\\ASP.NET_Core\\data\\Profile");
                var filePath = Path.Combine($"{folder}", $"{user.Id}" + ".jpg");
                using var stream = System.IO.File.Create(filePath);
                { await model.Profile.CopyToAsync(stream); }
            }
            return Ok();
        }
    }
}
