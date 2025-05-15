using System.ComponentModel.DataAnnotations;

namespace Security_Management_Server.db
{
    public class StatEmployee
    {
        [Key]
        [MaxLength(50)]
        public string Id { get; set; }
       
        [MaxLength(50)]
        public int numReports { get; set; }
        
        [MaxLength(50)]
        public int numReplys { get; set; }
        [MaxLength(50)]
        public int numReToReports { get; set; }
        [MaxLength(50)]
        public int numAsFalse { get; set; }





    }
}
