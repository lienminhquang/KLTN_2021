using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
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
            var query = request.ToQueryString("&");
            var uri = BaseRoute;
            if(!String.IsNullOrEmpty(query))
            {
                uri += $"?{query}";
            }
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<CategoryVM>>>(body);
                return vm;
            }
            return new FailedResult<PaginatedList<CategoryVM>>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<CategoryVM>> GetByID(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{id}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<CategoryVM>>(body);
                return vm;
            }
            return new FailedResult<CategoryVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<CategoryVM>> Create(CategoryCreateVM categoryCreateVM, string token)
        {
            var requestContent = new MultipartFormDataContent();
            byte[] data;
            using (var br = new BinaryReader(categoryCreateVM.ImageBinary.OpenReadStream()))
            {
                data = br.ReadBytes((int)categoryCreateVM.ImageBinary.Length);
            }
            ByteArrayContent bytes = new ByteArrayContent(data);
            requestContent.Add(bytes, "ImageBinary", categoryCreateVM.ImageBinary.FileName);

            requestContent.Add(new StringContent(categoryCreateVM.Description.ToString()), "Description");
            requestContent.Add(new StringContent(categoryCreateVM.Name.ToString()), "Name");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var rs = await client.PostAsync(BaseRoute, requestContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.Created || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<CategoryVM>>(body);
                return vm;
            }
            return new FailedResult<CategoryVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<CategoryVM>> Edit(int id, CategoryEditVM cartEditVM, string token)
        {
            var requestContent = new MultipartFormDataContent();
            if (cartEditVM.ImageBinary != null)
            {
                byte[] data;
                using (var br = new BinaryReader(cartEditVM.ImageBinary.OpenReadStream()))
                {
                    data = br.ReadBytes((int)cartEditVM.ImageBinary.Length);
                }
                ByteArrayContent bytes = new ByteArrayContent(data);
                requestContent.Add(bytes, "ImageBinary", cartEditVM.ImageBinary.FileName);
            }

            requestContent.Add(new StringContent(cartEditVM.Description.ToString()), "Description");
            requestContent.Add(new StringContent(cartEditVM.Name.ToString()), "Name");


            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            string uri = BaseRoute + $"?id={id.ToString()}";
            var rs = await client.PutAsync(uri, requestContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<CategoryVM>>(body);
                return vm;
            }
            return new FailedResult<CategoryVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<bool>> Delete(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{id}";
            var rs = await client.DeleteAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<bool>>(body);
                return vm;
            }
            return new FailedResult<bool>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }
        public async Task<ApiResult<bool>> DeletePermanently(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/permanently/{id}";
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
