using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Promotions;
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
    public class PromotionServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public PromotionServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:Promotions"];
        }

        public async Task<ApiResult<PaginatedList<PromotionVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<PromotionVM>>>(body);
                return vm;
            }
            return new FailedResult<PaginatedList<PromotionVM>>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<PromotionVM>> GetByID(int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{foodID}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PromotionVM>>(body);
                return vm;
            }
            return new FailedResult<PromotionVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<PromotionVM>> Create(PromotionCreateVM createVM, string token)
        {
            var requestContent = new MultipartFormDataContent();
            byte[] data;
            using (var br = new BinaryReader(createVM.ImageData.OpenReadStream()))
            {
                data = br.ReadBytes((int)createVM.ImageData.Length);
            }
            ByteArrayContent bytes = new ByteArrayContent(data);
            requestContent.Add(bytes, "ImageData", createVM.ImageData.FileName);

            requestContent.Add(new StringContent(createVM.Code.ToString()), "Code");
            requestContent.Add(new StringContent(createVM.Desciption.ToString()), "Desciption");
            requestContent.Add(new StringContent(createVM.Enabled.ToString()), "Enabled");
            requestContent.Add(new StringContent(createVM.EndDate.ToString()), "EndDate");
            requestContent.Add(new StringContent(createVM.IsGlobal.ToString()), "IsGlobal");
            requestContent.Add(new StringContent(createVM.Max.ToString()), "Max");
            requestContent.Add(new StringContent(createVM.MinPrice.ToString()), "MinPrice");
            requestContent.Add(new StringContent(createVM.Name.ToString()), "Name");
            requestContent.Add(new StringContent(createVM.Percent.ToString()), "Percent");
            requestContent.Add(new StringContent(createVM.Priority.ToString()), "Priority");
            requestContent.Add(new StringContent(createVM.StartDate.ToString()), "StartDate");
            requestContent.Add(new StringContent(createVM.UseTimes.ToString()), "UseTimes");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var rs = await client.PostAsync(BaseRoute, requestContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.Created || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PromotionVM>>(body);
                return vm;
            }
            return new FailedResult<PromotionVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<PromotionVM>> Edit(int id, PromotionEditVM editVM, string token)
        {
            var requestContent = new MultipartFormDataContent();
            if (editVM.ImageData != null)
            {
                byte[] data;
                using (var br = new BinaryReader(editVM.ImageData.OpenReadStream()))
                {
                    data = br.ReadBytes((int)editVM.ImageData.Length);
                }
                ByteArrayContent bytes = new ByteArrayContent(data);
                requestContent.Add(bytes, "ImageData", editVM.ImageData.FileName);
            }

            requestContent.Add(new StringContent(editVM.Code.ToString()), "Code");
            requestContent.Add(new StringContent(editVM.Desciption.ToString()), "Desciption");
            requestContent.Add(new StringContent(editVM.Enabled.ToString()), "Enabled");
            requestContent.Add(new StringContent(editVM.EndDate.ToString()), "EndDate");
            requestContent.Add(new StringContent(editVM.IsGlobal.ToString()), "IsGlobal");
            requestContent.Add(new StringContent(editVM.Max.ToString()), "Max");
            requestContent.Add(new StringContent(editVM.MinPrice.ToString()), "MinPrice");
            requestContent.Add(new StringContent(editVM.Name.ToString()), "Name");
            requestContent.Add(new StringContent(editVM.Percent.ToString()), "Percent");
            requestContent.Add(new StringContent(editVM.Priority.ToString()), "Priority");
            requestContent.Add(new StringContent(editVM.StartDate.ToString()), "StartDate");
            requestContent.Add(new StringContent(editVM.UseTimes.ToString()), "UseTimes");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var rs = await client.PutAsync(BaseRoute + $"?id={id}", requestContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PromotionVM>>(body);
                return vm;
            }
            return new FailedResult<PromotionVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
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
    }
}
