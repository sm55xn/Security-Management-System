
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Security_Management_Server.Data.Models;
using Security_Management_Server.db;
using Security_Management_Server.Models;

namespace Security_Management_Server.App.SecManageV01.Reports
{
   [Authorize(Roles ="Blogger")]
    [Route("SecManageV01/Reports/[controller]")]
    [ApiController]
    
    public class GetReports : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public GetReports(ApplicationDbContext context,UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _userManager = userManager;
            _httpContextAccessor = httpContextAccessor;
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {
           var idEmp = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
            var Delivereds = await _context.Delivereds.Where(p => p.idEmployee == idEmp && p.isDelivered == false).ToListAsync();
            if ( Delivereds.IsNullOrEmpty() )
            {
                return NotFound();

            }
            List<GetReportModel> list = new List<GetReportModel>();
            foreach (var D in Delivereds)
            {   
                var data = await _context.Reports.Where(p => p.Id == D.IdReport).ToListAsync();
                if (data.IsNullOrEmpty())
                {
                    return NotFound();

                }
                

                var d = data.First();
                    string Name;
                    var name = await _context.Users.FindAsync(d.idUser);
                    if (name == null) { Name = "الإسم غير معروف"; }
                    else { Name = name.Name; }
                    var report = new GetReportModel
                    {
                        id = d.Id,
                        idUser = d.idUser,
                        Name = Name,
                        isAttchments = d.isAttchments,
                        Title = d.Subject,
                        Text = d.Text,
                        date = d.date,
                        location = d.Location,
                        office = d.Office,
                        Type = d.Type,
                        Profile = "no"


                    };
                    list.Add(report);
            }
            return Ok(list);
           
        }
        [HttpGet("Delivered")]
        public async Task<IActionResult> GetDelivered(string idReport)
        {
          var idEmp = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
            var Delivered = await _context.Delivereds.Where(p =>p.IdReport == idReport && p.idEmployee == idEmp && p.isDelivered == false).ToListAsync();
            if (Delivered.IsNullOrEmpty())
            {
                return NotFound();

            }
            var D = Delivered.First();
            D.isDelivered = true;
            await _context.SaveChangesAsync();
            return Ok();

        }

        [HttpGet("isHandle")]
        public async Task<IActionResult> isHandle(string idReport)
        {
            // var idEmp = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
            var handlings = await _context.HandlingReports.Where(p => p.IdReport == idReport && p.office == 100).ToListAsync();
            if (handlings.IsNullOrEmpty())
            {
                var H = new HandleModel
                {
                    IsHandle = 0,
                    nameEmp = "null",
                };
                return Ok(H) ;


            }

            else
            {
                string Name;
                var name = await _context.Users.FindAsync(handlings.First().idEmployee);
                if (name == null) { Name = "الإسم غير معروف"; }
                else { Name = name.Name; }

                if(handlings.First().idEmployee == "idEmp")
                {
                    var H = new HandleModel
                    {
                        IsHandle = 2,
                        nameEmp = Name,
                    };
                    return Ok(H);
                }
                else
                {
                    var H = new HandleModel
                    {
                        IsHandle = 1,
                        nameEmp = Name,
                    };
                    return Ok(H);
                }
                
                
            }
           
        }
        [HttpGet("Handle")]
        public async Task<IActionResult> Handle(string idReport)
        {
             var idEmp = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
            var handlings = await _context.HandlingReports.Where(p => p.IdReport == idReport && p.office == 100).ToListAsync();
            if (handlings.IsNullOrEmpty())
            {
                var handling = new HandlingReports
                {
                    idEmployee = idEmp,
                    IdReport = idReport,
                    office = 100
                };
                await _context.AddAsync(handling);
                await _context.SaveChangesAsync();
                return Ok(handling);


            }
            else
            {
                string Name;
                var name = await _context.Users.FindAsync(handlings.First().idEmployee);
                if (name == null) { Name = "الإسم غير معروف"; }
                else { Name = name.Name; }
                var H = new HandleModel
                {
                    IsHandle = 1,
                    nameEmp = Name,
                };
                return NotFound(H);
            }

        }

        [HttpGet("GetAttachment")]
        public async Task<IActionResult> GetAttachment(string idReport)
        {
            var data = await _context.Attachments.Where(p => p.id_Report == idReport).ToListAsync();
            if (data == null)
            {
                return NotFound();

            }
            List<Attachments> list = new List<Attachments>();
            foreach (var d in data)
            {
                var att = new Attachments
                {
                    Id=d.Id,
                    id_Report=d.id_Report,
                    nameFile = d.nameFile,
                    ext = d.ext
                };
                list.Add(att);
            }
            return Ok(list);
        }

        [HttpGet("GetProfileUser")]
        public async Task<IActionResult> GetProfileUser(string idUser)
        {
           var user = await _context.Users.FindAsync(idUser);
           var userinfo = await _context.accUsers.FindAsync(idUser);
           
            if (user == null || userinfo == null)
            {
                return NotFound();
            }
            var profileUser = new
            {
                id = user.Id,
                name = user.Name,
                gender = user.Gender,
                phone = user.PhoneNumber,
                data = user.DateOfBirth,
                credibility = userinfo.Credibility,
                isIdentity = userinfo.isIdentity,
                reportsCount = userinfo.ReportsCount,
                replysCount = userinfo.ReplysCount,
                reportsFakeCount = userinfo.ReportsFakeCount,

            };
            return Ok(profileUser);

        }
     }
}
