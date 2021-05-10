using AutoMapper;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.OrderDetails;
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
            //CreateMap<FoodCreateVM, Food>();
           // CreateMap<FoodEditVM, FoodVM>();

            CreateMap<OrderDetail, OrderDetailVM>();
            CreateMap<OrderDetailCreateVM, OrderDetail>();
            //CreateMap<OrderDetailCreateVM, OrderDetail>();

        }
    }
}
