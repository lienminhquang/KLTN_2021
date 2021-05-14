using FoodOrder.API.Services;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Images;
using FoodOrder.Data;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImagesController : ControllerBase
    {
        private readonly ImageServices _imageServices;

        public ImagesController(ImageServices imageServices)
        {
            _imageServices = imageServices;
        }

        // GET: CategoryController
        [HttpGet]
        public async Task<IActionResult> GetAllPaging([FromQuery] PagingRequestBase request)
        {
            var result = await _imageServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetByID(int id)
        {
            var result = await _imageServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        [Consumes("multipart/form-data")]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateAsync([FromForm] ImageCreateVM request)
        {
            var result = await _imageServices.Create(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPut]
        // [ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> EditAsync(int id, [FromForm] ImageEditVM edit)
        {
            var result = await _imageServices.Edit(id, edit);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var result = await _imageServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}
