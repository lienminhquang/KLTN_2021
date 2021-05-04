using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
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
    public class CategoryServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public CategoryServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:Categories"];
        }

        public async Task<ApiResult<PaginatedList<CategoryVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vms = JsonConvert.DeserializeObject<ApiResult<PaginatedList<CategoryVM>>>(body);
            return vms;
        }

        public async Task<ApiResult<CategoryVM>> GetByID(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{id}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vm = JsonConvert.DeserializeObject<ApiResult<CategoryVM>>(body);
            return vm;
        }

        public async Task<ApiResult<CategoryVM>> Create(CategoryCreateVM categoryCreateVM, string token)
        {
            var json = JsonConvert.SerializeObject(categoryCreateVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PostAsync(BaseRoute, httpContent);

            return JsonConvert.DeserializeObject<ApiResult<CategoryVM>>(await res.Content.ReadAsStringAsync());
        }

        public async Task<ApiResult<CategoryVM>> Edit(int id, CategoryVM cartEditVM, string token)
        {
            var json = JsonConvert.SerializeObject(cartEditVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PutAsync(BaseRoute + $"/{id}", httpContent);

            return JsonConvert.DeserializeObject<ApiResult<CategoryVM>>(await res.Content.ReadAsStringAsync());
        }

        public async Task<ApiResult<bool>> Delete(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{id}";
            var rs = await client.DeleteAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var result = JsonConvert.DeserializeObject<ApiResult<bool>>(body);
            return result;
        }
    }
}
