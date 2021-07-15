using IdentityModel;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;
using UnderSea.Model.Models.Joins;

namespace UnderSea.Api.Pages.Account
{
    public class RegisterModel : PageModel
    {
        private readonly UserManager<User> userManager;
        private readonly UnderSeaDbContext _context;
        private readonly ICountryService countryService;

        [Required(ErrorMessage = "Kötelezõ")]
        [BindProperty]
        public string Username { get; set; } = "";

        [Required(ErrorMessage = "Kötelezõ")]
        [MinLength(6, ErrorMessage = "A jelszónak legalább 6 karakterbõl kell állnia")]
        [BindProperty]
        public string Password { get; set; } = "";

        [Required(ErrorMessage = "Kötelezõ")]
        [BindProperty]
        public string ConfirmPassword { get; set; } = "";

        [Required(ErrorMessage = "Kötelezõ")]
        [MinLength(3, ErrorMessage = "Az ország nevének legalább 3 karakterbõl kell állnia")]
        [BindProperty]
        public string CountryName { get; set; } = "";

        [BindProperty]
        public string ReturnUrl { get; set; } = "";

        public RegisterModel(UserManager<User> userManager, UnderSeaDbContext context, ICountryService countryService)
        {
            this.userManager = userManager;
            this._context = context;
            this.countryService = countryService;
        }

        public void OnGet(string returnUrl)
        {
            ReturnUrl = returnUrl;
        }

        public async Task<IActionResult> OnPostAsync(string action)
        {
            if (action == "login")
            {
                return Redirect(ReturnUrl);
            }

            await ValidateFieldsAsync();

            if (ModelState.IsValid)
            {
                var user = new User
                {
                    UserName = Username
                };

                var createResult = await userManager.CreateAsync(user, Password);
                if (createResult.Succeeded)
                {
                    await userManager.AddClaimAsync(user, new Claim(JwtClaimTypes.Subject, user.Id.ToString()));
                    await userManager.AddClaimAsync(user, new Claim(JwtClaimTypes.Name, user.UserName));
                    await userManager.AddClaimAsync(user, new Claim(JwtClaimTypes.Id, user.Id.ToString()));
                    await countryService.CreateCountryWithMaterials(CountryName, user.Id);
                    return Redirect(ReturnUrl);
                }
                else
                {
                    AddModelErrorsForField(nameof(Username), createResult);
                    AddModelErrorsForField(nameof(Password), createResult);
                    AddModelErrorsForField(nameof(CountryName), createResult);
                }
            }

            return Page();
        }

        private void AddModelErrorsForField(string fieldName, IdentityResult identityResult)
        {
            foreach (var error in identityResult.Errors.Where(x => x.Code.ToLower().Contains(fieldName.ToLower())))
            {
                ModelState.AddModelError(fieldName, error.Description);
            }
        }

        private async Task ValidateFieldsAsync()
        {
            var usernameTaken = Username != null && await _context.Users.AnyAsync(x => x.UserName == Username);

            if (usernameTaken)
            {
                ModelState.AddModelError(nameof(Username), "A felhasználónév már foglalt!");
            }

            if(CountryName == null)
            {
                ModelState.AddModelError(nameof(CountryName), "A városnév megadása kötelezõ!");
            }

            if (ConfirmPassword != Password)
            {
                ModelState.AddModelError(nameof(ConfirmPassword), "A megadott jelszavak nem egyeznek!");
            }
        }
    }
}
