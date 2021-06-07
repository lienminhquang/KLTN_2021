using AutoMapper;
using FoodOrder.Admin.Configs;
using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    [Authorize(Roles = RoleTypes.ManagerGroup)]
    public class FoodsController : Controller
    {
        private readonly FoodServices _foodServices;
        private readonly CategoryServices _categoryServices;
        private readonly RatingServices _ratingServices;
        private readonly IMapper _mapper;

        public FoodsController(FoodServices foodServices, IMapper mapper, CategoryServices categoryServices, RatingServices ratingServices)
        {
            _foodServices = foodServices;
            _mapper = mapper;
            _categoryServices = categoryServices;
            _ratingServices = ratingServices;
        }
        // GET: CartsController
        public async Task<ActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            var vm = await _foodServices.GetAllPaging(request, this.GetTokenFromCookie());

            if (!vm.IsSuccessed)
            {

                //TempData[AppConfigs.ErrorMessageString] = vm.ErrorMessage;
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Details/5
        public async Task<ActionResult> DetailsAsync([FromRoute]int id, [FromQuery] PagingRequestBase request)
        {
            var vm = await _foodServices.GetByID(id, this.GetTokenFromCookie());
            var ratings = await _ratingServices.GetRatingOfFood(id, request, this.GetTokenFromCookie());
            if(ratings.IsSuccessed == false)
            {
                TempData[AppConfigs.ErrorMessageString] = ratings.ErrorMessage;
            }
            else
            {
                ViewBag.RatingVMs = ratings.PayLoad;
            }


            if (!vm.IsSuccessed)
            {
                return this.RedirectToErrorPage(vm.ErrorMessage);
            }

            return View(vm.PayLoad);
        }

        // GET: CartsController/Create
        public async Task<ActionResult> CreateAsync()
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            var result = await _categoryServices.GetAllPaging(new PagingRequestBase(), this.GetTokenFromCookie());
            if(!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }
            
            List<SelectListItem> items = result.PayLoad.Items.Select(i => new SelectListItem() { Text = i.Name , Value = i.ID.ToString() }).ToList();
            List<string> ids = result.PayLoad.Items.Select(i => i.ID.ToString()).ToList();
            MultiSelectList selectList = new MultiSelectList(items, "Value", "Text");

            FoodCreateVM foodCreateVM = new FoodCreateVM();

            foodCreateVM.Categories = selectList;
            foodCreateVM.CategoryIDs = ids;

            return View(foodCreateVM);
        }

        // POST: CartsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult> CreateAsync([FromForm] FoodCreateVM createVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(createVM);
            }

            var rs = await _foodServices.Create(createVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                var fcResult = await _foodServices.AddFoodToCategories(rs.PayLoad.ID, createVM.CategoryIDs, this.GetTokenFromCookie());
                if(fcResult.IsSuccessed == false)
                {
                    TempData[AppConfigs.ErrorMessageString] = fcResult.ErrorMessage;
                    return View(createVM);
                }

                TempData[AppConfigs.SuccessMessageString] = "Food created!";
                return RedirectToAction("Details", new { id = rs.PayLoad.ID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(createVM);
        }
        
        public async Task<ActionResult> EditAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                string returnUrl = this.Url.ActionLink("Edit", values: new { @id = id });
                return this.RedirectToLoginPage(returnUrl);
            }

            var result = await _foodServices.GetByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            var categoryResult = await _categoryServices.GetAllPaging(new PagingRequestBase(), this.GetTokenFromCookie());
            if (!categoryResult.IsSuccessed)
            {
                return this.RedirectToErrorPage(categoryResult.ErrorMessage);
            }

            FoodEditVM foodEditVM = _mapper.Map<FoodVM, FoodEditVM>(result.PayLoad);
            List<string> listCategory = result.PayLoad.CategoryVMs.Select(c => c.ID.ToString()).ToList();
            foodEditVM.CategoryIDs = listCategory;

            List<SelectListItem> items = categoryResult.PayLoad.Items.Select(i => new SelectListItem() 
            { Text = i.Name, Value = i.ID.ToString(), Selected = listCategory.Contains(i.ID.ToString()) }).ToList();
            foodEditVM.Categories = new MultiSelectList(items, "Value", "Text");


            return View(foodEditVM);
        }

        // POST: CartsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult> EditAsync([FromForm] FoodEditVM editVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(editVM);
            }

            var fcResult = await _foodServices.DeleteFoodFromAllCategory(editVM.ID, this.GetTokenFromCookie());
            if(!fcResult.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = fcResult.ErrorMessage;
                return View(editVM);
            }

            var fcAddResult = await _foodServices.AddFoodToCategories(editVM.ID, editVM.CategoryIDs, this.GetTokenFromCookie());
            if (fcResult.IsSuccessed == false)
            {
                TempData[AppConfigs.ErrorMessageString] = fcAddResult.ErrorMessage;
                return View(editVM);
            }

            var rs = await _foodServices.Edit(editVM.ID, editVM, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "Food edit succesed!";
                return RedirectToAction("Details", new { id = editVM.ID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(editVM);
        }

        // GET: CartsController/Delete/5
        [Authorize(Roles = RoleTypes.Admin)]
        public async Task<ActionResult> DeleteAsync(int id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            var result = await _foodServices.GetByID(id, this.GetTokenFromCookie());
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
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }


            var result = await _foodServices.Delete(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = result.ErrorMessage;
                return View(result.PayLoad);
            }

            TempData[AppConfigs.SuccessMessageString] = "Food delete succesed";
            return RedirectToAction("Index", "Foods");
        }
    }
}
