using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Models;

namespace Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Controllers
{
    public class TinTucController : Controller
    {
        //
        // GET: /TinTuc/
        QLDTDataContext db = new QLDTDataContext();
        public ActionResult TinTucList()
        {
            var list = db.TINTUCs.OrderBy(t => t.TENTIEUDE).ToList();
            return View(list);
        }
    }
}