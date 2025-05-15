using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class RespondingAgency
    {
        [Key]
        [Required]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string name { get; set; }
        public string AgencyType { get; set; }
        public string ReportType { get; set; }
        public string info { get; set; }
        public DateTime date { get; set; }



    }
}
