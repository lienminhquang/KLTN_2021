using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Notifications;
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
    public class NotificationServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public NotificationServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:Notifications"];
        }

        public async Task<ApiResult<PaginatedList<NotificationVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<NotificationVM>>>(body);
                return vm;
            }
            return new FailedResult<PaginatedList<NotificationVM>>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<NotificationVM>> GetByID(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/details?id={id}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<NotificationVM>>(body);
                return vm;
            }
            return new FailedResult<NotificationVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<NotificationVM>> Create(NotificationCreateVM createVM, string token)
        {
            var json = JsonConvert.SerializeObject(createVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var rs = await client.PostAsync(BaseRoute, httpContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.Created || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<NotificationVM>>(body);
                return vm;
            }
            return new FailedResult<NotificationVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        //public async Task<ApiResult<RatingVM>> Edit(string userID, int foodID, RatingEditVM editVM, string token)
        //{
        //    var json = JsonConvert.SerializeObject(editVM);
        //    var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

        //    var client = _httpClientFactory.CreateClient();
        //    client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

        //    var res = await client.PutAsync(BaseRoute + $"?userID={userID}&foodID={foodID}", httpContent);

        //    return JsonConvert.DeserializeObject<ApiResult<RatingVM>>(await res.Content.ReadAsStringAsync());
        //}

        public async Task<ApiResult<bool>> Delete(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?id={id}";
            var rs = await client.DeleteAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<bool>>(body);
                return vm;
            }
            return new FailedResult<bool>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }
    }
}
