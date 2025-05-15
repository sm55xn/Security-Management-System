using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class ReportType
    {
        [Key]
        [Required]
        [MaxLength(50)]
        public int Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string Type { get; set; }
        public int flag { get; set; }
        public string Description { get; set; }



    }
}
