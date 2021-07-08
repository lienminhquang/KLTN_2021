using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.OrderDetails;
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
    public class OrderDetailsController : Controller
    {
        private readonly OrderDetailServices _oDServices;
        private readonly IMapper _mapper;
        private readonly AdminUserService _adminUserService;

        public OrderDetailsController(OrderDetailServices oDServices, IMapper mapper, AdminUserService adminUserService)
        {
            _oDServices = oDServices;
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
            var vm = await _oDServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(int orderID, int foodID)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var vm = await _oDServices.GetByID(orderID, foodID, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Create
        [Authorize(Roles = RoleTypes.Admin)]
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
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> CreateAsync([FromForm] OrderDetailCreateVM createVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(createVM);
            }

            var rs = await _oDServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "OrderDetail create succesed!";
                return RedirectToAction("Details", new { orderID = rs.PayLoad.OrderID, foodID = rs.PayLoad.FoodID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(createVM);
        }

        // GET: CartsController/Edit/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync(int orderID, int foodID)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            var result = await _oDServices.GetByID(orderID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            var vm = result.PayLoad;

            return View(_mapper.Map<OrderDetailVM, OrderDetailEditVM>(vm));
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync([FromForm] OrderDetailEditVM editVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(editVM);
            }

            var rs = await _oDServices.Edit(editVM.OrderID, editVM.FoodID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "OrderDetail edit successed!";
                return RedirectToAction("Details", new { orderID = rs.PayLoad.OrderID, foodID = rs.PayLoad.FoodID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(editVM);
        }

        // GET: CartsController/Delete/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> DeleteAsync(int orderID, int foodID)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }
            var result = await _oDServices.GetByID(orderID, foodID, this.GetTokenFromCookie());
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
        public async Task<ActionResult> Delete(int orderID, int foodID)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }


            var result = await _oDServices.Delete(orderID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }
            TempData[AppConfigs.SuccessMessageString] = "OrderDetail delete succesed!";
            return RedirectToAction("Index");
        }
    }
}
