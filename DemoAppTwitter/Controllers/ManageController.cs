using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using DemoAppTwitter.Models;
using System.Collections.Generic;
using System.Security.Claims;
using Thinktecture.IdentityModel.Mvc;
using Demo.Dao.Repository;

namespace DemoAppTwitter.Controllers
{
    [Authorize]
    public class ManageController : Controller
    {
        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;
        private ITwitterUserRepository _userRepository = new TwitterUserRepository();
        public ManageController()
        {
        }

        public ManageController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;
        }

        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            private set 
            { 
                _signInManager = value; 
            }
        }

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        [ResourceAuthorize("claims_admin", "admin")]
        public ActionResult UserManagement()
        {
            ViewData["Message"] = "Your application description page.";

            List<UserViewModel> model = UserManager.Users.Select(u => new UserViewModel
            {
                Id = u.Id,
                Email = u.Email
            }).ToList();
            ;
            //remove current user logged in           
            model.RemoveAll(x => x.Email == User.Identity.GetUserName());

            return View(model);
        }

        [HttpGet]
        public ActionResult AddUser()
        {
            UserViewModel model = new UserViewModel();
            return View(model);
        }

        [HttpPost]
        public async Task<ActionResult> AddUser(UserViewModel model)
        {
            if (ModelState.IsValid)
            {
                ApplicationUser user = new ApplicationUser
                {
                    UserName = model.Email,
                    Email = model.Email,
                    
                };
                user.UserType = ClaimsHelper.RegularUser;
                IdentityResult result = await UserManager.CreateAsync(user, model.Password);
                if (result.Succeeded)
                {
                    var userIdentity = await user.GenerateUserIdentityAsync((ApplicationUserManager)UserManager);
                    userIdentity.AddClaim(new Claim(ClaimsHelper.UserTypeClaim, ClaimsHelper.RegularUser));
                    return RedirectToAction("UserManagement");
                }
                AddErrors(result);
            }
            return View(model);
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }
        public async Task<ActionResult> DeleteUser(string id)
        {
            if (!String.IsNullOrEmpty(id))
            {
                ApplicationUser applicationUser = await UserManager.FindByIdAsync(id);
                if (applicationUser != null)
                {

                    //Delete Twitter records
                    _userRepository.Remove(applicationUser.Email);

                    //Delete from UserManager
                    IdentityResult result = await UserManager.DeleteAsync(applicationUser);
                }
            }
            return RedirectToAction("UserManagement");
        }

    }
}