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
                return View(carts.ErrorMessage);
            }

            return View(carts.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(Guid userID, int foodID)
        {
            var cart = await _cartServices.GetByID(userID, foodID, this.GetTokenFromCookie());

            if (!cart.IsSuccessed)
            {
                return View(cart.ErrorMessage);
            }

            return View(cart.PayLoad);
        }

        // GET: CartsController/Create
        public ActionResult Create()
        {
            //if (!ValidateTokenInCookie())
            //{
            //    return RedirectToAction("Login", "User");
            //}

            return View();
        }

        // POST: CartsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateAsync([FromBody] CartCreateVM cartCreateVM)
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

            var rs = await _cartServices.Create(cartCreateVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                return RedirectToAction("Index", "Carts");
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        // GET: CartsController/Edit/5
        public async Task<ActionResult> EditAsync(Guid userID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _cartServices.GetByID(userID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
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
        public async Task<ActionResult> EditAsync(Guid userID, int foodID, [FromBody] CartEditVM cartEditVM)
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

            var rs = await _cartServices.EditCart(userID, foodID, cartEditVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                return View(rs.PayLoad);
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        // GET: CartsController/Delete/5
        public async Task<ActionResult> DeleteAsync(Guid userID, int foodID, [FromBody] CartVM cartVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }
            var result = await _cartServices.GetByID(userID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CartsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteAsync(Guid userID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _cartServices.Delete(userID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            return RedirectToAction("Index", "Carts");
        }
    }
}
