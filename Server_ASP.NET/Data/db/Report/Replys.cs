using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Replys
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string? iduser { get; set; }
        [Required]
        [MaxLength(50)]
        public string idReport { get; set; }
        public string Subject { get; set; }
        public string Text { get; set; }
        public bool isAttchments { get; set; }
        public int State { get; set; }
        public int? idOffice { get; set; }
        public string? idEmplyoee { get; set; }

        public string date { get; set; }



    }
}
