using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class SaleCampaignFood
    {
        public int FoodID { get; set; }
        public int SaleCampaignID { get; set; }

        public SaleCampaign SaleCampaign { get; set; }
        public Food Food { get; set; }
    }
}
