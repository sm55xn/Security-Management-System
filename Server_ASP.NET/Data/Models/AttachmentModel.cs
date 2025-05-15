namespace Security_Management_Server.Models
{
    public class AttachmentModel
    {
        public string id_Report { get; set; }

        public IFormFile file { get; set; }
        public string nameFile {  get; set; }
        public string ext {  get; set; }
    }
}
