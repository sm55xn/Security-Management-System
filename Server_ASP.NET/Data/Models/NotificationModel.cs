using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;


namespace Security_Management_Server.Models
{
    public class NotificationModel
    {
        public string Title { get; set; }
        public string Body { get; set; }
        public string DeviceToken { get; set; }
    }
}