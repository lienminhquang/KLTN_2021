using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Promotions;
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
    public class PromotionsController : Controller
    {
        private readonly PromotionServices _promotionServices;
        private readonly FoodServices _foodServices;
        private readonly IMapper _mapper;
        private readonly AdminUserService _adminUserService;

        public PromotionsController(PromotionServices services, IMapper mapper, FoodServices foodServices, AdminUserService adminUserService)
        {
            _foodServices = foodServices;
            _promotionServices = services;
            _mapper = mapper;
            _adminUserService = adminUserService;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var vm = await _promotionServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = vm.ErrorMessage;
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            var vm = await _promotionServices.GetByID(id, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Create
        public async Task<ActionResult> CreateAsync()
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var listFoodVM = await _foodServices.GetAllPaging(new PagingRequestBase { PageNumber = 1 }, this.GetTokenFromCookie());
            if (!listFoodVM.IsSuccessed)
            {
                return this.RedirectToErrorPage(listFoodVM.ErrorMessage);
            }
            ViewBag.FoodVMs = listFoodVM.PayLoad.Items;

            return View();
        }

        // POST: CartsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateAsync([FromForm] PromotionCreateVM createVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(createVM);
            }

            var rs = await _promotionServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Promotion create succesed!";
                return RedirectToAction("Details", new { id = rs.PayLoad.ID });
            }

            var listFoodVM = await _foodServices.GetAllPaging(new PagingRequestBase { PageNumber = 1 }, this.GetTokenFromCookie());
            if (!listFoodVM.IsSuccessed)
            {
                return this.RedirectToErrorPage(listFoodVM.ErrorMessage);
            }
            ViewBag.FoodVMs = listFoodVM.PayLoad.Items;

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;

            return View(createVM);
        }

        // GET: CartsController/Edit/5
        public async Task<ActionResult> EditAsync(int id)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                string returnUrl = this.Url.ActionLink("Edit", values: new { @id = id });
                return this.RedirectToLoginPage(returnUrl);
            }

            var result = await _promotionServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            var listFoodVM = await _foodServices.GetAllPaging(new PagingRequestBase { PageNumber = 1 }, this.GetTokenFromCookie());
            if (!listFoodVM.IsSuccessed)
            {
                return this.RedirectToErrorPage(listFoodVM.ErrorMessage);
            }
            ViewBag.FoodVMs = listFoodVM.PayLoad.Items;

            var vm = _mapper.Map<PromotionVM, PromotionEditVM>(result.PayLoad);
            
            return View(vm);
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync([FromForm] PromotionEditVM editVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(editVM);
            }

            var rs = await _promotionServices.Edit(editVM.ID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Promotion edit succesed!";
                return RedirectToAction("Details", new { id = editVM.ID });
            }

            var listFoodVM = await _foodServices.GetAllPaging(new PagingRequestBase { PageNumber = 1 }, this.GetTokenFromCookie());
            if (!listFoodVM.IsSuccessed)
            {
                return this.RedirectToErrorPage(listFoodVM.ErrorMessage);
            }
            ViewBag.FoodVMs = listFoodVM.PayLoad.Items;

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(editVM);
        }

        // GET: CartsController/Delete/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> DeleteAsync(int id)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var result = await _promotionServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CartsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> Delete(int id)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }


            var result = await _promotionServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = result.ErrorMessage;
                return View(result.PayLoad);
            }

            TempData[AppConfigs.SuccessMessageString] = "Promotion delete succesed";
            return RedirectToAction("Index");
        }
    }
}
