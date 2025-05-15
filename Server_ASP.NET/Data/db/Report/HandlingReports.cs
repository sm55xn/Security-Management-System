using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    [Keyless]
    public class HandlingReports
    {
        
        [MaxLength(50)]
        public string IdReport { get; set; }
        [Required]
        [MaxLength(50)]
        public string idEmployee { get; set; }
        public int office { get; set; }
        
    }
}
