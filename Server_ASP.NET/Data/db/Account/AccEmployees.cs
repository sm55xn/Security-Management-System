using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class AccEmployees
    {
        [Key]
        [Required]
        public string IdAcc { get; set; }
        public int flagOffice { get; set; }
        public float salary { get; set; }
        public string? Statistics { get; set; }
    }
}