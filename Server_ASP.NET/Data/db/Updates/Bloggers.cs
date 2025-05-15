using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Bloggers
    {
        [Key][MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string idPage { get; set; }
        [Required]
        [MaxLength(50)]
        public string idBlogger { get; set; }

    }
}
