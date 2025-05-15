using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class AccUsers
    {
        [Key]
        [Required]
        public string AccId { get; set; }
        [Required]
        public int Credibility { get; set; }
        public bool isBlock { get; set; }
        public bool isSMS { get; set; }
        public bool isIdentity { get; set; }
        public string? work {  get; set; }
        public int ReportsCount { get; set; }
        public int ReplysCount { get; set; }
        public int ReportsFakeCount { get; set; }



    }
}