using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Data.Models
{
    public class AttachmentPostMode
    {
        
        public string idPost { get; set; }
        [MaxLength(50)]
        public string IdAttachmentPost { get; set; }
        public string ext { get; set; }



    }
}
