using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Startup))]
namespace Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
