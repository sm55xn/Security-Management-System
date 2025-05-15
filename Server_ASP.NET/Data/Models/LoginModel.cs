using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;


namespace Security_Management_Server.Models
{
    public class LoginModel
    {
        [Required, StringLength(30)]
        public string username { get; set; }
        [Required, StringLength(50)]
        [Key]
        public string password { get; set; }

        
    }
}