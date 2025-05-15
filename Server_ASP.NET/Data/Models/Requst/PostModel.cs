using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Models
{
    public class PostModel
    {
      
        public string? idPage {  get; set; }
        public string? text { get; set; }
        public string isComment { get; set; }
        public IFormFile? Attchment { get; set; }
       }

    }
