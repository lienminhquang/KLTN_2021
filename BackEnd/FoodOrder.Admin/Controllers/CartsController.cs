﻿using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Carts;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    public class CartsController : Controller
    {
        private readonly CartServices _cartServices;

        public CartsController(CartServices cartServices)
        {
            _cartServices = cartServices;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var carts = await _cartServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!carts.IsSuccessed)
            {
                return this.RedirectToErrorPage(carts.ErrorMessage);
            }

            return View(carts.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(string userID, int foodID)
        {
            var cart = await _cartServices.GetByID(userID, foodID, this.GetTokenFromCookie());

            if (!cart.IsSuccessed)
            {
                return this.RedirectToErrorPage(cart.ErrorMessage);
            }

            return View(cart.PayLoad);
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
        public async Task<ActionResult> CreateAsync([FromForm] CartCreateVM cartCreateVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(cartCreateVM);
            }

            var rs = await _cartServices.Create(cartCreateVM, this.GetTokenFromCookie());
            if (!rs.IsSuccessed)
            {
                return this.RedirectToErrorPage(rs.ErrorMessage);                
            }

            TempData[AppConfigs.SuccessMessageString] = "User created!";
            return RedirectToAction("Details", new { userID = cartCreateVM.AppUserId, foodID = cartCreateVM.FoodID });
        }

        // GET: CartsController/Edit/5
        public async Task<ActionResult> EditAsync(string userID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            var result = await _cartServices.GetByID(userID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            CartVM cartVM = result.PayLoad;

            return View(new CartEditVM()
            {
                FoodID = cartVM.FoodID,
                AppUserId = cartVM.AppUserId,
                Quantity = cartVM.Quantity
            });
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync([FromForm] CartEditVM cartEditVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(cartEditVM);
            }

            var rs = await _cartServices.EditCart(cartEditVM.AppUserId, cartEditVM.FoodID, cartEditVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Cart edited";
                return RedirectToAction("Details", new { userID = cartEditVM.AppUserId, foodID = cartEditVM.FoodID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(cartEditVM);
        }

        // GET: CartsController/Delete/5
        public async Task<ActionResult> DeleteAsync(string userID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            var result = await _cartServices.GetByID(userID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CartsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(Guid userID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            
            var result = await _cartServices.Delete(userID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                this.RedirectToErrorPage(result.ErrorMessage);
            }

            TempData[AppConfigs.SuccessMessageString] = "Cart deleted!";
            return RedirectToAction("Index", "Carts");
        }
    }
}
