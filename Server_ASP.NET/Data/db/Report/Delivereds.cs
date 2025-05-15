using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
   
    public class Delivereds
    {
        [Key]
        public int id { get; set; }
        [MaxLength(50)]
        public string IdReport { get; set; }
        [Required]
        [MaxLength(50)]
        public string idEmployee { get; set; }
        public bool isDelivered { get; set; }
        
    }
}
