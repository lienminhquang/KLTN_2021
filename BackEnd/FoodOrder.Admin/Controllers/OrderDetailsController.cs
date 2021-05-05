using AutoMapper;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.OrderDetails;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    public class OrderDetailsController : Controller
    {
        private readonly OrderDetailServices _oDServices;
        private readonly IMapper _mapper;

        public OrderDetailsController(OrderDetailServices oDServices, IMapper mapper)
        {
            _oDServices = oDServices;
            _mapper = mapper;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var vm = await _oDServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {
                return View(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync(int orderID, int foodID)
        {
            var vm = await _oDServices.GetByID(orderID, foodID, this.GetTokenFromCookie());

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
        public async Task<ActionResult> CreateAsync([FromForm] OrderDetailCreateVM createVM)
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

            var rs = await _oDServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                // Todo: redirect to details instead?
                return RedirectToAction("Index", "OrderDetails");
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        // GET: CartsController/Edit/5
        public async Task<ActionResult> EditAsync(int orderID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _oDServices.GetByID(orderID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            var vm = result.PayLoad;

            return View(_mapper.Map<OrderDetailEditVM>(vm));
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync([FromForm] OrderDetailEditVM editVM)
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

            var rs = await _oDServices.Edit(editVM.OrderID, editVM.FoodID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                return View(rs.PayLoad);
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        // GET: CartsController/Delete/5
        public async Task<ActionResult> DeleteAsync(int orderID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }
            var result = await _oDServices.GetByID(orderID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            return View(result.PayLoad);
        }

        // POST: CartsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(int orderID, int foodID)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }


            var result = await _oDServices.Delete(orderID, foodID, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }
            return RedirectToAction("Index", "Foods");
        }
    }
}
