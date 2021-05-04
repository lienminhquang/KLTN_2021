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
                return View(carts.ErrorMessage);
            }

            return View(carts.PayLoad);
        }

        // GET: CategoriesController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            var cart = await _categoryServices.GetByID(id, this.GetTokenFromCookie());

            if (!cart.IsSuccessed)
            {
                return View(cart.ErrorMessage);
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
        public async Task<ActionResult> CreateAsync([FromBody] CategoryCreateVM categoryCreateVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                // Todo: catch error ?? can we return apiresult as model and check success in view ?
                return View(ModelState);
            }

            var rs = await _categoryServices.Create(categoryCreateVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                return RedirectToAction("Index", "Categories");
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
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
                return View(result.ErrorMessage);
            }

            CategoryVM vm = result.PayLoad;

            return View(vm);
        }

        // POST: CategoriesController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync(int id, [FromBody] CategoryVM vm)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                // Todo: catch error ?? can we return apiresult as model and check success in view ?
                return View(ModelState);
            }

            var rs = await _categoryServices.Edit(id, vm, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                return View(rs.PayLoad);
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
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
                return View(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CategoriesController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteAsync(int id, IFormCollection collection)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _categoryServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            return RedirectToAction("Index", "Categories");
        }
    }
}
