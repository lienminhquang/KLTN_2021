using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Inferstructer
{
    public class ApiResult<T>
    {
        public T PayLoad { get; set; }
        public bool IsSuccessed { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class SuccessedResult<T> : ApiResult<T>
    {
        public SuccessedResult()
        {

        }

        public SuccessedResult(T payload)
        {
            PayLoad = payload;
            IsSuccessed = true;
            ErrorMessage = null;
        }
    }

    public class FailedResult<T> : ApiResult<T>
    {
        public FailedResult()
        {

        }

        public FailedResult(string message)
        {
            IsSuccessed = false;
            ErrorMessage = message;
        }
    }
}
