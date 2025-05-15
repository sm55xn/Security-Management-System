using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Polices
    {
        [Key]
        [Required]
        [MaxLength(4)]
        public int Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string name { get; set; }

        public string? info { get; set; }
       



    }
}
