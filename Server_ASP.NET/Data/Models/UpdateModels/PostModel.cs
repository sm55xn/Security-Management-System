using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Data.Models
{
    public class GetPostModel
    {
        [Required]
        public string? idPage { get; set; }
        [Required]
        public string? idPost { get; set; }
        public string? Profile { get; set; }
        [Required]
        public string? NamePage { get; set; }
        public int views { get; set; }
        public int likes { get; set; }
        public int Comments { get; set; }
        public string Text { get; set; }
        public string? Attchment { get; set; }
        public bool isComment { get; set; }
        public string date { get; set; }



    }
}
