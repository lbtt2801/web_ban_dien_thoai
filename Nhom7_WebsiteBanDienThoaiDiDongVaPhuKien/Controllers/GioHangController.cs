using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Models;

namespace Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Controllers
{
    public class GioHangController : Controller
    {
        //
        // GET: /GioHang/
        QLDTDataContext db = new QLDTDataContext();
        public List<GioHang> LayGioHang()
        {
            List<GioHang> list = Session["GioHang"] as List<GioHang>;
            if (list == null)
            {
                list = new List<GioHang>();
                Session["GioHang"] = list;
            }
            return list;
        }

        public ActionResult ThemGioHang(int maSP, string strURL)
        {
            List<GioHang> list = LayGioHang();
            GioHang sp = list.Find(l => l.maSP == maSP);
            if (sp == null)
            {
                sp = new GioHang(maSP);
                list.Add(sp);
                return Redirect(strURL);
            }
            else
            {
                sp.soLuong++;
                return Redirect(strURL);
            }
        }

        private int tinhTongSoLuong()
        {
            int sum = 0;
            List<GioHang> list = Session["GioHang"] as List<GioHang>;
            if (list != null)
            {
                sum = list.Sum(sp => sp.soLuong);
            }
            return sum;
        }

        private double tinhTongThanhTien()
        {
            double sum = 0;
            List<GioHang> list = Session["GioHang"] as List<GioHang>;
            if (list != null)
            {
                sum = list.Sum(sp => sp.thanhTien);
            }
            return sum;
        }

        public ActionResult GioHangRong()
        {
            return View();
        }

        public ActionResult GioHang()
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("GioHangRong", "GioHang");
            }
            List<GioHang> list = LayGioHang();
            ViewBag.TongSL = tinhTongSoLuong();
            ViewBag.TongTT = tinhTongThanhTien();

            return View(list);
        }

        public ActionResult GioHangPartial()
        {
            ViewBag.TongSL = tinhTongSoLuong();
            return PartialView();
        }

        public ActionResult Xoa1SPTrongGioHang(int maSP)
        {
            List<GioHang> list = LayGioHang();
            GioHang sp = list.Single(l => l.maSP == maSP);
            if (sp != null)
            {
                list.RemoveAll(sa => sa.maSP.Equals(maSP));
                return RedirectToAction("GioHang", "GioHang");
            }
            if (list.Count == 0)
                return RedirectToAction("TrangChu", "LinhKien");
            return RedirectToAction("GioHang", "GioHang");
        }

        public ActionResult XoaALLGioHang()
        {
            List<GioHang> list = LayGioHang();
            list.Clear();
            return RedirectToAction("GioHangRong", "GioHang");
        }

        public ActionResult CapNhatGioHang(int maSP, FormCollection f)
        {
            List<GioHang> list = LayGioHang();
            GioHang sp = list.Single(l => l.maSP == maSP);
            if (sp != null)
            {
                sp.soLuong = int.Parse(f["txtSoLuong"].ToString());
            }
            return RedirectToAction("GioHang", "GioHang");
        }

        [HttpGet]
        public ActionResult DatHang()
        {
            if (Session["TaiKhoan"] == null)
                return RedirectToAction("DangNhap", "NguoiDung");
            if (Session["GioHang"] == null)
                return RedirectToAction("TrangChu", "LinhKien");
            List<GioHang> list = LayGioHang();
            ViewBag.TongSL = tinhTongSoLuong();
            ViewBag.TongTT = tinhTongThanhTien();
            return View(list);
        }

        [HttpPost]
        public ActionResult DatHang(FormCollection f)
        {
            //Thêm đơn hàng
            HOADON hd = new HOADON();
            KHACHHANG kh = (KHACHHANG)Session["TaiKhoan"];
            List<GioHang> gh = LayGioHang();
            hd.MAKH = kh.MAKH;
            hd.NGAYLAPHD = DateTime.Now;
            var ngayGiao = string.Format("{0:MM/dd/yyyy}", f["NgayGiao"]);
            hd.NGAYGIAO = DateTime.Parse(ngayGiao);
            db.HOADONs.InsertOnSubmit(hd);
            db.SubmitChanges();
            //Thêm chi tiết đơn hàng
            foreach (var item in gh)
            {
                CTHOADON ctDH = new CTHOADON();
                ctDH.MAHD = hd.MAHD;
                ctDH.MASP = item.maSP;
                ctDH.SOLUONG = item.soLuong;
                ctDH.THANHTIEN = (decimal)item.donGia;
                db.CTHOADONs.InsertOnSubmit(ctDH);
            }
            db.SubmitChanges();
            Session["GioHang"] = null;
            return RedirectToAction("XacNhanDonHang", "GioHang");
        }

        public ActionResult XacNhanDonHang()
        {
            return View();
        }
    }
}