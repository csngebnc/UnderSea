﻿using FluentValidation;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Validation
{
    public class RegisterValidation : AbstractValidator<RegisterDto>
    {
        private readonly UnderSeaDbContext _context;

        public RegisterValidation(UnderSeaDbContext context)
        {
            this._context = context;
            RuleFor(user => user.UserName).NotNull().NotEmpty()
                .MustAsync(async (userName, cancellation) => await UsernameNotExist(userName)).WithMessage("A megadott felhasználónévvel már létezik felhasználó.")
                .Must( (user, cancellation) => NotContainsSpace(user.UserName)).WithMessage("A felhasználónév nem tartalmazhat szóközt.")
                .WithName("userName").OverridePropertyName("userName");
            RuleFor(user => user.Password).NotNull().NotEmpty().Equal(u => u.ConfirmPassword).WithMessage("A megadott jelszavaknak egyezni kell.")
                .WithName("password").OverridePropertyName("password");
            RuleFor(user => user.ConfirmPassword).NotNull().WithName("confirmPassword").OverridePropertyName("confirmPassword");
            RuleFor(user => user.CountryName).NotNull().NotEmpty().WithMessage("Az ország nevének megadása kötelező.")
                .WithName("countryName").OverridePropertyName("countryName");
        }

        private async Task<bool> UsernameNotExist(string userName)
            => await _context.Users.Where(u => u.UserName != userName).AnyAsync();

        private bool NotContainsSpace(string userName)
            => !userName.Contains(" ") ;
    }
}
