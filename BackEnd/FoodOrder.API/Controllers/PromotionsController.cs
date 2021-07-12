﻿using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Promotions;
using FoodOrder.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class PromotionsController : ControllerBase
    {
        private readonly PromotionServices _promotionServices;

        public PromotionsController(PromotionServices promotionServices)
        {
            _promotionServices = promotionServices;
        }


        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<IActionResult> GetByID(int id)
        {
            var result = await _promotionServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        [Consumes("multipart/form-data")]
        [ValidTokenRequirement]
        public async Task<IActionResult> Create([FromForm] PromotionCreateVM createVM)
        {
            var result = await _promotionServices.Create(createVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(GetByID), result.PayLoad.ID, result);

        }

        [HttpPut]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        [Consumes("multipart/form-data")]
        [ValidTokenRequirement]
        public async Task<IActionResult> Edit(int id, [FromForm] PromotionEditVM editVM)
        {
            // Todo: please handle this kind of error
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _promotionServices.Edit(id, editVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = PolicyType.Admin )]
        [ValidTokenRequirement]
        public async Task<IActionResult> Delete(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _promotionServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("permanently/{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> DeletePermanently(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _promotionServices.DeletePermanently(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet]
        // TODO: return the sortorder, currentfilter, pagenumber to the client.
        [AllowAnonymous]
        public async Task<IActionResult> GetAllPaging([FromQuery] PagingRequestBase request)
        {
            var result = await _promotionServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("validforuser")]
        [AllowAnonymous]
        public async Task<IActionResult> GetAllValidForUser([FromQuery] PagingRequestBase request, String userID)
        {
            var result = await _promotionServices.GetAllValidForUser(request, userID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("valid")]
        [AllowAnonymous]
        public async Task<IActionResult> GetAllValid([FromQuery] PagingRequestBase request, String userID)
        {
            var result = await _promotionServices.GetAllValid(request, userID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}
