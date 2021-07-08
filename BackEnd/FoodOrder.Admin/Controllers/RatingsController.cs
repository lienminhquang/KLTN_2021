using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Ratings;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    [Authorize(Roles = RoleTypes.ManagerGroup)]
    public class RatingsController : Controller
    {
        private readonly RatingServices _ratingServices;
        private readonly IMapper _mapper;
        private readonly AdminUserService _adminUserService;

        public RatingsController(RatingServices services, IMapper mapper, AdminUserService adminUserService)
        {
            _ratingServices = services;
            _mapper = mapper;
            _adminUserService = adminUserService;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var vm = await _ratingServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        public async Task<ActionResult> DetailsAsync([FromQuery] int orderID, [FromQuery] int foodID)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var vm = await _ratingServices.GetByID(orderID, foodID, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Create
        public async Task< ActionResult >Create()
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            return View();
        }

        // POST: CartsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateAsync([FromForm] RatingCreateVM createVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(createVM);
            }

            var rs = await _ratingServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Rating create succesed!";
                return RedirectToAction("Details", new { orderID = rs.PayLoad.OrderID, foodID = rs.PayLoad.FoodID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(createVM);
        }

        // GET: CartsController/Edit/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync([FromQuery] int orderID, [FromQuery] int foodID)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            var result = await _ratingServices.GetByID(orderID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            var vm = result.PayLoad;

            return View(_mapper.Map<RatingVM, RatingEditVM>(vm));
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync([FromForm] RatingEditVM editVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(editVM);
            }

            var rs = await _ratingServices.Edit(editVM.OrderID, editVM.FoodID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Rating edit successed!";
                return RedirectToAction("Details", new { id = rs.PayLoad.OrderID });
                //return RedirectToAction("Details", new { userID = rs.PayLoad.AppUserID.ToString(), foodID = rs.PayLoad.FoodID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(editVM);
        }

        // GET: CartsController/Delete/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> DeleteAsync([FromQuery] int orderID, [FromQuery] int foodID)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var result = await _ratingServices.GetByID(orderID, foodID, this.GetTokenFromCookie());
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
        public async Task<ActionResult> Delete([FromForm] RatingVM model)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            var result = await _ratingServices.Delete(model.OrderID, model.FoodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }
            TempData[AppConfigs.SuccessMessageString] = "Rating delete succesed!";
            return RedirectToAction("Index");
        }
    }
}
