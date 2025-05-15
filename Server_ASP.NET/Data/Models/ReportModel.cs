using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.Models
{
    public class ReportModel
    {
        public string Subject { get; set; }
        public string? location {  get; set; }
        public int? office { get; set; }
        public int Type { get; set; }
        public string Text { get; set; }
        public bool isAttchments { get; set; }

    }
}
