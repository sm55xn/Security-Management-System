using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Like
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string iduser { get; set; }
        [Required]
        [MaxLength(50)]
        public string IdPost { get; set; }
        public bool IsLike { get; set; }



    }
}
