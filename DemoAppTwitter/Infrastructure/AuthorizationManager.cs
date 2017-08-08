using System.Linq;
using System.Threading.Tasks;
using Thinktecture.IdentityModel.Owin.ResourceAuthorization;

namespace DemoAppTwitter.Infrastructure
{
    public class AuthorizationManager : ResourceAuthorizationManager
    {

        public override Task<bool> CheckAccessAsync(ResourceAuthorizationContext context)
        {
            switch (context.Resource.First().Value)
            {
                case "admin":
                    return AuthorizeClaims(context);
                case "user":
                    return AuthorizeClaims(context);
                default:
                    return Nok();
            }
        }

        Task<bool> AuthorizeClaims(ResourceAuthorizationContext context)
        {
            switch (context.Action.First().Value)
            {
                case "claims_admin":
                    return Eval(context.Principal.HasClaim(ClaimsHelper.UserTypeClaim, ClaimsHelper.Administrator));
                case "claims_user":
                    return Eval(context.Principal.HasClaim(ClaimsHelper.UserTypeClaim, ClaimsHelper.RegularUser));
                default:
                    return Nok();
            }
        }
    }
}