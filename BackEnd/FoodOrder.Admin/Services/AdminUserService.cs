using FoodOrder.Core.Helpers;
using FoodOrder.Core.ViewModels;
using Microsoft.Extensions.Configuration;
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
        private readonly IConfiguration _config;

        public AdminUserService(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
        }

        public async Task<string> Authenticate(LoginRequest loginRequest)
        {
            var loginRequestJson = JsonConvert.SerializeObject(loginRequest);
            var httpContent = new StringContent(loginRequestJson, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            var res = await client.PostAsync(_config["BaseAddress"] + "/api/Users/Login", httpContent);

            return await res.Content.ReadAsStringAsync();
        }

        public async Task<PaginatedList<UserVM>> GetUserPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = _config["BaseAddress"] + $"/api/Users?" + request.ToQueryString("&");
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var users = JsonConvert.DeserializeObject<PaginatedList<UserVM>>(body);
            return users;
        }

        public async Task<bool> CreateUser(RegisterRequest request, string token)
        {
            var json = JsonConvert.SerializeObject(request);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PostAsync(_config["BaseAddress"] + "/api/Users/Register", httpContent);

            return res.IsSuccessStatusCode;
        }

    }
}
