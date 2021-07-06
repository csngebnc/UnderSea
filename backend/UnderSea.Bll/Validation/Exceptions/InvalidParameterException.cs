using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Validation.Exceptions
{
    public class InvalidParameterException : Exception
    {
        public Dictionary<string, ICollection<string>> Errors { get; private set; }

        public InvalidParameterException()
        {
            this.Errors = new Dictionary<string, ICollection<string>>();
        }

        public InvalidParameterException(string key, string message) : base(message)
        {
            this.Errors = new Dictionary<string, ICollection<string>>();
            this.AddError(key, message);
        }

        public InvalidParameterException(string key, string message, Exception inner)
            : base(message, inner)
        {
            this.Errors = new Dictionary<string, ICollection<string>>();
            this.AddError(key, message);
        }

        public void AddError(string key, string message)
        {
            if (Errors.ContainsKey(key))
            {
                var errors = this.Errors[key];
                errors.Add(message);
                this.Errors[key] = errors;
            }
            else
            {
                var errors = new List<string>();
                errors.Add(message);
                this.Errors.Add(key, errors);
            }
        }
    }
}