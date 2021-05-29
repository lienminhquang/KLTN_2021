﻿using FoodOrder.API.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.SaleCampaigns;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SaleCampaignsController : ControllerBase
    {
        private readonly SaleCampaignServices _saleCampaignServices;

        public SaleCampaignsController(SaleCampaignServices saleServices)
        {
            _saleCampaignServices = saleServices;
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> GetByID(int id)
        {
            var result = await _saleCampaignServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] SaleCampaignCreateVM createVM)
        {
            var result = await _saleCampaignServices.Create(createVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPut]
        public async Task<IActionResult> Edit(int id, [FromBody] SaleCampaignEditVM editVM)
        {
            // Todo: please handle this kind of error
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _saleCampaignServices.Edit(id, editVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _saleCampaignServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet]
        // TODO: return the sortorder, currentfilter, pagenumber to the client.
        public async Task<IActionResult> GetAllPaging([FromQuery] PagingRequestBase request)
        {
            var result = await _saleCampaignServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
        
        [HttpGet("valid")]
        // TODO: return the sortorder, currentfilter, pagenumber to the client.
        public async Task<IActionResult> GetAllValidPaging([FromQuery] PagingRequestBase request)
        {
            var result = await _saleCampaignServices.GetAllValidPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }

}
