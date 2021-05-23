using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.OrderStatuses;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Services
{
    public class OrderStatusServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly string BaseRoute;

        public OrderStatusServices(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _config = configuration;
            BaseRoute = _config["BaseAddress"] + _config["APIRoute:OrderStatuses"];
        }

        public async Task<ApiResult<PaginatedList<OrderStatusVM>>> GetAllPaging(PagingRequestBase request, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var query = request.ToQueryString("&");
            var uri = BaseRoute;
            if (!String.IsNullOrEmpty(query))
            {
                uri += $"?{query}";
            }
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vms = JsonConvert.DeserializeObject<ApiResult<PaginatedList<OrderStatusVM>>>(body);
            return vms;
        }

        public async Task<ApiResult<OrderStatusVM>> GetByID(int id, string token)
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            var uri = BaseRoute + $"/{id}";
            var rs = await client.GetAsync(uri);
            var body = await rs.Content.ReadAsStringAsync();
            var vm = JsonConvert.DeserializeObject<ApiResult<OrderStatusVM>>(body);
            return vm;
        }

        //public async Task<ApiResult<ImageVM>> Create(ImageCreateVM imageCreateVM, string token)
        //{
        //    if (imageCreateVM.ImageData == null)
        //    {
        //        return new FailedResult<ImageVM>("File error!");
        //    }

        //    var requestContent = new MultipartFormDataContent();
        //    byte[] data;
        //    using (var br = new BinaryReader(imageCreateVM.ImageData.OpenReadStream()))
        //    {
        //        data = br.ReadBytes((int)imageCreateVM.ImageData.Length);
        //    }
        //    ByteArrayContent bytes = new ByteArrayContent(data);
        //    requestContent.Add(bytes, "ImageData", imageCreateVM.ImageData.FileName);

        //    requestContent.Add(new StringContent(imageCreateVM.FoodID.ToString()), "FoodID");
        //    requestContent.Add(new StringContent(imageCreateVM.SortOrder.ToString()), "SortOrder");
        //    requestContent.Add(new StringContent(imageCreateVM.IsDefault.ToString()), "IsDefault");
        //    requestContent.Add(new StringContent(String.IsNullOrEmpty(imageCreateVM.Caption) ? "" : imageCreateVM.Caption), "Caption");




        //    var client = _httpClientFactory.CreateClient();
        //    client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

        //    var res = await client.PostAsync(BaseRoute, requestContent);

        //    return JsonConvert.DeserializeObject<ApiResult<ImageVM>>(await res.Content.ReadAsStringAsync());
        //}

        //public async Task<ApiResult<ImageVM>> Edit(int id, ImageEditVM request, string token)
        //{
        //    if (request.ImageData == null)
        //    {
        //        return new FailedResult<ImageVM>("File error!");
        //    }

        //    var requestContent = new MultipartFormDataContent();
        //    byte[] data;
        //    using (var br = new BinaryReader(request.ImageData.OpenReadStream()))
        //    {
        //        data = br.ReadBytes((int)request.ImageData.Length);
        //    }
        //    ByteArrayContent bytes = new ByteArrayContent(data);
        //    requestContent.Add(bytes, "ImageData", request.ImageData.FileName);

        //    requestContent.Add(new StringContent(request.FoodID.ToString()), "FoodID");
        //    requestContent.Add(new StringContent(request.SortOrder.ToString()), "SortOrder");
        //    requestContent.Add(new StringContent(request.IsDefault.ToString()), "IsDefault");
        //    requestContent.Add(new StringContent(String.IsNullOrEmpty(request.Caption) ? "" : request.Caption), "Caption");


        //    var client = _httpClientFactory.CreateClient();
        //    client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
        //    string uri = BaseRoute + $"?id={id.ToString()}";
        //    var res = await client.PutAsync(uri, requestContent);

        //    return JsonConvert.DeserializeObject<ApiResult<ImageVM>>(await res.Content.ReadAsStringAsync());
        //}

        //public async Task<ApiResult<bool>> Delete(int id, string token)
        //{
        //    var client = _httpClientFactory.CreateClient();
        //    client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
        //    var uri = BaseRoute + $"/{id}";
        //    var rs = await client.DeleteAsync(uri);
        //    var body = await rs.Content.ReadAsStringAsync();
        //    var result = JsonConvert.DeserializeObject<ApiResult<bool>>(body);
        //    return result;
        //}
    }
}
