using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Comments
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string idUser { get; set; }
        [Required]
        [MaxLength(50)]
        public string IdPost { get; set; }
        [MaxLength(500)]
        public string comment { get; set; }
        public string date { get; set; }



    }
}
