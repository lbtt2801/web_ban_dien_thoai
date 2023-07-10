-- TẠO DATABASE
GO
CREATE DATABASE QLDT
GO
USE QLDT
-- TẠO BẢNG
GO
CREATE TABLE QUANTRI
(
	TAIKHOAN VARCHAR(30),
	MATKHAU VARCHAR(30),
	CONSTRAINT PK_QUANTRI PRIMARY KEY (TAIKHOAN, MATKHAU)
)
GO
CREATE TABLE KHACHHANG
(
	MAKH INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENKH  NVARCHAR(50),
	DIACHI NVARCHAR(50),
	SDT VARCHAR(11) NOT NULL,
	GIOITINH NVARCHAR(30),
	NGAYSINH DATETIME,
	TAIKHOAN VARCHAR(30),
	MATKHAU VARCHAR(30),
	EMAIL VARCHAR(40)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE KHACHHANG
ADD CONSTRAINT UNI_KHACHHANG UNIQUE (SDT)
GO
CREATE TABLE NHANVIEN
(
	MANV INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENNV  NVARCHAR(50),
	PHAI NVARCHAR(5),
	NGAYSINH DATETIME,
	SDT VARCHAR(11) NOT NULL,
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT UNI_MANV UNIQUE (MANV)
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT UNI_SDT UNIQUE (SDT)
GO
CREATE TABLE HOADON
(
	MAHD INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	MAKH INT,
	MANV INT,
	NGAYLAPHD DATETIME,
	NGAYGIAO DATETIME
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_MAKH FOREIGN KEY (MAKH)
	REFERENCES KHACHHANG (MAKH)
GO
ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_MANV FOREIGN KEY (MANV)
	REFERENCES NHANVIEN (MANV)
GO
ALTER TABLE HOADON
ADD CONSTRAINT UNI_HOADON UNIQUE (MAHD)
GO
CREATE TABLE LOAILINHKIEN
(
	MALOAI INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENLOAI NVARCHAR(50),
	NOTE VARCHAR(50)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE LOAILINHKIEN
ADD CONSTRAINT UNI_LOAILINHKIEN UNIQUE (MALOAI)
GO
CREATE TABLE SANPHAM
(
	MASP INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	MALOAI INT,
	TENSP NVARCHAR(50),
	HANGSX NVARCHAR(60),
	MOTA NVARCHAR(MAX),
	TGBH INT,
	NGAYCAPNHAT DATETIME,
	DONGIA DECIMAL(18,3),
	HINHANH VARCHAR(50)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE SANPHAM
ADD CONSTRAINT FK_SANPHAM_MALOAI FOREIGN KEY (MALOAI)
	REFERENCES LOAILINHKIEN (MALOAI)
GO
ALTER TABLE SANPHAM
ADD CONSTRAINT UNI_SANPHAM UNIQUE (MASP)
GO
ALTER TABLE SANPHAM
ADD CONSTRAINT CK_SANPHAM_DONGIA CHECK (DONGIA > 0)
GO
CREATE TABLE CTHOADON
(
	MASP INT NOT NULL,
	MAHD INT NOT NULL,
	SOLUONG INT,
	THANHTIEN DECIMAL(18,3),
	CONSTRAINT PK_CTHOADON PRIMARY KEY (MASP, MAHD)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT FK_CTHOADON_MASP FOREIGN KEY (MASP)
	REFERENCES SANPHAM (MASP)
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT FK_CTHOADON_MAHD FOREIGN KEY (MAHD)
	REFERENCES HOADON (MAHD)
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT CK_CTHOADON_THANHTIEN CHECK (THANHTIEN > 0)
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT CK_CTHOADON_SOLUONG CHECK (SOLUONG > 0)
GO
CREATE TABLE LOAITINTUC
(
	MALOAITIN INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENLOAITIN NVARCHAR(30)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE LOAITINTUC
ADD CONSTRAINT UNI_LOAITINTUC UNIQUE (MALOAITIN)
GO
CREATE TABLE TINTUC
(
	MATIN INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENTIEUDE NVARCHAR(250),
	NOIDUNG NVARCHAR(MAX),
	NGAYDANG DATETIME,
	HINHANH VARCHAR(50),
	MALOAITIN INT  NOT NULL,
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE TINTUC
ADD CONSTRAINT FK_TINTUC_MALOAITIN FOREIGN KEY (MALOAITIN)
	REFERENCES LOAITINTUC (MALOAITIN)
GO
ALTER TABLE TINTUC
ADD CONSTRAINT UNI_TINTUC UNIQUE (MATIN)
---------------Nhap lieu----------------
GO
INSERT INTO SANPHAM
VALUES  (1,N'Nokia G60 5G',N'Nokia',N'Nokia G60 5G, chiếc điện thoại với đầy điểm nhấn của HMD khi sở hữu bộ vi xử lý Snapdragon 695 có khả năng hỗ trợ mạng 5G',2,2022-12-21,10000000,N'Nokia G60 5G.jpg'),
		(1, N'Nokia C1',N'Nokia', N'Nokia C1 với thiết kế nhỏ gọn khi sử dụng tạo cảm giác thoải mái vừa vặn với lòng bàn tay của bạn tạo sự chắc chắn rất khó rơi vỡ khi sử dụng',2,2021-11-11,3300000,N'Nokia C1.jpg'),
		(2, N'Samsung Galaxy Z Fold4',N'Samsung', N'Camera mắt thần bóng đêm cho trải nghiệm chụp ảnh ấn tượng - Camera chính: 50MP,Viên pin ấn tượng, sạc nhanh tức tốc - Pin 4,400 mAh, sạc nhanh 25 W',3,2021-11-11,35300000,N'Samsung Galaxy Z Fold4.jpg'),
		(2, N'Samsung galaxy a23',N'Samsung', N'Nâng cao trải nghiệm với màn hình chất lượng - Màn hình LCD 6.6 inch Full HD+, Hiệu năng ấn tượng mạnh mẽ - Snapdragon 680 (SM6225), RAM dung lượng 4GB',4,2021-11-11,3000000,N'samsung galaxy a23.jpg'),
		(3, N'Oppo A95',N'Oppo', N'OPPO A95 được trang bị màn hình AMOLED với kích thước 6.43 inch, có độ hiển thị màu sắc rực rỡ nịnh mắt, có độ tương phản cao.',4,2021-11-11,7500000,N'Oppo A95.jpg'),
		(2, N'Oppo Reno5',N'Oppo', N'Sản phẩm mới nhất trong series OPPO Reno của hãng điện thoại OPPO chính là OPPO Reno 5. Chiếc điện thoại với nhiều kế thừa từ người tiền nhiệm Reno với thiết kế hiện đại, cấu hình cao hứa hẹn mang đến những trải nghiệm dùng ấn tượng',2,2021-11-11,3300000,N'Oppo Reno5.jpg'),
		(5, N'iPhone 14 Pro Max 256GB',N'iPhone', N'Màn hình Dynamic Island - Sự biến mất của màn hình tai thỏ thay thế bằng thiết kế viên thuốc, OLED 6,7 inch, hỗ trợ always-on display',2,2021-11-11,33300000,N'iPhone 14 Pro Max 256GB.jpg'),
		(5, N'iPhone 13 Pro Max 128GB',N'iPhone', N'Hiệu năng vượt trội - Chip Apple A15 Bionic mạnh mẽ, hỗ trợ mạng 5G tốc độ cao',1,2021-11-11,23300000,N'iPhone 13 Pro Max 128GB.jpg'),
		(5, N'iPhone 12 64GB',N'iPhone', N'Mạnh mẽ, siêu nhanh với chip A14, RAM 4GB, mạng 5G tốc độ cao',1,2021-11-11,13300000,N'iPhone 12 64GB.jpg'),
		(6, N'Loa Bluetooth LG Xboom Go PN1',N'LG', N'Loa bluetooth LG XBOOM Go PN1 là dòng loa bluetooth thế hệ mới từ LG đề cao sự nhỏ gọn, di động cùng khả năng bền bỉ để cùng người dùng tận hưởng giai điệu âm thanh trên từng cung đường đi qua.',2,2021-11-11,300000,N'lg xboom go pn1.jpg'),
		(6, N'Loa Edifier MR4',N'Nokia', N'Loa Edifier MR4 Đen mang đến âm thanh trung thực nhờ hệ thống phân tích âm thanh đạt chứng nhận KLIPPEL của Đức. Với loa Edifier MR4, người dùng có thể hiệu chỉnh âm thanh một cách tối ưu phục vụ cho mọi nhu cầu sử dụng.',2,2021-11-11,100000,N'Loa Edifier MR4.jpg'),
		(7, N'Tai nghe Marshall Minor 3',N'Samsung', N'Pin 5 giờ sử dụng cho 1 lần sạc,25 giờ khi sử dụng với hộp sạc, Màng loa 12mm được tuỳ chỉnh mang lại chất lượng âm thanh rõ ràng,sắc nét.',2,2021-11-11,100000,N'Tai nghe Marshall Minor 3.jpg'),
		(7, N'Tai nghe không dây Soundpeats Air 3',N'Samsung', N'Tai nghe không dây ngày càng phổ biến với nhiền công nghệ, cảm biến chuyên nghiệp. Trong đó tai nghe không dây Soundpeats True Air 3 được cải tiến và hoàn thiện với thiết kế nhỏ gọn hơn, âm thanh chất lương hơn.',2,2021-11-11,300000,N'Tai nghe không dây Soundpeats Air 3.jpg'),
		(8, N'Thẻ nhớ Samsung 256GB',N'Samsung', N'Đối với những ai thường xuyên phải lưu trữ hoặc chuyển dữ liệu, hình ảnh hay video từ thiết bị này sang thiết bị khác thì chiếc thẻ nhớ là một trong những món đồ không thể thiếu.',2,2021-11-11,2500000,N'Thẻ nhớ Samsung 256GB.jpg'),
		(8, N'Thẻ nhớ Sandisk Ultra A1',N'Samsung', N'Những lúc công việc đòi hỏi sao chép dữ liệu để chuyển đổi giữa các thiết bị máy tính, bạn sẽ cần đến thẻ nhớ MicroSDXC SanDisk Ultra A1 64 GB nhằm hỗ trợ thao tác công việc thuận lợi hơn.',2,2021-11-11,2000000,N'Thẻ nhớ Sandisk Ultra A1.jpg'),
		(9, N'Miband 3',N'Nokia', N'Mi Band 3 là một trong những phụ kiện vòng đeo tay thông minh đáng để sở hữu trong tầm giá với những gì mà nó đem lại. Là phiên bản nâng cấp từ chiếc Mi Band 2 đình đám.',2,2021-11-11,100000,N'Miband 3.jpg'),
		(9, N'MicroUSB Pisen',N'Nokia', N'Thiết kế nhỏ gọn, vỏ cáp chống rối và đầu cáp bọc thép, chịu được lực kéo lên đến 80kg Chiều dài 0.9 m kết nối tiện lợi các thiết bị di động',2,2021-11-11,3300000,N'MicroUSB Pisenjpg'),
		(10, N'Xiaomi PB200SZM',N'Xiaomi', N'Một sản phẩm phụ kiện vừa có dung lượng pin trữ cao, vừa có công suất sạc nhanh như pin sạc dự phòng Xiaomi PB200SZM 20.000mAh 50W sẽ là “cứu tinh” cho người dùng công nghệ ở mọi thời điểm trong ngày.',2,2021-11-11,2300000,N'Xiaomi PB200SZM.jpg'),
		(10, N'Energizer 10.000mAh',N'Nokia', N'Pin dự phòng Energizer 10.000 mAh UE 10058 là một bộ pin dự phòng đạt chất lượng đến từ nước Mỹ. Bên cạnh đó, đây còn là mẫu pin dự phòng Energizer có mức giá vừa tầm và sở hữu nhiều tính năng lạ mắt, nổi bật nhất.',2,2021-11-11,3300000,N'Energizer 10.000mAh.jpg'),
		(4, N'xiaomi 12t',N'Xiaomi', N'Xiaomi 12T là sản phẩm được nhiều tín đồ công nghệ đánh giá cao với màn hình AMOLED 6.67 inch độ phân giải cao, tần số quét 120Hz, chip MediaTek Dimensity 8100-Ultra, RAM 8GB và bộ nhớ trong 128GB.',2,2021-11-11,7000000,N'xiaomi 12t.jpg'),
		(4, N'Xiaomi Poco F4',N'Xiaomi', N'Xiaomi Poco F4 sản phẩm làm nhiều tính đồ công nghệ mong chờ, với thiết kế và hiệu năng nổi bật, mang sự đặt biệt của thương hiệu điện thoại Xiaomi.',2,2021-11-11,11300000,N'Xiaomi Poco F4.jpg'),
		(4, N'Xiaomi 11T Pro',N'Xiaomi', N'Xiaomi 11T Pro vừa được Xiaomi trình làng Không chỉ sở hữu nguồn sức mạnh vô biên từ con chip mạnh mẽ nhất, máy còn được trang bị nhiều tính năng mới mang tính đột phá phân khúc.',2,2021-11-11,15300000,N'Xiaomi 11T Pro.jpg'),
		(4, N'Xiaomi 11T',N'Xiaomi', N'Được biết đây là phiên bản giảm cấp về hiệu năng nhằm dễ tiếp cận hơn đến các phân khúc khách hàng thấp hơn, song về trải nghiệm bạn sẽ bất ngờ vì không có quá nhiều sự khác biệt.',2,2021-11-11,18300000,N'Xiaomi 11T.jpg'),
		(7, N'Tai nghe KZ ZST',N'Samsung', N'Tai nghe KZ ZST là một trong những sản phẩm có giá tương đối rẻ của KZ, nhưng vẫn mang đến một chất lượng âm thanh hấp dẫn trong tầm giá.',2,2021-11-11,1300000,N'Tai nghe KZ ZST.jpg'),
		(7, N'Tai nghe JBL C150SI',N'Nokia', N'Bên cạnh việc làm ra những tai nghe tầm cao cấp thì những chiếc tai nghe giá rẻ đến từ nhà JBL như chiếc tai nghe JBL C150SI cũng được hãng cực kì chăm chút về mặt thiết kế cũng như chất âm bên trong của nó.',2,2021-11-11,300000,N'Tai nghe JBL C150SI.jpg'),
		(7, N'Tai nghe không dây Havit TW932',N'Nokia', N'Dù có giá bán khá rẻ nhưng tai nghe không dây Havit TW932 lại là mẫu tai nghe True Wireless sở hữu chất âm ấn tượng cùng thiết kế thoải mái, không gây khó chịu hay đau tai trong thời gian dài sử dụng.',2,2021-11-11,200000,N'Tai nghe không dây Havit TW932.jpg'),
		(2, N'Samsung Galaxy M32',N'Samsung', N'Điện thoại Samsung M32 là mẫu điện thoại Samsung thuộc phân khúc giá rẻ mới được ra mắt trên thị trường. Điện thoại Samsung M32 là sản phẩm thuộc series Samsung M được kế thừa nhiều ưu điểm từ dòng Samsung A.',2,2021-11-11,17300000,N'Samsung Galaxy M32.jpg'),
		(2, N'Samsung Galaxy A04s',N'Samsung', N'Với thiết kế có phần đổi mới, cùng màn hình lớn và thời lượng pin cực “trâu”, điện thoại Samsung Galaxy A04s dự kiến sẽ là sản phẩm điện thoại mang đến trải nghiệm hấp dẫn với giá bán vô cùng phải chăng dành cho người dùng công nghệ.',2,2021-11-11,6000000,N'Samsung Galaxy A04s.jpg'),
		(1, N'Nokia C20',N'Nokia', N'Với những trang bị cùng tính năng độc đáo điện thoại Nokia này sẽ mang đến cho người dùng những trải nghiệm vô cùng ấn tượng và độc đáo.',2,2021-11-11,3300000,N'Nokia C20.jpg'),
		(1, N'Nokia C30',N'Nokia', N'So với phiên bản trước, C30 được nâng cấp thêm một số hiệu năng cùng với đó là viên pin cực khủng. Từ đó mang đến cho người dùng những trải nghiệm vô cùng ấn tượng và độc đáo.',2,2021-11-11,3300000,N'Nokia C30.jpg')
---------------------------------------
GO
INSERT INTO LOAILINHKIEN
VALUES   (N'Nokia','DT'),
		 (N'SamSung','DT'),
		 ( N'Oppo','DT'),
		 (N'Xiaomi','DT'),
		 ( N'Iphone','DT'),
		 ( N'Loa','PK'),
		 ( N'Tai Nghe','PK'),
		 (N'Thẻ Nhớ','PK'),
		 (N'Cáp sạc','PK'),
		 ( N'Sạc dự phòng','PK')
GO
INSERT INTO QUANTRI
VALUES ('admin','123')
GO
INSERT INTO KHACHHANG
VALUES  (N'Phạm Tuân Truong', N'306 Nguyễn Trãi, P.8, Q.5',N'0876543210',N'Nam',1998-03-11, N'truong', N'123456', N'truong2468@gmail.com'),
		(N'Trần Quang Hậu', N'306 Đồng Nai, P.8, Q.Tân Phú',N'0369484629',N'Nam',2002-03-21, N'hau', N'123456', N'hau@gmail.com'),
		(N'Phạm Tuân Phong', N'306 Nguyễn Tri Phương, P.13, Q8',N'05484757',N'Nam',1998-03-11, N'Phong', N'123456', N'phong@gmail.com'),
		(N'Nguyễn Thị Hồng', N'Hồ Chí Minh',N'05545844',N'Nữ',1978-05-11, N'hong', N'123456', N'hong@gmail.com'),
		(N'Nguyễn Nguyên Bảo', N'Củ Chi',N'054755754',N'Nữ',2002-04-08, N'bao', N'123456', N'baonguyen0408@gmail.com'),
		(N'Lê Bùi Tấn Trưởng', N'Bình Định',N'0755481454',N'Nam',1998-09-11, N'truong', N'123456', N'truong123@gmail.com'),
		(N'Nguyễn Duck Huy', N'Hồ Chí Minh',N'08725545',N'Nam',2002-03-11, N'huy', N'123456', N'huyne@gmail.com'),
		(N'Lê Thị Đào', N'Nha Trang',N'089574955',N'Nữ',2000-03-11, N'dao', N'123456', N'dao123@gmail.com')
GO
INSERT INTO LOAITINTUC
VALUES ('Tin mới'),
		('Khuyến mãi'),
		('App game')

GO
INSERT INTO TINTUC
VALUES  (N'OPPO Find X3 và Nubia Red Magic 6 xác nhận sẽ ra mắt với Snapdragon 888',N'Chip kế nhiệm cho Snapdragon 865 đã chính thức ra mắt với tên gọi là Snapdragon 888 mà không phải SD875 như nhiều đồn đoán. Ngay sau đó, một số nhà sản xuất đã xác nhận các flagship 2021 của họ sẽ ra mắt với chip mới',2021-10-10,'TinMoi1.JPG',1),
		(N'Xiaomi Mi 11 sẽ là chiếc điện thoại đầu tiên sử dụng Snapdragon 888 mới',N'Vào sự kiện tối qua, Qualcomm đã chính thức công bố Snapdragon 888, nền tảng di động hàng đầu thế hệ tiếp theo của họ. Mới đây, CEO của Xiaomi đã tiết lộ rằng Mi 11 sẽ là mẫu điện thoại đầu tiên ra mắt với chipset mới nhất này. ',2022-10-10,'TinMoi2.JPG',1),
		(N'Mọi thứ chúng ta biết về Samsung Galaxy Buds Pro',N'Trong bài viết này, FPT Shop sẽ tổng hợp lại các thông tin rò rỉ về Samsung Galaxy Buds Pro. Đây là mẫu tai nghe TWS hàng đầu của gã khổng lồ Hàn Quốc.',2021-10-10,'TinMoi3.JPG',1),
		(N'Hướng dẫn toàn tập cách sử dụng máy in dành cho người mới bắt đầu',N'Máy in rất dễ cài đặt và sử dụng, tuy nhiên bạn cũng cần lưu ý một số điều trong quá trình sử dụng để đảm bảo độ bền cho máy.',2021-10-10,'TinMoi4.JPG',1),
		(N'So sánh chip HiSilicon Kirin 710 và Qualcomm Snapdragon 660: "Kẻ tám lạng, người nửa cân"',N'Huawei đã ra mắt Hisilicon Kirin 710 cách đây 2 năm, bộ vi xử lý tầm trung này sự kế thừa và nâng cấp của chipset Kirin 659 phổ biến. Snapdragon 660 là một trong những bộ vi xử lý tầm trung mạnh mẽ và là một trong những đối thủ gần ',2021-10-10,'TinMoi5.JPG',1),
		(N'Chỉ trong 30 phút, FPT Shop ‘cháy’ hơn 500 iPhone 12 Series',N'Lúc 12h00 đêm ngày 26/11/2020, FPT Shop đã chính thức mở bán và giao iPhone 12 Series chính hãng đến tận tay khách hàng, trở thành chuỗi cửa hàng chính hãng đầu tiên mở bán siêu phẩm tại Việt Nam. Đến sáng ngày 27/11, hệ ',2021-10-10,'KM1.jpg',2),
		(N'Mua laptop, FPT Shop tặng quà sinh nhật đến 700.000 đồng',N'Chọn mua laptop tại FPT Shop, bạn không chỉ được giảm đến 10% mà còn được tặng thêm quà đến 700.000 đồng nếu có ngày sinh trong tháng. ',2021-10-10,'KM2.jpg',2),
		(N'FPT Shop ‘cháy’ 2.000 iPhone 12 Series chính hãng, trung bình mỗi giờ giao 500 máy!',N'Tính đến 12h trưa ngày 27/11/2020, FPT Shop và F.Studio by FPT đã cháy 2.000 đơn hàng, trung bình mỗi giờ giao 500 máy!',2021-10-10,'KM3.jpg',2),
		(N'FPT Shop giảm đến 50% cho củ sạc Anker A2633 chính hãng',N'Từ ngày 27/11 – 03/12, khách hàng chọn mua củ sạc Anker PowerPort III 20W A2633 tại FPT Shop sẽ được hưởng nhiều ưu đãi thiết thực, bao gồm: giảm đến 50%, bảo hành 12 tháng và giao hàng tận nơi miễn phí.',2021-10-10,'KM4.jpg',2),
		(N'FPT Shop giảm thêm 500.000 đồng cho khách hàng chọn mua iPhone 12 Series và thanh toán',N'Ngày 27/11, FPT Shop chính thức lên kệ iPhone 12 Series với giá từ 21,99 triệu. Chọn mua sản phẩm từ 27/11-31/12/2020, ngoài những ưu đãi hiện có của sản phẩm, FPT Shop còn giảm thêm 500.000 đồng dành cho tất cả khách hàng',2021-10-10,'KM5.jpg',2),
		(N'Hướng dẫn cứu dữ liệu thẻ nhớ bị format',N'Ngoài bộ nhớ trong ra, thẻ nhớ là nơi chứa dữ liệu của các thiết bị thông minh như smartphone hoặc tablet. Nếu gặp phải trường hợp cần cứu dữ liệu thẻ nhớ bị format thì phải thực hiện ra sao để đảm bảo được độ nguyên vẹn?',2021-10-10,'TT1.jpg',3),
		(N'Hướng dẫn phục hồi nhanh thẻ nhớ bị mất dung lượng',N'Lỗi thẻ nhớ bị mất dung lượng thường không diễn ra nhiều và phổ biến như các lỗi khác nhưng một khi xuất hiện thì nó cũng gây ảnh hưởng đến người dùng bằng cách này hay cách khác.',2021-10-10,'TT2.jpg',3),
		(N'Đây là 4 cách sửa lỗi thẻ nhớ bị read only nhanh nhất',N'Khi thẻ nhớ bị read only, điều đó có nghĩa là bạn không thể làm bất cứ một hành động nào khác như chỉnh sửa – xóa – di chuyển dữ liệu bên trong nó ra khu vực khác.',2021-10-10,'TT3.jpg',3)




	

	
