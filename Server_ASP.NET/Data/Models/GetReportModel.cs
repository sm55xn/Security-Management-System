namespace Security_Management_Server.Data.Models
{
    internal class GetReportModel
    {
        public string id { get; set; }
        public string idUser { get; set; }
        public string Name { get; set; }
        public bool isAttchments { get; set; }
        public string Title { get; set; }
        public string Text { get; set; }
        public string date { get; set; }
        public string location { get; set; }
        public int? office { get; set; }
        public int Type { get; set; }
        public string Profile { get; set; }
    }
}