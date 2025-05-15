using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Security_Management_Server.Models;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using System;
using Security_Management_Server.Data;
using Security_Management_Server.Data.Models;
using Microsoft.EntityFrameworkCore;
using Security_Management_Server.Services;
using Security_Management_Server.db;


namespace Security_Management_Server.App.SecMobileV01.Report
{
    [Authorize(Roles= "User")]
    [Route("SecMobileV01/Report/[Controller]")]
    [ApiController]
    public class Report : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IOService _oService;
        public Report(ApplicationDbContext context , IHttpContextAccessor httpContextAccessor, IOService oService)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
            _oService = oService;
        }
        [HttpPost("addReport")]
        public async Task<IActionResult> create([FromBody] ReportModel report)
        {
            // handel with Reports
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var _report = new db.Reports
            {
                Id = Guid.NewGuid().ToString(),
               idUser =_httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value,
               //  idUser = "71f3b0bf-7ad4-4392-9f36-f3e7512bb51a",
                Subject = report.Subject,
                Location = report.location,
                Office = report.office,
                Type = report.Type,
                Text = report.Text,
                date = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                isAttchments = report.isAttchments
            };
            await _context.Reports.AddAsync(_report);
            await _context.SaveChangesAsync();
            await _oService.DeliveredAsync(_report.Id);
            

            return Ok(_report.Id);
        }

        [HttpPost("addAttachments")]
        public async Task<IActionResult> Attachments([FromForm] AttachmentModel attachment)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var report = await _context.Reports.FindAsync(attachment.id_Report);
            if (report == null)
                return NotFound();
            var _attachment = new db.Attachments
            {
                Id = Guid.NewGuid().ToString(),
                ext = attachment.ext,
                nameFile = attachment.nameFile,
                id_Report = attachment.id_Report,
            };
             await _context.Attachments.AddAsync(_attachment);
             await _context.SaveChangesAsync();
            var folder = Directory.CreateDirectory("D:\\ASP.NET_Core\\data\\Attachment\\" + attachment.id_Report);
            var filePath = Path.Combine($"{folder}" , $"{_attachment.Id}." + $"{_attachment.ext}");
            using var stream = System.IO.File.Create(filePath);
            { await attachment.file.CopyToAsync(stream); }

            
            return Ok();
        }
        [HttpPost("GetState")]
        public async Task<IActionResult> GetState([FromBody] String IdReport)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var report = await _context.Reports.FindAsync(IdReport);
            return Ok();
           
        }
        [HttpPost("GetReply")]
        public async Task<IActionResult> GetReply([FromBody] String IdReport)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var reply = await _context.Replys.FindAsync(IdReport);
            if (reply!=null)      
            return Ok(reply);
            else return NotFound();
        }

        [HttpPost("GetReplyById")]
        public async Task<IActionResult> GetReplyById([FromBody] IdReply idReply)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var reply = await _context.Replys.FindAsync(idReply.idReply);

            if (reply == null)
                return NotFound("sameh");

            var _reply = new GetReplyModel
                {
                id = reply.Id,
                Office = "فريق المراجعة",
                date = reply.date,
                Text = reply.Text,
                Title = reply.Subject,
                
                
                };
                return Ok(_reply);
            
        }

    }
}
