using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Reports
    {
        [Key]
        [Required]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string? idUser { get; set; }
        public string Subject { get; set; }
        public int Type { get; set; }
        public string Text { get; set; }
        public bool isReply { get; set; }
        public bool isAttchments { get; set; }
        public string? Location { get; set; }
        public int? Office { get; set; }
        public string? Comment { get; set; }
        public bool? isRead { get; set; }
        public string date { get; set; }



    }
}
