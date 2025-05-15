using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Posts
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string? idBlogger { get; set; }
        [Required]
        [MaxLength(50)]
        public string? idPage { get; set; }
        public int views { get; set; }
        public int Likes {  get; set; }
        public int Comments { get; set; }
        public string Text { get; set; }
        public string? Attchment { get; set; }
        public bool isComment { get; set; }
        public string date { get; set; }



    }
}
