using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Data.Models
{
    public class PageModel
    {  
        [Required]
        public string Name { get; set; }
        public string Description { get; set; }
        public IFormFile? Profile { get; set; }
      



    }
}
