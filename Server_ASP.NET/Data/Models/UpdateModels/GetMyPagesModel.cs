using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Data.Models
{
    public class GetMyPagesModel
    {  
        [Required]
        public string id { get; set; }
        public string name { get; set; }
       
        public string? profile { get; set; }
      



    }
}
