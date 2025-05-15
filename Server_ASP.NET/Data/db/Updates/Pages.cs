using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Pages
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string? Profile { get; set; }
        public string dateJoin { get; set; }
        public int FollowerCount { get; set;}
        public int PostsCount { get; set; }



    }
}
