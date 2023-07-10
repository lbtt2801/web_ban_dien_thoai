using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Models;

namespace Nhom7_WebsiteBanDienThoaiDiDongVaPhuKien.Models
{
    public class GioHang
    {
        QLDTDataContext db = new QLDTDataContext();
        public int maSP { get; set; }
        public string tenSP { get; set; }
        public string hinhAnh { get; set; }
        public double donGia { get; set; }
        public int soLuong { get; set; }
        public double thanhTien
        {
            get { return soLuong * donGia; }
        }
        public GioHang(int MASP)
        {
            maSP = MASP;
            SANPHAM lk = db.SANPHAMs.Single(l => l.MASP == maSP);
            tenSP = lk.TENSP;
            hinhAnh = lk.HINHANH;
            donGia = double.Parse(lk.DONGIA.ToString());
            soLuong = 1;
        }
    }
}