
using FirebaseAdmin.Messaging;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NuGet.Common;
using Security_Management_Server.App.SecMobileV01.Report;
using Security_Management_Server.db;
using Security_Management_Server.Models;
using Security_Management_Server.Services;
using System.Net;
using System.Runtime.Serialization;

namespace Security_Management_Server.App.SecManageV01.Reports
{
    [Authorize(Roles = "Blogger")]
    [Route("SecManageV01/Reports/[controller]")]
    [ApiController]
    public class Reply : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly ISendNotification _sendNotification;

        public Reply(ApplicationDbContext context, IHttpContextAccessor httpContextAccessor, ISendNotification sendNotification)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
            _sendNotification = sendNotification;
        }
        [HttpPost]
      // [Authorize(Roles = "Reply-Reports")]
        public async Task<IActionResult> ReplyAsync([FromBody] ReplyModel reply)
        {
            if (!ModelState.IsValid) { return BadRequest(ModelState);}
           
            var _reply = new db.Replys
            {
                Id = Guid.NewGuid().ToString(),
                idReport = reply.id_Report,
                iduser = reply.id_user,
                Subject = reply.Subject,
                idEmplyoee = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value,
                Text = reply.Text,
                date = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                isAttchments = reply.isAttchments
                

            };
            await _context.Replys.AddAsync(_reply);
            await _context.SaveChangesAsync();
            var token = await _context.firebaseTokens.FindAsync(reply.id_user);
            var _noti = new NotificationModel
            {
                Title = reply.Subject,
                Body = reply.Text,
                DeviceToken =token.Token.ToString(),
            };
            var data = new NotiDataModel
            {
                id = _reply.Id,
                Type = "Reply",
                Action = "GetReply"



            };
            await _sendNotification.Send_Notification(_noti,data);

            return Ok(_reply.Id);


           
        }

        [HttpGet("Reply")]
        public async Task<IActionResult> Reply2Async()
        {
            if (!ModelState.IsValid) { return BadRequest(ModelState); }
            var _noti = new NotificationModel
            {
                Title = "HI SAMEH",
                Body ="DFHJGDLFJGDLFJGDFJG",
                DeviceToken = "cZLQfIVmRD2NyWtmZ-chg1:APA91bHJ_2beOsExDzCcykXbAMHViFohRGaYi3qrKEOZInj0PL1HUh2uKvpMRXR21Foyfm9cSMqC2quvqNZ3UoSCtYivSZRDWzqA1iDHLzWEiGDiOhzAEBgkxriWDQktT9EmJv4DhAGF"
            };
            var data = new NotiDataModel
            {
                id = "dfsfsdfsdf",


            };
            await _sendNotification.Send_Notification(_noti, data);

            return Ok(0);

        }
       

            [HttpPost("addAttachmentsForReply")]
        public async Task<IActionResult> Attachments([FromForm] AttachmentModel attachment)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var reply = await _context.Replys.FindAsync(attachment.id_Report);
            if (reply == null)
                return NotFound();
            var _attachment = new db.AttachmentsForReply
            {
                Id = Guid.NewGuid().ToString(),
                ext = attachment.ext,
                nameFile = attachment.nameFile,
                id_Reply = attachment.id_Report,
            };
            await _context.AttachmentsForReply.AddAsync(_attachment);
            await _context.SaveChangesAsync();
            var folder = Directory.CreateDirectory("D:\\ASP.NET_Core\\data\\AttachmentsForReply\\" + attachment.id_Report);
            var filePath = Path.Combine($"{folder}", $"{_attachment.Id}." + $"{_attachment.ext}");
            using var stream = System.IO.File.Create(filePath);
            { await attachment.file.CopyToAsync(stream); }


            return Ok();
        }
    }
}
