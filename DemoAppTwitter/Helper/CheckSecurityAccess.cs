using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoAppTwitter.Helper
{
    public class CheckSecurityAccess
    {

        public static bool UserVisible
        {
            get
            {
                return
                   HttpContext.Current.User != null &&
                   HttpContext.Current.User.Identity.IsAuthenticated && HttpContext.Current.User.Identity.UserType() == ClaimsHelper.RegularUser;
            }
        }

        public static bool ManagerVisible
        {
            get
            {
                return
                   HttpContext.Current.User != null &&
                   HttpContext.Current.User.Identity.IsAuthenticated && HttpContext.Current.User.Identity.UserType() == ClaimsHelper.Administrator;
            }
        }
    }
}