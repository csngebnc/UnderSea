using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Validation.ProblemDetails
{
    public class ErrorBodyProblemDetails : Microsoft.AspNetCore.Mvc.ProblemDetails
    {
        public ErrorBodyProblemDetails()
        {
            this.Errors = new Dictionary<string, ICollection<string>>();
        }
        public Dictionary<string, ICollection<string>> Errors { get; set; }

    }
}
