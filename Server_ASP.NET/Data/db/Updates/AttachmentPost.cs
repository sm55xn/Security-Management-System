using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class AttachmentPost
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string idPost { get; set; }
        [Required]
        [MaxLength(50)]
        public string IdAttachmentPost { get; set; }
        public string ext { get; set; }



    }
}
