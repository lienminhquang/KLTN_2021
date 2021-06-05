using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.SaleCampaigns;
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
    public class SaleCampaignServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public SaleCampaignServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:SaleCampaigns"];
        }

        public async Task<ApiResult<PaginatedList<SaleCampaignVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"?{request.ToQueryString("&")}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<PaginatedList<SaleCampaignVM>>>(body);
                return vm;
            }
            return new FailedResult<PaginatedList<SaleCampaignVM>>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<SaleCampaignVM>> GetByID(int foodID, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{foodID}";
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<SaleCampaignVM>>(body);
                return vm;
            }
            return new FailedResult<SaleCampaignVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<SaleCampaignVM>> Create(SaleCampaignCreateVM createVM, string token)
        {
            var json = JsonConvert.SerializeObject(createVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var rs = await client.PostAsync(BaseRoute, httpContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.Created || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<SaleCampaignVM>>(body);
                return vm;
            }
            return new FailedResult<SaleCampaignVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }

        public async Task<ApiResult<SaleCampaignVM>> Edit(int id, SaleCampaignEditVM editVM, string token)
        {
            var json = JsonConvert.SerializeObject(editVM);
            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

            var rs = await client.PutAsync(BaseRoute + $"?id={id}", httpContent);

            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<SaleCampaignVM>>(body);
                return vm;
            }
            return new FailedResult<SaleCampaignVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
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
