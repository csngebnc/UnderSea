using FluentValidation;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Validation
{
    public class RegisterValidator : AbstractValidator<RegisterDto>
    {
        private readonly UnderSeaDbContext _context;
        private readonly UserManager<User> _userManager;

        public RegisterValidator(UnderSeaDbContext context, UserManager<User> userManager)
        {
            this._context = context;
            this._userManager = userManager;
            RuleFor(user => user.UserName).NotNull().NotEmpty()
                .MustAsync(async (userName, cancellation) => await UsernameNotExist(userName)).WithMessage("A megadott felhasználónévvel már létezik felhasználó.")
                .Must( (user, cancellation) => UserNameMatchRegex(user.UserName)).WithMessage("A felhasználónévnek legalább 3 karakter hosszúnak kell lenni, és nem tartalmazhat szóközt vagy speciális karaktert.")
                .WithName("userName").OverridePropertyName("userName");
            RuleFor(user => user.Password).NotNull().NotEmpty()
                .Must((user, cancellation) => PasswordMatchRegex(user.Password))
                .WithMessage("A jelszó legalább 6 karakterből kell álljon, valamint tartalmaznia kell legalább egy: kisbetűt, nagybetűt, számot, speciális karaktert (._#$^+=!*()@%&)")
                .WithName("password").OverridePropertyName("password");
            RuleFor(user => user.Password).NotNull().NotEmpty().Equal(u => u.ConfirmPassword).WithMessage("A megadott jelszavaknak egyezni kell.")
                .WithName("password").OverridePropertyName("password");
            RuleFor(user => user.ConfirmPassword).NotNull().WithName("confirmPassword").OverridePropertyName("confirmPassword");
            RuleFor(user => user.CountryName).NotNull().NotEmpty().WithMessage("Az ország nevének megadása kötelező.")
                .WithName("countryName").OverridePropertyName("countryName");
        }

        private async Task<bool> UsernameNotExist(string userName)
            => await _context.Users.Where(u => u.UserName != userName).AnyAsync();

        private bool UserNameMatchRegex(string userName)
        {
            var userNameRegex = new Regex(@"^[-0-9A-Za-z_]{2,}$");

            return userNameRegex.IsMatch(userName) && !userName.Contains(" ") && !userName.Contains(" ");
        }

        private bool PasswordMatchRegex(string password)
        {
            var pwRegex = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[._#$^+=!*()@%&]).{6,}$");

            return pwRegex.IsMatch(password);
        }
    }
}
