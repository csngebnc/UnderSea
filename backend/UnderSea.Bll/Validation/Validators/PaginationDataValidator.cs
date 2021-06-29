using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Paging;

namespace UnderSea.Bll.Validation
{
    public class PaginationDataValidator : AbstractValidator<PaginationData>
    {
        public PaginationDataValidator()
        {
            RuleFor(x => x.PageSize).InclusiveBetween(1, 50).WithMessage("Az oldal mérete 1 és 50 között kell hogy legyen!");
            RuleFor(x => x.PageNumber).GreaterThan(0).WithMessage("Az oldalszámnak minimum 1-nek kell lennie.");
        }
    }
}
