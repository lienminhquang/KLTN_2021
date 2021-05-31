using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Notifications;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class NotificationServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<NotificationServices> _logger;

        public NotificationServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<NotificationServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<NotificationVM>>> GetByUserID(string userID, PagingRequestBase request)
        {
            var vMs = (from n in _dbContext.Notifications
                       where n.UserID.ToString() == userID
                       select n);

            //vMs = Core.Helpers.Utilities<Notification>.Sort(vMs, request.SortOrder, "TimeCreated");

            var created = await PaginatedList<NotificationVM>.CreateAsync(vMs.Select(f => _mapper.Map<NotificationVM>(f)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<NotificationVM>>(created);
        }

        public ApiResult<bool> NotificationReceived(NotificationReceivedVM notificationReceivedVM)
        {
            var vMs = _dbContext.Notifications.Find(notificationReceivedVM.NotificationID);
            if (vMs == null)
            {
                return new FailedResult<bool>("Notification not found");
            }

            if (vMs.UserID.ToString() == notificationReceivedVM.ReceiverID)
            {
                vMs.UserReceived = true;
                return new SuccessedResult<bool>(true);

            }

            return new FailedResult<bool>("User is not match");
        }

        public async Task<ApiResult<PaginatedList<NotificationVM>>> GetUnReceivedByUserID(string userID, PagingRequestBase request)
        {
            var vMs = (from n in _dbContext.Notifications
                       where n.UserID.ToString() == userID && n.UserReceived == false
                       select n);

            //vMs = Core.Helpers.Utilities<Notification>.Sort(vMs, request.SortOrder, "TimeCreated");

            var created = await PaginatedList<NotificationVM>.CreateAsync(vMs.Select(f => _mapper.Map<NotificationVM>(f)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<NotificationVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<NotificationVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vMs = _dbContext.Notifications
               //.Include(f => f.Food) //Todo: is this need for paging?
               //.Include(f => f.Order)
               .AsNoTracking();


            //vMs = Core.Helpers.Utilities<Rating>.Sort(vMs, request.SortOrder, "TimeCreated");

            var created = await PaginatedList<NotificationVM>.CreateAsync(vMs.Select(f => _mapper.Map<NotificationVM>(f)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<NotificationVM>>(created);
        }

        public ApiResult<NotificationVM> GetByID(int id)
        {
            var c = _dbContext.Notifications.Find(id);
            if (c == null)
            {
                return new FailedResult<NotificationVM>("Notification not found!");
            }
            return new SuccessedResult<NotificationVM>(_mapper.Map<NotificationVM>(c));
        }

        public async Task<ApiResult<NotificationVM>> Create(NotificationCreateVM vm)
        {
            var user = _dbContext.AppUsers.Find(vm.UserID);
            if (user == null)
            {
                return new FailedResult<NotificationVM>("User not found!");
            }
            
            try
            {
                var n = _mapper.Map<Notification>(vm);
                n.TimeCreated = DateTime.Now;
                n.UserReceived = false;
                var result = await _dbContext.Notifications.AddAsync(n);
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<NotificationVM>(_mapper.Map<NotificationVM>(result.Entity));
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<NotificationVM>("Some thing went wrong!");
            }
            
        }

        //public async Task<ApiResult<RatingVM>> Edit(Guid userID, int foodID, RatingEditVM editVM)
        //{
        //    var od = await _dbContext.Ratings.FirstOrDefaultAsync(c => c.AppUserID == userID && c.FoodID == foodID);
        //    if (od == null)
        //    {
        //        return new FailedResult<RatingVM>("Rating not found!");
        //    }
        //    od.Comment = editVM.Comment;
        //    od.Star = editVM.Star;
        //    if (od.Star > 5)
        //    {
        //        od.Star = 5;
        //    }
        //    if (od.Star < 0)
        //    {
        //        od.Star = 0;
        //    }
        //    try
        //    {
        //        await _dbContext.SaveChangesAsync();
        //    }
        //    catch (Exception e)
        //    {
        //        return new FailedResult<RatingVM>(e.InnerException.ToString());
        //    }

        //    return new SuccessedResult<RatingVM>(_mapper.Map<RatingVM>(od));
        //}

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var vm = _dbContext.Notifications.Find(id);
            if (vm == null)
            {
                return new FailedResult<bool>("Notification not found!");
            }
            try
            {
                _dbContext.Notifications.Remove(vm);
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
    }
}
