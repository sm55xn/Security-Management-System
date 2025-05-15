using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Data.Models
{
    public class LikeModel
    {
        [Required]
        public string iduser { get; set; }
        [Required]
        public string IdPost { get; set; }
        public bool IsLike { get; set; }



    }
}
