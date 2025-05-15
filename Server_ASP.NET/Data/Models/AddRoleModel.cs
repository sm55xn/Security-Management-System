using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace Security_Management_Server.Models
{
    [Keyless]
    public class AddRoleModel
    {  
        [Required]
        public string UserId { get; set; }

        [Required]
        public string Role { get; set; }
    }
}