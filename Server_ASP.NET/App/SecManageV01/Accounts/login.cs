using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

using Security_Management_Server.db;
using Security_Management_Server.Models;
using Security_Management_Server.Services;
using System.IdentityModel.Tokens.Jwt;

namespace Security_Management_Server.App.SecManageV01.Accounts
{
    [Route("SecManageV01/Accounts/[Controller]")]
    [ApiController]
    public class Login : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IAuthService _authService;
        private readonly UserManager<ApplicationUser> _userManager;

        public Login(ApplicationDbContext context,IAuthService authService, UserManager<ApplicationUser> userManager)
        {
            _context = context;
            _authService = authService;
            _userManager = userManager;
        }


        [HttpPost]
        public async Task<IActionResult> LoginAsync([FromBody] LoginModel model)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            AuthModel authModel = new AuthModel();
            var user = await _userManager.FindByNameAsync(model.username);
            if (user is null || !await _userManager.CheckPasswordAsync(user, model.password))
            {
                authModel.Message = "Username or Password is incorrect!";
                return BadRequest(authModel);
            }
            var jwtSecurityToken = await _authService.CreateJwtToken(user);
            var rolesList = await _userManager.GetRolesAsync(user);

            authModel.IsAuthenticated = true;
            authModel.Token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
            authModel.Username = user.UserName;
            authModel.ExpiresOn = jwtSecurityToken.ValidTo;
            authModel.Roles = rolesList.ToList();
            return Ok(authModel);
        }

    }
}
