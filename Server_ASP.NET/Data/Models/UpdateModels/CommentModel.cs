using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Data.Models
{
    public class CommentModel
    {
        [Required]
        public string idPost { get; set; }
        [Required]
        public string Text { get; set; }



    }
}
