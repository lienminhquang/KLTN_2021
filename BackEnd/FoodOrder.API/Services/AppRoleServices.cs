using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.AppRoles;
using FoodOrder.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class AppRoleServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly RoleManager<AppRole> _roleManager;
        private readonly ILogger<AppRoleServices> _logger;

        public AppRoleServices(ApplicationDBContext applicationDBContext, IMapper mapper, RoleManager<AppRole> roleManager, ILogger<AppRoleServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _roleManager = roleManager;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<AppRoleVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vms = from c in _dbContext.AppRoles where c.IsDeleted == false 
                      select c;


            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vms = vms.Where(c => c.Name.Contains(request.SearchString)
                || c.Description.Contains(request.SearchString));
            }

            if (!String.IsNullOrEmpty(request.SortOrder))
            {
                vms = Core.Helpers.Utilities<AppRole>.Sort(vms, request.SortOrder, "Name");
            }

            var created = await PaginatedList<AppRoleVM>.CreateAsync(vms.Select(f => _mapper.Map<AppRole, AppRoleVM>(f)), request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            return new SuccessedResult<PaginatedList<AppRoleVM>>(created);
        }

        public async Task<ApiResult<AppRoleVM>> GetByID(Guid id)
        {
            var c = await _roleManager.FindByIdAsync(id.ToString());
            if (c == null || c.IsDeleted)
            {
                return new FailedResult<AppRoleVM>("Role not found!");
            }
           


            return new SuccessedResult<AppRoleVM>();
        }

        public async Task<ApiResult<AppRoleVM>> Create(AppRoleCreateVM vm)
        {
            AppRole appRole = _mapper.Map<AppRole>(vm);
            try
            {
                var result = await _roleManager.CreateAsync(appRole);
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<AppRoleVM>(_mapper.Map<AppRoleVM>(appRole));
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<AppRoleVM>("Some thing went wrong");
            }
            
        }

        public async Task<ApiResult<AppRoleVM>> Edit(Guid id, AppRoleEditVm editVM)
        {
            var vm = _dbContext.AppRoles.Find(id);
            if (vm == null || vm.IsDeleted)
            {
                return new FailedResult<AppRoleVM>("AppRole not found!");
            }
            
            try
            {
                vm.Name = editVM.Name;
                vm.Description = editVM.Description;
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<AppRoleVM>("Some thing went wrong!");
            }

            return new SuccessedResult<AppRoleVM>(_mapper.Map<AppRoleVM>(vm));
        }

        public async Task<ApiResult<bool>> Delete(Guid id)
        {
            var role = await _dbContext.AppRoles.FirstOrDefaultAsync(c => c.Id == id);
            if (role == null || role.IsDeleted)
            {
                return new FailedResult<bool>("AppRole not found!");
            }

            try
            {
                role.IsDeleted = true;
                role.TimeDeleted = DateTime.Now;
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<bool>(e.Message);
            }
           
            return new SuccessedResult<bool>(true);
        }

        public async Task<ApiResult<bool>> DeletePermanently(Guid id)
        {
            var food = await _dbContext.AppRoles.FirstOrDefaultAsync(c => c.Id == id);
            if (food == null)
            {
                return new FailedResult<bool>("AppRole not found!");
            }

            var rs = await _roleManager.DeleteAsync(food);
            await _dbContext.SaveChangesAsync();

            if (!rs.Succeeded)
            {
                _logger.LogError(rs.Errors.ToString());
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
    }
}
