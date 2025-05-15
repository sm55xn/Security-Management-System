using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Attachments
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string id_Report { get; set; }
        public string nameFile { get; set; }
        public string ext { get; set; }
    }
}
