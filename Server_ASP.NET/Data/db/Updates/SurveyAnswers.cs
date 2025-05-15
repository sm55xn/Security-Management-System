using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class SurveyAnswers
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string? idSurvey { get; set; }
        [Required]
        [MaxLength(50)]
        public string? idUser { get; set; }
        public string TextQuestion { get; set; }
        public string QuestionNum { get; set; }
        public string Answer { get; set; }
        public DateTime date { get; set; }



    }
}
