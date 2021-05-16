using AutoMapper;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.AppRoles;
using FoodOrder.Core.ViewModels.Categories;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.Images;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Core.ViewModels.Orders;
using FoodOrder.Core.ViewModels.Promotions;
using FoodOrder.Core.ViewModels.Ratings;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.AutoMapper
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<Food, FoodVM>()
                .ForMember(dest => dest.Name, options => options.MapFrom(source => source.Name));
            CreateMap<FoodCreateVM, Food>();
            CreateMap<FoodEditVM, FoodVM>();
            CreateMap<FoodVM, FoodEditVM>();

            CreateMap<OrderDetail, OrderDetailVM>();
            CreateMap<OrderDetailCreateVM, OrderDetail>();
            CreateMap<OrderDetailVM, OrderDetailEditVM>();

            CreateMap<Category, CategoryVM>();
            CreateMap<CategoryCreateVM, Category>();
            //CreateMap<CategoryVM, CategoryEditVM>();

            CreateMap<Order, OrderVM>();
            CreateMap<OrderCreateVM, Order>();
            CreateMap<OrderVM, OrderEditVM>();

            CreateMap<Promotion, PromotionVM>();
            CreateMap<PromotionCreateVM, Promotion>();
            CreateMap<PromotionVM, PromotionEditVM>();

            CreateMap<Rating, RatingVM>();
            CreateMap<RatingCreateVM, Rating>();
            CreateMap<RatingVM, RatingEditVM>();

            CreateMap<AppRole, AppRoleVM>();
            CreateMap<AppRoleCreateVM, AppRole>();
            CreateMap<AppRoleVM, AppRoleEditVm>();

            CreateMap<Image, ImageVM>();
               // .ForMember(dest => dest.ImageData, options => options.MapFrom<ImageCustomeResolver>());
            CreateMap<ImageCreateVM, Image>();
            CreateMap<ImageVM, ImageEditVM>();
        }

        //private class ImageCustomeResolver : IValueResolver<Image, ImageVM, IFormFile>
        //{
        //    public IFormFile Resolve(Image source, ImageVM destination, IFormFile destMember, ResolutionContext context)
        //    {
                
        //    }
        //}
    }
}
