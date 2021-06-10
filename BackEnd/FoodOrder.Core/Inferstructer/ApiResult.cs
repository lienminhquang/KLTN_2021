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
        public string ErrorCode { get; set; }

        public static string TokenExpiredCode = "TokenExpiredCode";
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

        public FailedResult(string message, string errorCode = null)
        {
            IsSuccessed = false;
            ErrorMessage = message;
            ErrorCode = errorCode;
        }
    }
}
