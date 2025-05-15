using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class FirebaseTokens
    {
        [Key]
        [Required]
        public string Id { get; set; }
        public string Token { get; set; }


    }
}