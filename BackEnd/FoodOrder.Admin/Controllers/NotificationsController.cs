using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Notifications;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    public class NotificationsController : Controller
    {
        private readonly NotificationServices _notiServices;
        private readonly IMapper _mapper;

        public NotificationsController(NotificationServices services, IMapper mapper)
        {
            _notiServices = services;
            _mapper = mapper;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var vm = await _notiServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(int id)
        {
            var vm = await _notiServices.GetByID(id, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Create
        public ActionResult Create()
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            return View();
        }

        // POST: CartsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateAsync([FromForm] NotificationCreateVM createVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(createVM);
            }

            var rs = await _notiServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Notification create succesed!";
                return RedirectToAction("Details", new { id=rs.PayLoad.ID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(createVM);
        }

        //// GET: CartsController/Edit/5
        //public async Task<ActionResult> EditAsync(int id)
        //{
        //    if (!this.ValidateTokenInCookie())
        //    {
        //        return this.RedirectToLoginPage();
        //    }

        //    var result = await _notiServices.GetByID(id, this.GetTokenFromCookie());
        //    if (!result.IsSuccessed)
        //    {
        //        return this.RedirectToErrorPage(result.ErrorMessage);
        //    }

        //    var vm = result.PayLoad;

        //    return View(_mapper.Map<NotificationVM>(vm));
        //}

        //// POST: CartsController/Edit/5
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public async Task<ActionResult> EditAsync([FromForm] RatingEditVM editVM)
        //{
        //    if (!this.ValidateTokenInCookie())
        //    {
        //        return this.RedirectToLoginPage();
        //    }

        //    if (!ModelState.IsValid)
        //    {
        //        return View(editVM);
        //    }

        //    var rs = await _notiServices.Edit(editVM.AppUserID.ToString(), editVM.FoodID, editVM, this.GetTokenFromCookie());
        //    if (rs.IsSuccessed)
        //    {
        //        TempData[AppConfigs.SuccessMessageString] = "Rating edit successed!";
        //        return RedirectToAction("Details", new { userID = rs.PayLoad.AppUserID.ToString(), foodID = rs.PayLoad.FoodID });
        //        //return RedirectToAction("Details", new { userID = rs.PayLoad.AppUserID.ToString(), foodID = rs.PayLoad.FoodID });
        //    }

        //    TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
        //    return View(editVM);
        //}

        // GET: CartsController/Delete/5
        public async Task<ActionResult> DeleteAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            var result = await _notiServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CartsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete([FromForm] NotificationVM model)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            var result = await _notiServices.Delete(model.ID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }
            TempData[AppConfigs.SuccessMessageString] = "Notification delete succesed!";
            return RedirectToAction("Index");
        }
    }
}
