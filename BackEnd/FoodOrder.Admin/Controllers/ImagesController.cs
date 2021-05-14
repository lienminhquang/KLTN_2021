using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Images;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    public class ImagesController : Controller
    {
        private readonly ImageServices _imageServices;
        private readonly IMapper _mapper;
        public ImagesController(ImageServices imageServices, IMapper mapper)
        {
            _imageServices = imageServices;
            _mapper = mapper;
        }

        // GET: CategoriesController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var carts = await _imageServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!carts.IsSuccessed)
            {
                return this.RedirectToErrorPage(carts.ErrorMessage);
            }

            return View(carts.PayLoad);
        }

        // GET: CategoriesController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            var cart = await _imageServices.GetByID(id, this.GetTokenFromCookie());

            if (!cart.IsSuccessed)
            {
                return this.RedirectToErrorPage(cart.ErrorMessage);
            }

            return View(cart.PayLoad);
        }

        // GET: CategoriesController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: CategoriesController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult> CreateAsync([FromForm] ImageCreateVM categoryCreateVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(categoryCreateVM);
            }

            var rs = await _imageServices.Create(categoryCreateVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Image create succesed!";
                return RedirectToAction("Index");
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(categoryCreateVM);
        }

        // GET: CategoriesController/Edit/5
        public async Task<ActionResult> EditAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            var result = await _imageServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            ImageVM vm = result.PayLoad;

            return View(_mapper.Map<ImageEditVM>(vm));
        }

        // POST: CategoriesController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult> EditAsync(int id, [FromForm] ImageEditVM vm)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(vm);
            }

            var rs = await _imageServices.Edit(id, vm, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Image edited!";
                return RedirectToAction("Details", new { id = id });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(vm);
        }

        // GET: CategoriesController/Delete/5
        public async Task<ActionResult> DeleteAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            var result = await _imageServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CategoriesController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteAsync(int id, ImageVM categoryVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            var result = await _imageServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = result.ErrorMessage;
                return View(categoryVM);
            }

            TempData[AppConfigs.SuccessMessageString] = "Image delete succesed!";
            return RedirectToAction("Index");
        }
    }
}
