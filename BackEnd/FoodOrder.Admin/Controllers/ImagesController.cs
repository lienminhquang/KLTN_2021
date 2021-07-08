using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Images;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    [Authorize(Roles = RoleTypes.ManagerGroup)]
    public class ImagesController : Controller
    {
        private readonly ImageServices _imageServices;
        private readonly IMapper _mapper;
        private readonly AdminUserService _adminUserService;

        public ImagesController(ImageServices imageServices, IMapper mapper, AdminUserService adminUserService)
        {
            _imageServices = imageServices;
            _mapper = mapper;
            _adminUserService = adminUserService;
        }

        // GET: CategoriesController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
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
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var cart = await _imageServices.GetByID(id, this.GetTokenFromCookie());

            if (!cart.IsSuccessed)
            {
                return this.RedirectToErrorPage(cart.ErrorMessage);
            }

            return View(cart.PayLoad);
        }

        // GET: CategoriesController/Create
        public async Task<ActionResult> Create()
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            return View();
        }

        // POST: CategoriesController/Create
        [HttpPost]
        //[ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult> CreateAsync([FromForm] ImageCreateVM categoryCreateVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
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
            if (!await this.ValidateTokenInCookie(_adminUserService))
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
        //[ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult> EditAsync(int id, [FromForm] ImageEditVM vm)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
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
            if (!await this.ValidateTokenInCookie(_adminUserService))
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
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteAsync(int id, ImageVM categoryVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
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
