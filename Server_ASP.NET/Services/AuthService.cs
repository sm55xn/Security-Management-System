using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Security_Management_Server.Helpers;
using Security_Management_Server.Models;
using Security_Management_Server.db;

namespace Security_Management_Server.Services
{
    public class AuthService : IAuthService
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly JWT _jwt;

        public AuthService(UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager, IOptions<JWT> jwt,ApplicationDbContext context)
        {
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
            _jwt = jwt.Value;
        }
        public async Task<AuthModel> LoginAsync(PhoneNumber model)
        {
            var US = await _userManager.FindByNameAsync(model.phone);
            if (US is not null && await _userManager.IsPhoneNumberConfirmedAsync(US) is true)
                return new AuthModel { Message = "Phone Number is already registered!" };
            ;
            if (US is not null && await _userManager.IsPhoneNumberConfirmedAsync(US) is false)
            { 
                return new AuthModel { Message = "Phone Number is already registered!" };

            }
            else
            {
                var user = new ApplicationUser
                {
                    DateOfJoin = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    UserName = model.phone,
                    PhoneNumber = model.phone,
                    Name = "noName",
                };

                var result = await _userManager.CreateAsync(user);

                if (!result.Succeeded)
                {
                    var errors = string.Empty;

                    foreach (var error in result.Errors)
                        errors += $"{error.Description},";

                    return new AuthModel { Message = errors };
                }

                await _userManager.AddToRoleAsync(user, "User");

                var jwtSecurityToken = await CreateJwtToken(user);

                return new AuthModel
                {
                    Email = user.PhoneNumber,
                    ExpiresOn = jwtSecurityToken.ValidTo,
                    IsAuthenticated = true,
                    Roles = new List<string> { "User" },
                    Token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken),
                    Username = user.UserName
                };
            }
        }
        public async Task<AuthModel> RegisterAsync(CreateAccModel model)
        {
            if (await _userManager.FindByNameAsync(model.Username) is not null)
                return new AuthModel { Message = "Username is already registered!" };

            var user = new ApplicationUser
            {

                UserName = model.Username,
                Name = model.Name,
                IsEmployee = true,
                DateOfJoin = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                Gender = model.Gender,
               
               

            };

            var result = await _userManager.CreateAsync(user, model.Password);

            var Acc = new db.AccEmployees
            {
                IdAcc = user.Id,
                flagOffice = model.flagOffice,
                salary = 60000
                
            };
            await _context.accEmployees.AddAsync(Acc);
            await _context.SaveChangesAsync();

            if (!result.Succeeded)
            {
                var errors = string.Empty;

                foreach (var error in result.Errors)
                    errors += $"{error.Description},";

                return new AuthModel { Message = errors };
            }

          //  await _userManager.AddToRoleAsync(user, "User");
         //  var jwtSecurityToken = await CreateJwtToken(user);

            return new AuthModel
            {
                Email = user.Email,
              //  ExpiresOn = jwtSecurityToken.ValidTo,
                IsAuthenticated = true,
                Roles = new List<string> { "User" },
              //  Token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken),
                Username = user.UserName
            };
        }

        public async Task<AuthModel> GetTokenAsync(TokenRequestModel model)
        {
            var authModel = new AuthModel();

            var user = await _userManager.FindByEmailAsync(model.Email);

            if (user is null || !await _userManager.CheckPasswordAsync(user, model.Password))
            {
                authModel.Message = "Email or Password is incorrect!";
                return authModel;
            }

            var jwtSecurityToken = await CreateJwtToken(user);
            var rolesList = await _userManager.GetRolesAsync(user);

            authModel.IsAuthenticated = true;
            authModel.Token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
            authModel.Email = user.Email;
            authModel.Username = user.UserName;
            authModel.ExpiresOn = jwtSecurityToken.ValidTo;
            authModel.Roles = rolesList.ToList();

            return authModel;
        }

        public async Task<string> AddRoleAsync(AddRoleModel model)
        {
            var user = await _userManager.FindByIdAsync(model.UserId);

            if (user is null || !await _roleManager.RoleExistsAsync(model.Role))
                return "Invalid user ID or Role";

            if (await _userManager.IsInRoleAsync(user, model.Role))
                return "User already assigned to this role";

            var result = await _userManager.AddToRoleAsync(user, model.Role);

            return result.Succeeded ? string.Empty : "Sonething went wrong";
        }

        public async Task<JwtSecurityToken> CreateJwtToken(ApplicationUser user)
        {
            var userClaims = await _userManager.GetClaimsAsync(user);
            var roles = await _userManager.GetRolesAsync(user);
            var roleClaims = new List<Claim>();

            foreach (var role in roles)
                roleClaims.Add(new Claim("roles", role));

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.UserName),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim("uid", user.Id)
            }
            .Union(userClaims)
            .Union(roleClaims);

            var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwt.Key));
            var signingCredentials = new SigningCredentials(symmetricSecurityKey, SecurityAlgorithms.HmacSha256);

            var jwtSecurityToken = new JwtSecurityToken(
                issuer: _jwt.Issuer,
                audience: _jwt.Audience,
                claims: claims,
                expires: DateTime.Now.AddDays(_jwt.DurationInDays),
                signingCredentials: signingCredentials);

            return jwtSecurityToken;
        }
    }
}