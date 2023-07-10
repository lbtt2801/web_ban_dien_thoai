using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Models;

namespace Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Controllers
{
    public class SanPhamController : Controller
    {
        QLDTDataContext db = new QLDTDataContext();
        //
        // GET: /SanPham/
        public ActionResult ShowAllSanPham()
        {
            var listSanPham = db.SANPHAMs.OrderBy(t => t.TENSP).ToList();
            return View(listSanPham);
        }
        public ActionResult ChiTietSanPham(string maSP)
        {
            var list = db.SANPHAMs.Single(l => l.MASP.Equals(maSP));
            return View(list);
        }
        public ActionResult SearchSanPham(string tenSP)
        {
            var list = db.SANPHAMs.Where(sp => sp.TENSP.Contains(tenSP)).ToList();
            ViewBag.TongSL = list.Count;
            return View(list);
        }

        public ActionResult ShowNokia()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 1).ToList();
            return View(listSanPham);
        }

        public ActionResult ShowSamSung()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 2).ToList();
            return View(listSanPham);
        }

        public ActionResult ShowOppo()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 3).ToList();
            return View(listSanPham);
        }
        public ActionResult ShowXiaomi()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 4).ToList();
            return View(listSanPham);
        }
        public ActionResult ShowIphone()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 5).ToList();
            return View(listSanPham);
        }
        public ActionResult ShowLoa()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 6).ToList();
            return View(listSanPham);
        }
        public ActionResult ShowTaiNghe()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 7).ToList();
            return View(listSanPham);
        }
        public ActionResult ShowTheNho()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 8).ToList();
            return View(listSanPham);
        }
        public ActionResult ShowCapSac()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 9).ToList();
            return View(listSanPham);
        }
        public ActionResult ShowSacDuPhong()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI == 10).ToList();
            return View(listSanPham);
        }
        public ActionResult Accessories()
        {
            var listSanPham = db.SANPHAMs.Where(t => t.MALOAI > 5).ToList();
            return View(listSanPham);
        }
	}
}