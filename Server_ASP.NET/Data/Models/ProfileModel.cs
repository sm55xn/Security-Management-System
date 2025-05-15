namespace Security_Management_Server.Models
{
    public class ProfileModel
    {
        public string? name { get; set; }
        public string? Gender { get; set; }
        public string? DateOfBirth { get; set; }
        public string? TokenFirebase { get; set; }
        public IFormFile? Profile { get; set; }

    }
}
