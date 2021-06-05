using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Carts;
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
    public class CartServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public CartServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:Carts"];
        }

        public async Task<ApiResult<PaginatedList<CartVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<CartVM>>>(body);
                return vm;
            }
            return new FailedResult<PaginatedList<CartVM>>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<CartVM>> GetByID(string userID, int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/details?userID={userID.ToString()}&foodID={foodID}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<CartVM>>(body);
                return vm;
            }
            return new FailedResult<CartVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<PaginatedList<CartVM>>> GetByUserID(string userID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/user?userID={userID.ToString()}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<CartVM>>>(body);
                return vm;
            }
            return new FailedResult<PaginatedList<CartVM>>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<CartVM>> Create(CartCreateVM cartCreateVM, string token)
        {
            var json = JsonConvert.SerializeObject(cartCreateVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var rs = await client.PostAsync(BaseRoute, httpContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.Created || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<CartVM>>(body);
                return vm;
            }
            return new FailedResult<CartVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<CartEditVM>> EditCart(Guid userID, int foodID, CartEditVM cartEditVM, string token)
        {
            var json = JsonConvert.SerializeObject(cartEditVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var rs = await client.PutAsync(BaseRoute + $"?userID={userID.ToString()}&foodID={foodID}", httpContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<CartEditVM>>(body);
                return vm;
            }
            return new FailedResult<CartEditVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<bool>> Delete(Guid userID, int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?userID={userID.ToString()}&foodID={foodID}";
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
