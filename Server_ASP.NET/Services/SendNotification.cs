
using Security_Management_Server.Models;
using FirebaseAdmin.Messaging;
using System.Net;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace Security_Management_Server.Services
{
    public class SendNotification : ISendNotification
    {

     //   public SendNotification()
           
        public async Task Send_Notification(NotificationModel model,NotiDataModel Data)
        {
            var message = new Message()
            {
                Notification = new Notification
                {
                    Title = model.Title,
                    Body = model.Body,
                    
                    
                },
                Data = new Dictionary<string, string>()
                {
                    ["type"] = "REPLY",
                    ["id"]= "5769b8ec-1d7e-46ea-99f8-3d013997af1c"

                },
                Token = model.DeviceToken,


            };

            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);

            if (!string.IsNullOrEmpty(result))
            {
                
                // Message was sent successfully
                Debug.Write("Message sent successfully!");
                Debug.Write("####################################################3");
                Debug.Write(result);
            }
            else
            {
                // There was an error sending the message
                throw new Exception("Error sending the message.");
            }
        }


    }
    
}
