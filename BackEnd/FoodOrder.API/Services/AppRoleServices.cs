using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.AppRoles;
using FoodOrder.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
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

        public AppRoleServices(ApplicationDBContext applicationDBContext, IMapper mapper, RoleManager<AppRole> roleManager)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _roleManager = roleManager;
        }

        public async Task<ApiResult<PaginatedList<AppRoleVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vms = from c in _dbContext.AppRoles select c;


            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vms = vms.Where(c => c.Name.Contains(request.SearchString)
                || c.Description.Contains(request.SearchString));
            }

            if (!String.IsNullOrEmpty(request.SortOrder))
            {
                vms = Core.Helpers.Utilities<AppRole>.Sort(vms, request.SortOrder, "Name");
            }

            var created = await PaginatedList<AppRoleVM>.CreateAsync(vms.Select(f => _mapper.Map<AppRole, AppRoleVM>(f)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<AppRoleVM>>(created);
        }

        public async Task<ApiResult<AppRoleVM>> GetByID(Guid id)
        {
            var c = await _roleManager.FindByIdAsync(id.ToString());
            if (c == null)
            {
                return new FailedResult<AppRoleVM>("Role not found!");
            }
            return new SuccessedResult<AppRoleVM>(_mapper.Map<AppRoleVM>(c));
        }

        public async Task<ApiResult<AppRoleVM>> Create(AppRoleCreateVM vm)
        {
            AppRole appRole = _mapper.Map<AppRole>(vm);
            var result = await _roleManager.CreateAsync(appRole);
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<AppRoleVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<AppRoleVM>(_mapper.Map<AppRoleVM>(appRole));
        }

        public async Task<ApiResult<AppRoleVM>> Edit(Guid id, AppRoleEditVm editVM)
        {
            var vm = await _dbContext.AppRoles.FirstOrDefaultAsync(c => c.Id == id);
            if (vm == null)
            {
                return new FailedResult<AppRoleVM>("AppRole not found!");
            }
            vm.Name = editVM.Name;
            vm.Description = editVM.Description;

            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<AppRoleVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<AppRoleVM>(_mapper.Map<AppRoleVM>(vm));
        }

        public async Task<ApiResult<bool>> Delete(Guid id)
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
                return new FailedResult<bool>(rs.Errors.ToString());
            }
            return new SuccessedResult<bool>(true);
        }
    }
}
