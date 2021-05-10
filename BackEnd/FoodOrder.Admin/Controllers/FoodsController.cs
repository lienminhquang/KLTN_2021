using AutoMapper;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    public class FoodsController : Controller
    {
        private readonly FoodServices _foodServices;
        private readonly IMapper _mapper;

        public FoodsController(FoodServices foodServices, IMapper mapper)
        {
            _foodServices = foodServices;
            _mapper = mapper;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var vm = await _foodServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return View(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            var vm = await _foodServices.GetByID(id, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return View(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Create
        public ActionResult Create()
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            return View();
        }

        // POST: CartsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateAsync([FromForm] FoodCreateVM createVM)
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

            var rs = await _foodServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                // Todo: redirect to details instead?
                return RedirectToAction("Index", "Foods");
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        // GET: CartsController/Edit/5
        public async Task<ActionResult> EditAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _foodServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            var vm = result.PayLoad;

            return View(_mapper.Map<FoodVM, FoodEditVM>(vm));
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync([FromForm] FoodEditVM editVM)
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

            var rs = await _foodServices.Edit(editVM.ID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                return RedirectToAction("Details", new { id = editVM.ID });
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        // GET: CartsController/Delete/5
        public async Task<ActionResult> DeleteAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }
            var result = await _foodServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CartsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }


            var result = await _foodServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }
            return RedirectToAction("Index", "Foods");
        }
    }
}
