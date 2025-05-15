using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class ApplicationUser : IdentityUser
    {
        [Required, MaxLength(50)]
        public string Name { get; set; }
        public string DateOfJoin { get; set; }
        public string? DateOfBirth { get; set; }
        public string? Gender { get; set; }
        public byte[]? Profile { get; set; }
        public bool IsEmployee { get; set; }





    }
}