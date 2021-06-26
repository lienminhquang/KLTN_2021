using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels.Users;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Services
{
    public class HttpClientFactoryWrapper
    {
        IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;

        HttpClientFactoryWrapper(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
        }

        public HttpClientWrapper CreateClient()
        {
            return new HttpClientWrapper(_httpClientFactory.CreateClient(), _config);
        }
    }

    public class HttpClientWrapper
    {
        HttpClient _client;
        private readonly IConfiguration _config;
        public HttpClientWrapper(HttpClient client, IConfiguration configuration)
        {
            _client = client;
            _config = configuration;
        }

        //public async Task<ApiResult<string>> RefreshTokenAsync()
        //{
        //    var loginRequest = new LoginRequest();
        //    loginRequest.Username = AdminUserService.Username;
        //    loginRequest.Password = AdminUserService.Password;
        //    var loginRequestJson = JsonConvert.SerializeObject(loginRequest);
        //    var httpContent = new StringContent(loginRequestJson, Encoding.UTF8, "application/json");

           
        //    var rs = await _client.PostAsync(_config["BaseAddress"] + "/api/Users/Login", httpContent);

        //    if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
        //    {
        //        var body = await rs.Content.ReadAsStringAsync();
        //        var vm = JsonConvert.DeserializeObject<ApiResult<string>>(body);
        //        return vm;
        //    }
        //    return new FailedResult<string>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        //}

        //public async Task<HttpResponseMessage> GetAsync(string requestUri, string token)
        //{
        //    _client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
        //    var rs = await _client.GetAsync(requestUri);
        //    if (rs.StatusCode == System.Net.HttpStatusCode.Unauthorized || rs.StatusCode == System.Net.HttpStatusCode.Forbidden)
        //    {
        //        var result = await RefreshTokenAsync();
        //        if(result.IsSuccessed == true)
        //        {

        //        }
        //    }
        //}
    }
}
