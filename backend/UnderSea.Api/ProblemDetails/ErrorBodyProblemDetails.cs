using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Api.ProblemDetails
{
    public class ErrorBodyProblemDetails : Microsoft.AspNetCore.Mvc.ProblemDetails
    {
        public ErrorBodyProblemDetails()
        {
            Errors = new Dictionary<string, ICollection<string>>();
        }
        public Dictionary<string, ICollection<string>> Errors { get; set; }

    }
}
