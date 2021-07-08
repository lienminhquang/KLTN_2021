using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Addresses;
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
    public class AddressesController : Controller
    {
        private readonly AddressServices _addressServices;
        private readonly IMapper _mapper;
        private readonly AdminUserService _adminUserService;

        public AddressesController(AddressServices services, IMapper mapper, AdminUserService adminUserService)
        {
            _addressServices = services;
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
            var vm = await _addressServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
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
            var vm = await _addressServices.GetByID(id, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Create
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> Create()
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            return View();
        }

        // POST: CartsController/Create
        [HttpPost]
        //[ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> CreateAsync([FromForm] AddressCreateVM createVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(createVM);
            }

            var rs = await _addressServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = " Address create succesed!";
                return RedirectToAction("Details", new { id = rs.PayLoad.ID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(createVM);
        }

        // GET: CartsController/Edit/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync(int id)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            var result = await _addressServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            var vm = result.PayLoad;

            return View(_mapper.Map<AddressEditVM>(vm));
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        //[ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> EditAsync([FromForm] AddressEditVM editVM)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(editVM);
            }

            var rs = await _addressServices.Edit(editVM.ID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = " Address edit successed!";
                return RedirectToAction("Details", new { id = rs.PayLoad.ID });
                //return RedirectToAction("Details", new { userID = rs.PayLoad.AppUserID.ToString(), foodID = rs.PayLoad.FoodID });
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
            var result = await _addressServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CartsController/Delete/5
        [HttpPost]
        //[ValidateAntiForgeryToken]
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> Delete([FromForm] AddressVM model)
        {
            if (!await this.ValidateTokenInCookie(_adminUserService))
            {
                return this.RedirectToLoginPage();
            }

            var result = await _addressServices.Delete(model.ID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }
            TempData[AppConfigs.SuccessMessageString] = "Address delete succesed!";
            return RedirectToAction("Index");
        }
    }
}
