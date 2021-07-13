using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Orders;
using FoodOrder.Core.ViewModels.OrderStatuses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    [Authorize(Roles = RoleTypes.ManagerGroup)]
    public class OrdersController : Controller
    {
        private readonly OrderServices _orderServices;

        private readonly IMapper _mapper;
        private readonly OrderStatusServices _orderStatusServices;
        private readonly AdminUserService _adminUserService;

        public OrdersController(OrderServices services, IMapper mapper, OrderStatusServices orderStatusServices, AdminUserService adminUserService)
        {
            _orderServices = services;
            _mapper = mapper;
            _orderStatusServices = orderStatusServices;
            _adminUserService = adminUserService;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            var vm = await _orderServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = vm.ErrorMessage;
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            var vm = await _orderServices.GetByID(id, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            var orderStatuses = await _orderStatusServices.GetAllPaging(new PagingRequestBase() { PageNumber = 1 }, this.GetTokenFromCookie());

           if(orderStatuses.IsSuccessed)
            {
                List < OrderStatusVM > orderStatusVMs= orderStatuses.PayLoad.Items;
                SelectList selectListItems = new SelectList(orderStatusVMs, "ID", "Name", vm.PayLoad.OrderStatusID);
                ViewBag.OrderStatusList = selectListItems;
            }

            return View(vm.PayLoad);
        }



        // GET: CartsController/Create
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task< ActionResult> Create()
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
        public async Task<ActionResult> CreateAsync([FromForm] OrderCreateVM createVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(createVM);
            }

            var rs = await _orderServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Order create succesed!";
                return RedirectToAction("Details", new { id = rs.PayLoad.ID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(createVM);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ChangeStatus([FromForm] ChangeOrderStatusVM changeOrderStatus)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            //if (!ModelState.IsValid)
            //{
            //    return View(createVM);
            //}

            var rs = await _orderServices.ChangeOrderStatus(changeOrderStatus, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Order status changed!";
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return RedirectToAction("Details", new { id = changeOrderStatus.ID });
        }

        // GET: CartsController/Edit/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync(int id)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                string returnUrl = this.Url.ActionLink("Edit", values: new { @id = id });
                return this.RedirectToLoginPage(returnUrl);
            }

            var result = await _orderServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            var vm = result.PayLoad;
            return View(_mapper.Map<OrderVM, OrderEditVM>(vm));
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync([FromForm] OrderEditVM editVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(editVM);
            }

            var rs = await _orderServices.Edit(editVM.ID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Order edit succesed!";
                return RedirectToAction("Details", new { id = editVM.ID });
            }

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
            var result = await _orderServices.GetByID(id, this.GetTokenFromCookie());
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


            var result = await _orderServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            TempData[AppConfigs.SuccessMessageString] = "Order delete succesed";
            return RedirectToAction("Index");
        }
    }
}
