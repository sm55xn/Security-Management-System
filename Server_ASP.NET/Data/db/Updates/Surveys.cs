using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class Surveys
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string? idPage { get; set; }
        public string Subject { get; set; }
        public string Description { get; set; }
        public int numQuestions { get; set; }
        public int views { get; set; }
        public int doneAnswer { get; set; }
       
        public DateTime date { get; set; }



    }
}
