using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace Security_Management_Server.Models
{
    [Keyless]
    public class TokenRequestModel
    {
        [Required]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }
    }
}