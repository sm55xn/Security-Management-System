using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class ReportStatus
    {
        [Key]
        [Required]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string idReport { get; set; }
        public string State { get; set; }
        public int flag { get; set; }
        public string Discription { get; set; }
        public DateTime date { get; set; }



    }
}
