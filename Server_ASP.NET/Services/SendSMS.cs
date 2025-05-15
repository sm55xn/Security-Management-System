using System;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using Microsoft.Net.Http.Headers;
using Newtonsoft.Json.Serialization;
using Newtonsoft.Json;
using Security_Management_Server.Helpers;
using static System.Net.Mime.MediaTypeNames;

namespace Security_Management_Server.Services
{
    public class SendSMS:ISendSMS
    {
        private readonly IHttpClientFactory _httpClientFactory;
        public SendSMS(IHttpClientFactory httpClientFactory) =>
           _httpClientFactory = httpClientFactory;
        public async Task Send(ToItem item)
        {
            var ItemJson = JsonConvert.SerializeObject(item, new JsonSerializerSettings
            {
                ContractResolver = new DefaultContractResolver
                {
                    IgnoreSerializableAttribute = false
                }
            });
            
   

            var httpClient = _httpClientFactory.CreateClient();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            HttpContent httpContent = new StringContent(ItemJson, Encoding.UTF8, "application/json");
            httpClient.DefaultRequestHeaders.TryAddWithoutValidation("Content-Type", "application/json; charset=utf-8");
            httpClient.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", "9db59d07-df58-4fdf-b6d0-66cea0b0efa9");
            using  var httpResponseMessage = await httpClient.PostAsync("http://192.168.43.1:8082", httpContent);

            if (httpResponseMessage.IsSuccessStatusCode)
            {
                using var contentStream =
                    await httpResponseMessage.Content.ReadAsStreamAsync();

              
            }
        }
       
       
    }
    
}
