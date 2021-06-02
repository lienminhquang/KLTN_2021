using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Ratings;
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
    public class RatingServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public RatingServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:Ratings"];
        }

        public async Task<ApiResult<PaginatedList<RatingVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<RatingVM>>>(body);
            return vm;
        }

        public async Task<ApiResult<PaginatedList<RatingVM>>> GetRatingOfFood(int foodID, PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/food?foodID={foodID}&{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<RatingVM>>>(body);
            return vm;
        }

        public async Task<ApiResult<RatingVM>> GetByID(int orderID, int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/details?orderID={orderID}&foodID={foodID}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vm = JsonConvert.DeserializeObject<ApiResult<RatingVM>>(body);
            return vm;
        }

        public async Task<ApiResult<RatingVM>> Create(RatingCreateVM createVM, string token)
        {
            var json = JsonConvert.SerializeObject(createVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PostAsync(BaseRoute, httpContent);

            return JsonConvert.DeserializeObject<ApiResult<RatingVM>>(await res.Content.ReadAsStringAsync());
        }

        public async Task<ApiResult<RatingVM>> Edit(int orderID, int foodID, RatingEditVM editVM, string token)
        {
            var json = JsonConvert.SerializeObject(editVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PutAsync(BaseRoute + $"?orderID={orderID}&foodID={foodID}", httpContent);

            return JsonConvert.DeserializeObject<ApiResult<RatingVM>>(await res.Content.ReadAsStringAsync());
        }

        public async Task<ApiResult<bool>> Delete(int orderID, int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?orderID={orderID}&foodID={foodID}";
            var rs = await client.DeleteAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var result = JsonConvert.DeserializeObject<ApiResult<bool>>(body);
            return result;
        }
    }
}
