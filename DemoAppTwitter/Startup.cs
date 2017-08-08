using DemoAppTwitter.Infrastructure;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DemoAppTwitter.Startup))]
namespace DemoAppTwitter
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            app.UseResourceAuthorization(new AuthorizationManager());
        }
    }
}
