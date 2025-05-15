using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace Security_Management_Server.Models
{
    [Keyless]
    public class CreateAccModel
    {
        [Required, StringLength(100)]
        public string Name { get; set; }
        [Required, StringLength(50)]
        public string Username { get; set; }

        [Required, StringLength(256)]
        public string Password { get; set; }

        public string Gender { get; set; }
        public int flagOffice { get; set; }
    }
}