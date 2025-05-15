using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Security_Management_Server.Models;

namespace Security_Management_Server.App.SecMobileV01.Auth
{
    [Route("SecMobileV01/[Controller]")]
    [ApiController]
    public class img : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
       public img(ApplicationDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }
        [HttpGet("GetImage")]
        public async Task<IActionResult> GetImage(string filename)
        {
            Byte[] b = System.IO.File.ReadAllBytes("D:\\ASP.NET_Core\\data\\AttachmentsForReply\\" + filename);
            return File(b, "image/jpeg");
        }
        [HttpGet("GetProfile")]
        public async Task<IActionResult> GetProfile(string filename)
        {
            Byte[] b = System.IO.File.ReadAllBytes("D:\\ASP.NET_Core\\data\\Profile\\" + filename);
            return File(b, "image/jpeg");
        }

        [HttpGet("GetImgAttachment")]
        public async Task<IActionResult> GetImgAttachment(string idReport,string id)
        {
            Byte[] b = System.IO.File.ReadAllBytes("D:\\ASP.NET_Core\\data\\Attachment\\" + idReport+"\\"+id);
            return File(b, "image/jpeg");
        }

        [HttpGet("GetImgUpdate")]
        public async Task<IActionResult> GetImgUpdate(string id)
        {
            Byte[] b = System.IO.File.ReadAllBytes("D:\\ASP.NET_Core\\data\\AttachmentUpdatas\\" + id+".jpg");
            return File(b, "image/jpeg");
        }
    }
}
