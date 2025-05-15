
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Security_Management_Server.db;
using Security_Management_Server.Models;
using Security_Management_Server.Services;
using System.IdentityModel.Tokens.Jwt;

namespace Security_Management_Server.App.SecManageV01.Accounts
{
    [Route("SecManageV01/Accounts/[Controller]")]
    [ApiController]
    public class AccEmployee : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IAuthService _authService;
        private readonly UserManager<ApplicationUser> _userManager;


        public AccEmployee(ApplicationDbContext context,IAuthService authService, UserManager<ApplicationUser> userManager)
        {
            _context = context;
            _authService = authService;
            _userManager = userManager;
          
        }
       
        [HttpPost("CreateAcc")]
        public async Task<IActionResult> CreateAccAsync([FromBody] CreateAccModel model)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var result = await _authService.RegisterAsync(model);
            if (!result.IsAuthenticated)
                return BadRequest(result.Message);
            return Ok(result);

        }

        [HttpPost("addRoles")]
        public async Task<IActionResult> addRolesAsync([FromBody] AddRoleModel model)
        {
            var Emp = await _userManager.FindByIdAsync(model.UserId);
            await _userManager.AddToRoleAsync(Emp, model.Role);
            return Ok();
        }
    }
}
