using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;


namespace Security_Management_Server.Models
{
    public class NotiDataModel
    {
        public string Action { get; set; }
        public string Type { get; set; }
        public string id { get; set; }
    }
}