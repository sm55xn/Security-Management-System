using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Models
{
    public class ReplyModel
    {
        
        public string? id_user { get; set; }
        public string id_Report { get; set; }
        public string Subject { get; set; }
        public string Text { get; set; }
        public bool isAttchments { get; set; }
        public int State { get; set; }
        public string? id_Emplyoee { get; set; }
        public string date { get; set; }
    }
}
