using FoodOrder.Core.ViewModels;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Services
{
    public class AdminUserService
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public AdminUserService(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        public async Task<string> Authenticate(LoginRequest loginRequest)
        {
            var loginRequestJson = JsonConvert.SerializeObject(loginRequest);
            var httpContent = new StringContent(loginRequestJson, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            var res = await client.PostAsync("https://localhost:6001/api/Users/Login", httpContent);

            return await res.Content.ReadAsStringAsync();
        }

    }
}
