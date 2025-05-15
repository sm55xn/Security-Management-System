using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Models
{
    public class GetReplyModel
    {
        public string id { get; set; }
        public string Office { get; set; }
       
      //  public string Profile { get; set; } 
        public string Title { get; set; }
      
        public string Text { get; set; }
       // public bool isAttchments { get; set; }
        public string date { get; set; }

    }
}
