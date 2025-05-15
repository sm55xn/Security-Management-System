using System.Security.Cryptography;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Security_Management_Server.db;
using Security_Management_Server.Helpers;
using Security_Management_Server.Models;
using Security_Management_Server.Services;

namespace Security_Management_Server.App.SecMobileV01.Auth
{

    [ApiController]
    [Route("SecMobileV01/Auth/[Controller]")]
    public class Otp : ControllerBase
    {  
        private readonly IAuthService _authService;
        private readonly ApplicationDbContext _context;
        private readonly ISendSMS _sendCode;

        public Otp(IAuthService authService, ApplicationDbContext context, ISendSMS sendCode)
        {
            _authService = authService;
            _context = context;
            _sendCode = sendCode;
        }
        [HttpGet("check")]
        public async Task<IActionResult> Checker()
        {
            return Ok();
        }
        [HttpPost("login")]
        public async Task<IActionResult> LoginAsync([FromBody]PhoneNumber model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            Random rand = new Random();
            model.pin = rand.Next(100000,999999).ToString() ;
            ToItem item = new ToItem(); 
            item.to = model.phone;
            item.message = "Code Verify is " + model.pin + " \n \n b+TBPfVtcOD";
            _context.PhoneNumbers.Add(model);
            await _context.SaveChangesAsync();
            await _sendCode.Send(item);
            return Ok(model.pin);
        }
        [HttpPost("verify")]
        public async Task<IActionResult> verifyAsync([FromBody] PhoneNumber model) 
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var phone =await _context.PhoneNumbers.FindAsync(model.pin);
            if (phone == null)
                return NotFound();
            else if (phone.phone == model.phone)
            {
             var result = await _authService.LoginAsync(model);
                if (!result.IsAuthenticated)
                    return BadRequest(result.Message);
                return Ok(result);
            }
                return NotFound();
        }
    }
    
}