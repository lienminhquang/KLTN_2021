using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    [Authorize(Roles = RoleTypes.ManagerGroup)]
    public class CategoriesController : Controller
    {
        private readonly CategoryServices _categoryServices;
        private readonly IMapper _mapper;

        public CategoriesController(CategoryServices categoryServices, IMapper mapper)
        {
            _categoryServices = categoryServices;
            _mapper = mapper;
        }

        // GET: CategoriesController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var carts = await _categoryServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!carts.IsSuccessed)
            {
                return this.RedirectToErrorPage(carts.ErrorMessage);
            }

            return View(carts.PayLoad);
        }

        // GET: CategoriesController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            var cart = await _categoryServices.GetByID(id, this.GetTokenFromCookie());

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
        public async Task<ActionResult> CreateAsync([FromForm] CategoryCreateVM categoryCreateVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(categoryCreateVM);
            }

            var rs = await _categoryServices.Create(categoryCreateVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Category create succesed!";
                return RedirectToAction("Index", "Categories");
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

            var result = await _categoryServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            CategoryEditVM vm = _mapper.Map< CategoryEditVM >( result.PayLoad);

            return View(vm);
        }

        // POST: CategoriesController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult> EditAsync([FromForm] CategoryEditVM vm)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(vm);
            }

            var rs = await _categoryServices.Edit(vm.ID, vm, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Category edited!";
                return RedirectToAction("Details", new { id = vm.ID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(vm);
        }

        // GET: CategoriesController/Delete/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> DeleteAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            var result = await _categoryServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CategoriesController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> DeleteAsync(int id, CategoryVM categoryVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            var result = await _categoryServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = result.ErrorMessage;
                return View(categoryVM);
            }

            TempData[AppConfigs.SuccessMessageString] = "Category delete succesed!";
            return RedirectToAction("Index");
        }
    }
}
