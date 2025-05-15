using Security_Management_Server.Helpers;

namespace Security_Management_Server.Services
{
    public interface ISendSMS
    {
        Task Send(ToItem item);
    }
}
