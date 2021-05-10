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
            var body = await rs.Content.ReadAsStringAsync();
            var carts = JsonConvert.DeserializeObject<ApiResult<PaginatedList<CartVM>>>(body);
            return carts;
        }

        public async Task<ApiResult<CartVM>> GetByID(string userID, int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/details?userID={userID.ToString()}&foodID={foodID}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var cart = JsonConvert.DeserializeObject<ApiResult<CartVM>>(body);
            return cart;
        }

        public async Task<ApiResult<CartVM>> Create(CartCreateVM cartCreateVM, string token)
        {
            var json = JsonConvert.SerializeObject(cartCreateVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PostAsync(BaseRoute, httpContent);

            return JsonConvert.DeserializeObject<ApiResult<CartVM>>(await res.Content.ReadAsStringAsync());
        }

        public async Task<ApiResult<CartEditVM>> EditCart(Guid userID, int foodID, CartEditVM cartEditVM, string token)
        {
            var json = JsonConvert.SerializeObject(cartEditVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PutAsync(BaseRoute + $"?userID={userID.ToString()}&foodID={foodID}", httpContent);

            return JsonConvert.DeserializeObject<ApiResult<CartEditVM>>(await res.Content.ReadAsStringAsync());
        }

        public async Task<ApiResult<bool>> Delete(Guid userID, int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?userID={userID.ToString()}&foodID={foodID}";
            var rs = await client.DeleteAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var result = JsonConvert.DeserializeObject<ApiResult<bool>>(body);
            return result;
        }
    }
}
