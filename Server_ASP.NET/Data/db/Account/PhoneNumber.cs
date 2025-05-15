using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;


namespace Security_Management_Server.db
{
    public class PhoneNumber
    {
        [Required, StringLength(13)]
        public string phone { get; set; }
        [Required, StringLength(6)]
        [Key]
        public string pin { get; set; }


    }
}