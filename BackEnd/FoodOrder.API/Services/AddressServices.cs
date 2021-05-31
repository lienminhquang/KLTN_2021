using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Addresses;
using FoodOrder.Data;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class AddressServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<AddressServices> _logger;

        public AddressServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<AddressServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<AddressVM>>> GetAllPaging(PagingRequestBase request)
        {
            var addresses = from c in _dbContext.Addresses
                        select c;

            // Todo: search cart?
            if (!String.IsNullOrEmpty(request.SearchString))
            {
                addresses = addresses.Where(c => c.Name.Contains(request.SearchString)
                || c.AddressString.Contains(request.SearchString));
            }

            addresses = Core.Helpers.Utilities<Address>.Sort(addresses, request.SortOrder, "ID");

            var created = await PaginatedList<AddressVM>.CreateAsync(addresses.Select(a => _mapper.Map<AddressVM>(a)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<AddressVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<AddressVM>>> GetByUserID(string userID)
        {
            var addresses = from c in _dbContext.Addresses
                        where c.AppUserID.ToString() == userID
                        select _mapper.Map<AddressVM>(c);

            var created = await PaginatedList<AddressVM>.CreateAsync(addresses, 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<AddressVM>>(created);
        }

        public ApiResult<AddressVM> GetByID(int id)
        {

            var address = _dbContext.Addresses.Find(id);
            if (address == null)
            {
                return new FailedResult<AddressVM>("Address not found!");
            }
            return new SuccessedResult<AddressVM>(_mapper.Map<AddressVM>(address));
        }

        public async Task<ApiResult<AddressVM>> Create(AddressCreateVM vm)
        {
            if (_dbContext.Users.Find(vm.AppUserID) == null)
            {
                return new FailedResult<AddressVM>("User not found!");
            }

            try
            {
                var result = await _dbContext.Addresses.AddAsync(_mapper.Map<Address>(vm));
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<AddressVM>(_mapper.Map<AddressVM>(result.Entity));
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<AddressVM>("Some thing went wrong!");
            }
            
        }

        

        public async Task<ApiResult<AddressVM>> Edit(int id, AddressEditVM editVM)
        {
            var address = _dbContext.Addresses.Find(id);
            if (address == null)
            {
                return new FailedResult<AddressVM>("Address not found!");
            }
            address.Name = editVM.Name;
            address.AddressString = editVM.AddressString;
            address.AppUserID = editVM.AppUserID;
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<AddressVM>("Some thing went wrong!");
            }

            return new SuccessedResult<AddressVM>(_mapper.Map<AddressVM>(address));
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var addres = _dbContext.Addresses.Find(id);
            if (addres == null)
            {
                return new FailedResult<bool>("Address not found!");
            }
            try
            {
                _dbContext.Addresses.Remove(addres);
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
    }
}
