using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class SurveyQuestions
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string? idSurvey { get; set; }
        public string? QuestionNum { get; set; }
        [Required]
        [MaxLength(50)]
        public int QuestionType { get; set; }
        public string TextQuestion { get; set; }
        public string Answers { get; set; }
        public DateTime date { get; set; }



    }
}
