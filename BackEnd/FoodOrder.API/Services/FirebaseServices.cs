using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using Google.Apis.Auth.OAuth2;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class FirebaseServices
    {
        private readonly ILogger<FirebaseServices> _logger;
        private string _appName;
        private FirebaseApp _app;
        public static string ClientPackageName = "com.lmq.thetop";

        public FirebaseServices(ILogger<FirebaseServices> logger)
        {
            _logger = logger;
        }

        public void Init()
        {
            var path = Environment.GetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS");
            if (string.IsNullOrEmpty(path))
            {
                _logger.LogInformation("FCM: Firebase service init failed. Could not find GOOGLE_APPLICATION_CREDENTIALS in your env");
                _app = null;
                return;
            }
            
            _app = FirebaseApp.Create(new AppOptions()
            {
                Credential = GoogleCredential.GetApplicationDefault(),
            });
            _appName = _app.Name;
            _logger.LogInformation("FCM AppName: " + _appName);

        }

        public async Task SendPNAsync(string token, string title, string body)
        {
            if(_app == null)
            {
                _logger.LogInformation("FCM: Could not send PN to user, Firebase service is not initialized or init failed");
                return;
            }

            //var registrationToken = "cP7yBjeZR1SVQmkHT77Nx-:APA91bFBm8jMh-2Cs5o07f6csf8IuHU3GwKi5vgdjcyCdl-ZpnFcnGVXULsfO8gEqLodiTINHuS47lKbTASjfqz5f9ModUj1QnxEqxTl-h3ct-0-Il4UlCCXiareSCx3lvBPLjwYuOSW";
            var androidConfig = new AndroidConfig()
            {
                
                Priority = Priority.High,
                RestrictedPackageName = ClientPackageName,
                Notification = new AndroidNotification() { 
                    Title = title,
                    Body = body
                }

            };
            var message = new FirebaseAdmin.Messaging.Message()
            {
                Android = androidConfig,
                Token = token,
            };
            var result = await FirebaseAdmin.Messaging.FirebaseMessaging.GetMessaging(_app)
                .SendAsync(message);
            _logger.LogInformation("FCM: " +  result);
        }
    }
}
