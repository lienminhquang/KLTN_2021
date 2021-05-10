using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    public class CategoriesController : Controller
    {
        private readonly CategoryServices _categoryServices;

        public CategoriesController(CategoryServices categoryServices)
        {
            _categoryServices = categoryServices;
        }

        // GET: CategoriesController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var carts = await _categoryServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!carts.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = carts.ErrorMessage;
            }

            return View(carts.PayLoad);
        }

        // GET: CategoriesController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            var cart = await _categoryServices.GetByID(id, this.GetTokenFromCookie());

            if (!cart.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = cart.ErrorMessage;
                return RedirectToAction("Index");
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
        public async Task<ActionResult> CreateAsync([FromForm] CategoryCreateVM categoryCreateVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                return View(categoryCreateVM);
            }

            var rs = await _categoryServices.Create(categoryCreateVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Category created!";
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
                return RedirectToAction("Login", "User");
            }

            var result = await _categoryServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = result.ErrorMessage;
                return RedirectToAction("Index");
            }

            CategoryVM vm = result.PayLoad;

            return View(vm);
        }

        // POST: CategoriesController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync(int id, [FromForm] CategoryVM vm)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                return View(vm);
            }

            var rs = await _categoryServices.Edit(id, vm, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Category edited!";
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
                return RedirectToAction("Login", "User");
            }
            var result = await _categoryServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                //Todo: maybe we should return to error page instead?
                TempData[AppConfigs.ErrorMessageString] = result.ErrorMessage;
                return RedirectToAction("Index");
            }

            return View(result.PayLoad);
        }

        // POST: CategoriesController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteAsync(int id, CategoryVM categoryVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _categoryServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = result.ErrorMessage;
                return View(categoryVM);
            }

            TempData[AppConfigs.SuccessMessageString] = "Category deleted!";
            return RedirectToAction("Index", "Categories");
        }
    }
}
