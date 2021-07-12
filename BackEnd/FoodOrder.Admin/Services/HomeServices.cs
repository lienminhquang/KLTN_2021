using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels.Homes;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Services
{
    public class HomeServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public HomeServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:Home"];
        }

        public async Task<ApiResult<HomeVM>> Get(string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute;
            var rs = await client.GetAsync(uri);
            if (rs.StatusCode == System.Net.HttpStatusCode.OK || rs.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                var body = await rs.Content.ReadAsStringAsync();
                var vm = JsonConvert.DeserializeObject<ApiResult<HomeVM>>(body);
                return vm;
            }
            return new FailedResult<HomeVM>(rs.ReasonPhrase != null ? rs.ReasonPhrase : "Some thing went wrong!");
        }
       
    }
}
