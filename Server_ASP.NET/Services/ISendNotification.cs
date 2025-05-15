using Google.Apis.FirebaseCloudMessaging.v1.Data;
using Microsoft.AspNetCore.Mvc;
using Security_Management_Server.Helpers;
using Security_Management_Server.Models;

namespace Security_Management_Server.Services
{
    public interface ISendNotification
    {
      Task Send_Notification(NotificationModel model, NotiDataModel Data);
    }
}
