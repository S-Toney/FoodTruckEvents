using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FTE.UI.MVC.Startup))]
namespace FTE.UI.MVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
