using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Validation.Exceptions
{
    public class NotExistsException : Exception
    {
        public NotExistsException(string message) : base(message)
        {
        }
    }
}
