using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Services
{
    public class FoodServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public FoodServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:Foods"];
        }

        public async Task<ApiResult<PaginatedList<FoodVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            ApiResult<PaginatedList<FoodVM>> vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<FoodVM>>>(body);
            return vm;
        }

        public async Task<ApiResult<FoodVM>> GetByID(int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{foodID}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vm = JsonConvert.DeserializeObject<ApiResult<FoodVM>>(body);
            return vm;
        }

        public async Task<ApiResult<FoodVM>> Create(FoodCreateVM createVM, string token)
        {
            var requestContent = new MultipartFormDataContent();
            byte[] data;
            using (var br = new BinaryReader(createVM.ImageData.OpenReadStream()))
            {
                data = br.ReadBytes((int)createVM.ImageData.Length);
            }
            ByteArrayContent bytes = new ByteArrayContent(data);
            requestContent.Add(bytes, "ImageData", createVM.ImageData.FileName);

            requestContent.Add(new StringContent(createVM.Count.ToString()), "Count");
            requestContent.Add(new StringContent(createVM.Description.ToString()), "Description");
            requestContent.Add(new StringContent(createVM.Name.ToString()), "Name");
            requestContent.Add(new StringContent(createVM.Price.ToString()), "Price");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PostAsync(BaseRoute, requestContent);

            return JsonConvert.DeserializeObject<ApiResult<FoodVM>>(await res.Content.ReadAsStringAsync());
        }

        public async Task<ApiResult<FoodVM>> Edit(int id, FoodEditVM editVM, string token)
        {
            var requestContent = new MultipartFormDataContent();
            byte[] data;
            using (var br = new BinaryReader(editVM.ImageData.OpenReadStream()))
            {
                data = br.ReadBytes((int)editVM.ImageData.Length);
            }
            ByteArrayContent bytes = new ByteArrayContent(data);
            requestContent.Add(bytes, "ImageData", editVM.ImageData.FileName);

            requestContent.Add(new StringContent(editVM.Count.ToString()), "Count");
            requestContent.Add(new StringContent(editVM.Description.ToString()), "Description");
            requestContent.Add(new StringContent(editVM.Name.ToString()), "Name");
            requestContent.Add(new StringContent(editVM.Price.ToString()), "Price");

            

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var res = await client.PutAsync(BaseRoute + $"?id={id}", requestContent);

            return JsonConvert.DeserializeObject<ApiResult<FoodVM>>(await res.Content.ReadAsStringAsync());
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
