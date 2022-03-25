CREATE DATABASE qlbh_onl ON PRIMARY
( NAME = qlbh_data, FILENAME = 'D:\CSDL\qlbh_data.mdf', SIZE = 10, MAXSIZE = 1000, FILEGROWTH = 10)
LOG ON
( NAME = qlbh_log, FILENAME = 'D:\CSDL\qlbh_log.ldf', SIZE = 10, FILEGROWTH = 5)

USE qlbh_onl
GO
DROP TABLE CTDONHANG
DROP TABLE CTPHIEUGIAO
DROP TABLE PHIEUGIAO
DROP TABLE DONHANG
DROP TABLE SANPHAM 
DROP TABLE LOAISANPHAM
DROP TABLE KHACHHANG
DROP TABLE TAIXE
DROP TABLE QUANTRIVIEN
DROP TABLE LICHSUGIAHAN
DROP TABLE HOPDONG
DROP TABLE DOITAC
DROP TABLE NHANVIEN
DROP TABLE ACCOUNT

GO
---------------------------------------------------
-- ACCOUNT
CREATE TABLE ACCOUNT
(
	Email varchar(30) NOT NULL PRIMARY KEY,
	Pass varchar(30) NOT NULL,
	Roles int NOT NULL
)

---------------------------------------------------
-- TAIXE
CREATE TABLE TAIXE 
(
	MaTX varchar(6) NOT NULL PRIMARY KEY,
	TenTX nvarchar(30),
	SDT varchar(15),
	Email varchar(30) NOT NULL,
	DChi nvarchar(30),
	Quan nvarchar(15),
	ThanhPho nvarchar(15),
	CCCD varchar(11),
	BienSoXe varchar(15),
	STK varchar(20)
)


---------------------------------------------------
-- KHACHHANG
CREATE TABLE KHACHHANG
(
	MaKH varchar(6) NOT NULL PRIMARY KEY,
	TenKH nvarchar(30),	
	SDT varchar(15),
	Email varchar(30) NOT NULL,
	DChi nvarchar(30),
	Quan nvarchar(15),
	ThanhPho nvarchar(15),
)

---------------------------------------------------
-- NHANVIEN
CREATE TABLE NHANVIEN
(
	MaNV varchar(6) NOT NULL PRIMARY KEY,
	TenNV nvarchar(30),
	SDT varchar(15),
	Email varchar(30) NOT NULL,
)

---------------------------------------------------
-- QUANTRIVIEN
CREATE TABLE QUANTRIVIEN
(
	MaAD varchar(6) NOT NULL PRIMARY KEY,
	TenAD nvarchar(30) NOT NULL,
	Email varchar(30) NOT NULL
)

---------------------------------------------------
-- DOITAC
CREATE TABLE DOITAC
(
	MaDT varchar(6) NOT NULL PRIMARY KEY,
	TenDT nvarchar(30),
	TenDaiDien nvarchar(30),
	SDT varchar(15),
	Email varchar(30) NOT NULL,
	DChi nvarchar(30),
	Quan nvarchar(15),
	ThanhPho nvarchar(15),
	SoChiNhanh int,
	SoDH int,
	MST varchar(15) 

)

---------------------------------------------------
-- HOPDONG
CREATE TABLE HOPDONG
(
	MaHD varchar(6) NOT NULL PRIMARY KEY,
	MaDT varchar(6) NOT NULL,
	MaNV varchar(6) NOT NULL,
	DoanhSo int NOT NULL,
	ThoiHan int,
	NgayBD date NOT NULL,
	NgayKT date,
	TrangThai int,
	PTHoaHong float
)
---------------------------------------------------
-- LICHSUGIAHAN
CREATE TABLE LICHSUGIAHAN
(
	MaLSGH int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MaHD varchar(6) NOT NULL,
	NgayHL date NOT NULL,
	NgayKT date NOT NULL,
	PTHoaHong float,
	NgayCapNhat datetime NOT NULL,
	ThaoTac char(3) NOT NULL
	CHECK(ThaoTac = 'INS' OR ThaoTac = 'UPD' OR ThaoTac = 'DEL')
)

---------------------------------------------------
-- SANPHAM
CREATE TABLE SANPHAM 
(
	MaSP varchar(6) NOT NULL PRIMARY KEY,
	TenSP nvarchar(100) NOT NULL,
	MaDT varchar(6) NOT NULL,
	MaLoaiSP varchar(6) NOT NULL,
	DonVi nvarchar(9),
	DonGia int,
	HinhAnh image
)

---------------------------------------------------
-- LOAISANPHAM
CREATE TABLE LOAISANPHAM
(
	MaLoaiSP varchar(6) NOT NULL PRIMARY KEY,
	TenLoaiSP nvarchar(30)
)

---------------------------------------------------
-- DONHANG
CREATE TABLE DONHANG
(
	MaDH varchar(6) NOT NULL PRIMARY KEY,
	MaKH varchar(6) NOT NULL,
	NgayDat date NOT NULL,
	TrangThai bit NOT NULL
)

---------------------------------------------------
-- CTDONHANG
CREATE TABLE CTDONHANG
(
	MaDH varchar(6) NOT NULL,
	MaSP varchar(6) NOT NULL,
	SoLuong int,
	PRIMARY KEY(MaDH, MaSP)
)

---------------------------------------------------
-- PHIEUGIAO
CREATE TABLE PHIEUGIAO
(
	MaGiao varchar(6) NOT NULL PRIMARY KEY,
	MaDH varchar(6) NOT NULL,
	MaTX varchar(6) NOT NULL,
	NgayGiao Date NOT NULL,
	PhiGiao int NOT NULL
)

---------------------------------------------------
-- CTPHIEUGIAO
CREATE TABLE CTPHIEUGIAO
(
	MaGiao varchar(6) NOT NULL,
	MaSP varchar(6) NOT NULL,
	SoLuong int,
	DonGia int,
	PRIMARY KEY(MaGiao, MaSP)
)


GO

---------------------------------------------------
-- Khoa ngoai cho bang DOITAC
ALTER TABLE DOITAC ADD CONSTRAINT FK_DT FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Khoa ngoai cho bang NHANVIEN
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NV FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Khoa ngoai cho bang KHACHHANG
ALTER TABLE KHACHHANG ADD CONSTRAINT FK_KH FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Khoa ngoai cho bang TAIXE
ALTER TABLE TAIXE ADD CONSTRAINT FK_TX FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Khoa ngoai cho bang QUANTRIVIEN
ALTER TABLE QUANTRIVIEN ADD CONSTRAINT FK_AD FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Khoa ngoai cho bang HOPDONG
ALTER TABLE HOPDONG ADD CONSTRAINT FK01_HD FOREIGN KEY(MaDT) REFERENCES DOITAC(MaDT)
ALTER TABLE HOPDONG ADD CONSTRAINT FK02_HD FOREIGN KEY(MaNV) REFERENCES NHANVIEN(MaNV)

--Khoa ngoai cho bang LICHSUGIAHAN
ALTER TABLE LICHSUGIAHAN ADD CONSTRAINT FK_LSGH FOREIGN KEY(MaHD) REFERENCES HOPDONG(MaHD)

-- Khoa ngoai cho bang SANPHAM
ALTER TABLE SANPHAM ADD CONSTRAINT FK01_SP FOREIGN KEY(MaLoaiSP) REFERENCES LOAISANPHAM(MaLoaiSP)
ALTER TABLE SANPHAM ADD CONSTRAINT FK02_SP FOREIGN KEY(MaDT) REFERENCES DOITAC(MaDT)

-- Khoa ngoai cho bang DONHANG
ALTER TABLE DONHANG ADD CONSTRAINT FK_DH FOREIGN KEY(MaKH) REFERENCES KHACHHANG(MaKH)

-- Khoa ngoai cho bang CTDONHANG
ALTER TABLE CTDONHANG ADD CONSTRAINT FK01_CTDH FOREIGN KEY(MaDH) REFERENCES DONHANG(MaDH)
ALTER TABLE CTDONHANG ADD CONSTRAINT FK02_CTDH FOREIGN KEY(MaSP) REFERENCES SANPHAM(MaSP)

-- Khoa ngoai cho bang PHIEUGIAO
ALTER TABLE PHIEUGIAO ADD CONSTRAINT FK01_PG FOREIGN KEY(MaDH) REFERENCES DONHANG(MaDH)
ALTER TABLE PHIEUGIAO ADD CONSTRAINT FK02_PG FOREIGN KEY(MaTX) REFERENCES TAIXE(MaTX)

-- Khoa ngoai cho bang CTPHIEUGIAO
ALTER TABLE CTPHIEUGIAO ADD CONSTRAINT FK01_CTPG FOREIGN KEY(MaGiao) REFERENCES PHIEUGIAO(MaGiao)
ALTER TABLE CTPHIEUGIAO ADD CONSTRAINT FK02_CTPG FOREIGN KEY(MaSP) REFERENCES SANPHAM(MaSP)

---------------------------------------------------
-- Rang buoc
ALTER TABLE DONHANG ADD CONSTRAINT DF_DH DEFAULT GETDATE() FOR NgayDat
ALTER TABLE PHIEUGIAO ADD CONSTRAINT DF_PG DEFAULT GETDATE() FOR NgayGiao  
---------------------------------------------------
set dateformat mdy
---------------------------------------------------
-- ACCOUNT
insert into ACCOUNT values('nva@gmail.com','123456',5)
insert into ACCOUNT values('tnhan@gmail.com','123456',5)
insert into ACCOUNT values('tmlong@gmail.com','123456',5)
insert into ACCOUNT values('pvvinh@gmail.com','123456',5)
insert into ACCOUNT values('lnminh@gmail.com','123456',5)
insert into ACCOUNT values('tnlinh@gmail.com','123456',3)
insert into ACCOUNT values('bvien@gmail.com','123456',3)
insert into ACCOUNT values('hdlap@gmail.com','123456',3)
insert into ACCOUNT values('thquang@gmail.com','123456',3)
insert into ACCOUNT values('tlnong@gmail.com','123456',3)
insert into ACCOUNT values('lntuan@gmail.com','123456',3)
insert into ACCOUNT values('nnnhut@gmail.com','123456',2)
insert into ACCOUNT values('ltpyen@gmail.com','123456',2)
insert into ACCOUNT values('nvb@gmail.com','123456',2)
insert into ACCOUNT values('nttuan@gmail.com','123456',2)
insert into ACCOUNT values('nttthanh@gmail.com','123456',2)
insert into ACCOUNT values('vtudi@gmail.com','123456',4)
insert into ACCOUNT values('vttinh@gmail.com','123456',4)
insert into ACCOUNT values('ttkhon@gmail.com','123456',4)
insert into ACCOUNT values('hmhao@gmail.com','123456',4)
insert into ACCOUNT values('ccdinh@gmail.com','123456',4)
insert into ACCOUNT values('ptthua@gmail.com','123456',1)
insert into ACCOUNT values('tquy@gmail.com','123456',1)

--QUANTRIVIEN
insert into QUANTRIVIEN values('AD0001',N'Phạm Thừa Thừa', 'ptthua@gmail.com')
insert into QUANTRIVIEN values('AD0002',N'Tiểu Quỷ', 'tquy@gmail.com')

-- KHACHHANG
insert into KHACHHANG values('KH0001',N'Nguyễnn Văn A','0123456789', 'nva@gmail.com', N'731 Trần Hưng Đạo', N'Q5', N'TP.HCM')
insert into KHACHHANG values('KH0002',N'Trần Ngọc Hân', '0123456789', 'tnhan@gmail.com', N'23/5 Nguyễn Trãi', N'Q5', N'TP.HCM')
insert into KHACHHANG values('KH0004',N'Trần Minh Long', '0123456789', 'tmlong@gmail.com', N'50/34 Lê Đại Hành', N'Q10', N'TP.HCM')
insert into KHACHHANG values('KH0005',N'Phạm Văn Vinh', '0123456789', 'pvvinh@gmail.com', N'45 Trưng Vương', N'Sơn Tây', N'Hà Nội')
insert into KHACHHANG values('KH0006',N'Lê Nhật Minh', '0123456789', 'lnminh@gmail.com', N'34 Trương Định', N'Q3', N'TP.HCM')

--DOITAC
insert into DOITAC values('DT0001',N'Thiên Long', N'Trần Ngọc Linh','0123456789', 'tnlinh@gmail.com', N'27 Lê Văn Quới', N'Bình Tân', N'TP.HCM', 15, 500, '3500806643')
insert into DOITAC values('DT0002',N'Campus', N'Hà Duy Lập','0123456789', 'hdlap@gmail.com', N'87 Phan Văn Trị', N'Gò Vấp', N'TP.HCM', 7, 173, '0102859048')
insert into DOITAC values('DT0003',N'Lock&Lock', N'Trần Hồng Quang','0123456789', 'thquang@gmail.com', N'275 CMT8', N'Q10', N'TP.HCM', 50, 300, '03202869022')
insert into DOITAC values('DT0004',N'Vinamilk', N'Trần Lập Nông','0123456789', 'tlnong@gmail.com', N'153 Xô Viết Nghệ Tĩnh', N'Bình Thạnh', N'TP.HCM', 27, 1200, '04523869022')
insert into DOITAC values('DT0005',N'LG Electronics', N'Lâm Ngạn Tuấn','0123456789', 'lntuan@gmail.com', N'57 Hoà Hưng', N'Q10', N'TP.HCM', 10, 156, '03205678122')
insert into DOITAC values('DT0006',N'Unilever', N'Bá Viễn','0123456789', 'bvien@gmail.com', N'332 Nguyễn Thái Học', N'Q1', N'TP.HCM', 10, 156, '03212348128')

-- NHANVIEN
insert into NHANVIEN values('NV0001',N'Nguyễn Như Nhật','927345678','nnnhut@gmail.com')
insert into NHANVIEN values('NV0002',N'Lê Thị Phi Yến','987567390','ltpyen@gmail.com')
insert into NHANVIEN values('NV0003',N'Nguyễn Văn B','997047382','nvb@gmail.com')
insert into NHANVIEN values('NV0004',N'Ngô Thanh Tuấn','913758498','nttuan@gmail.com')
insert into NHANVIEN values('NV0005',N'Nguyễn Thị Trúc Thanh','918590387','nttthanh@gmail.com')

--TAIXE
insert into TAIXE values('TX0001', N'Vương Tử Dị','0123456789', 'vtudi@gmail.com', N'45 Nguyễn Cảnh Chân', N'Q1', N'TP.HCM', '350080664','64-V1521.87','9706410034567890')
insert into TAIXE values('TX0003', N'Vưu Trường Tĩnh','0123456789', 'vttinh@gmail.com', N'873 Lê Hồng Phong', N'Q5', N'TP.HCM', '010285904','64-V1523.69','1234567812345678')
insert into TAIXE values('TX0004', N'Thái Từ Khôn','0123456789', 'ttkhon@gmail.com', N'27/53 Đường 3/2', N'Q10', N'TP.HCM', '0320286902','36-Z1582.54','1078668165705213')
insert into TAIXE values('TX0005', N'Hoàng Minh Hạo','0123456789', 'hmhao@gmail.com', N'227 Nguyễn Văn Cừ', N'Q5', N'TP.HCM', '0320286902','51-A1756.59','3564803412341234')
insert into TAIXE values('TX0006', N'Chu Chính Đình','0123456789', 'ccdinh@gmail.com', N'45/2 An Duong Vuong', N'Q5', N'TP.HCM', '0320286902','59-Z1316.69','4000123456789010')

--LOAISANPHAM
insert into LOAISANPHAM values('01', N'Văn phòng phẩm')
insert into LOAISANPHAM values('02', N'Điện gia dụng')
insert into LOAISANPHAM values('03', N'Đồ gia dụng nhà bếp')
insert into LOAISANPHAM values('04', N'Phụ kiện điện thoại')
insert into LOAISANPHAM values('05', N'Chất Tẩy Rửa')
insert into LOAISANPHAM values('06', N'Chăm sóc da')
insert into LOAISANPHAM values('07', N'Thực phẩm')

--SANPHAM
insert into SANPHAM values('SP0001', N'Bột giặt OMO cửa trên 6kg','DT0006','05', N'Túi', 262000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648138549/Shopping_onl/Bot-Giat-Omo-6kg_q4lden.jpg')
insert into SANPHAM values('SP0002', N'Máy lạnh Inverter 1HP V10ENH','DT0005','02', N'Cái', 6850000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648138680/Shopping_onl/May-lanh-LG-1-HP-V10ENH-Inverter-Chinh-Hang-1_xzii6t.jpg')
insert into SANPHAM values('SP0003', N'Bột giặt OMO Comfort 720g','DT0006','05', N'Túi', 32000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648185476/Shopping_onl/8934868135029_mob01a.jpg')
insert into SANPHAM values('SP0004', N'Bút bi TL-027','DT0001','01', N'Cây', 3000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648185490/Shopping_onl/but_bi_thien_long_tl-027_fd2ed94624164e949898577f64580185_1_jbcy94.webp')
insert into SANPHAM values('SP0005', N'Bút lông dầu PM04','DT0001','01', N'Cây', 5000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648185653/Shopping_onl/but_long_dau_thien_long_pm-04_fbc72b61c6b24523aac15593f7553306_xo43a7.webp')
insert into SANPHAM values('SP0006', N'Tập 100 trang','DT0002','01', N'Chục', 23000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648186004/Shopping_onl/vo-5-o-ly-2x2mm-doraemon-fly-96t-jpeg_etze4n.webp')
insert into SANPHAM values('SP0007', N'Tập 200 trang','DT0002','01', N'Quyển', 4500, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648188654/Shopping_onl/tap-sinh-vien-ke-ngang-campus-great-200-trang-qh64r_123f1ef94abf41c981e50a555b249634_cxa0ok.jpg')
insert into SANPHAM values('SP0008', N'Sữa đặc Ông thọ lon 380g','DT0004','07', N'Lon',19000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189010/Shopping_onl/sua-dac-co-duong-ong-tho-trang-nhan-xanh-lon-380g-201911071524564853_1_mkbxbc.jpg')
insert into SANPHAM values('SP0009', N'Nước táo ép 100% Vfresh 1 lít','DT0006','05', N'Hộp', 40000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189098/Shopping_onl/nuoc-tao-ep-vfresh-tba1l-2_0f761e1289b840df9773016a9d9a0679_master_ac5mua.webp')
insert into SANPHAM values('SP0010', N'Hộp bảo quản thủy tinh LocknLock Top Class 2L - Màu xanh dương','DT0003','03', N'Hộp', 471000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189207/Shopping_onl/JVjoEIfp6XMcc3wBSSwH_simg_de2fe0_500x500_maxb_mkvta6.jpg')

--HOPDONG
insert into HOPDONG values('HD0001', 'DT0001','NV0003', 262000000, NULL, '06/13/2021','02/01/2022', 3, 10.2)
insert into HOPDONG values('HD0002', 'DT0004','NV0005', 780000000, NULL, '02/01/2022','06/01/2022', 1, 11)
insert into HOPDONG values('HD0003', 'DT0002','NV0003', 145000000, NULL, '02/13/2022','07/13/2022', 2, 10.7)
insert into HOPDONG values('HD0004', 'DT0005','NV0002', 560000000, NULL, '11/11/2021','01/11/2022', 4, 12)
insert into HOPDONG values('HD0005', 'DT0003','NV0002', 1250000000, NULL, '02/10/2022','08/10/2022', 1, 10)

--DONHANG
insert into DONHANG values('DH0001', 'KH0006', '12/10/2021', 1)
insert into DONHANG values('DH0002', 'KH0001', '08/11/2021', 0)
insert into DONHANG values('DH0003', 'KH0002', '06/11/2021', 0)
insert into DONHANG values('DH0004', 'KH0006', '12/23/2021', 0)
insert into DONHANG values('DH0005', 'KH0004', '12/19/2021', 1)
insert into DONHANG values('DH0006', 'KH0005', '11/10/2021', 0)
insert into DONHANG values('DH0007', 'KH0002', '01/10/2022', 0)
insert into DONHANG values('DH0008', 'KH0006', '01/28/2022', 1)

--CTDONHANG
insert into CTDONHANG values('DH0001', 'SP0003', 1)
insert into CTDONHANG values('DH0001', 'SP0004', 2)
insert into CTDONHANG values('DH0001', 'SP0005', 3)
insert into CTDONHANG values('DH0001', 'SP0001', 1)
insert into CTDONHANG values('DH0002', 'SP0002', 4)
insert into CTDONHANG values('DH0002', 'SP0003', 4)
insert into CTDONHANG values('DH0002', 'SP0004', 1)
insert into CTDONHANG values('DH0003', 'SP0005', 2)
insert into CTDONHANG values('DH0003', 'SP0003', 2)
insert into CTDONHANG values('DH0004', 'SP0006', 1)
insert into CTDONHANG values('DH0004', 'SP0005', 3)
insert into CTDONHANG values('DH0005', 'SP0001', 3)
insert into CTDONHANG values('DH0006', 'SP0005', 1)
insert into CTDONHANG values('DH0007', 'SP0009', 3)
insert into CTDONHANG values('DH0007', 'SP0008', 2)
insert into CTDONHANG values('DH0008', 'SP0003', 1)
insert into CTDONHANG values('DH0008', 'SP0004', 7)
insert into CTDONHANG values('DH0008', 'SP0005', 3)
insert into CTDONHANG values('DH0008', 'SP0001', 2)
insert into CTDONHANG values('DH0008', 'SP0010', 10)

--PHIEUGIAO
insert into PHIEUGIAO values('PG0001', 'DH0001', 'TX0003', '12/17/2021', 15000)
insert into PHIEUGIAO values('PG0002', 'DH0005', 'TX0001', '01/01/2022', 20000)
insert into PHIEUGIAO values('PG0003', 'DH0008', 'TX0005', '02/03/2022', 20000)

--CTPHIEUGIAO
insert into CTPHIEUGIAO values('PG0001', 'SP0003', 1, 32000)
insert into CTPHIEUGIAO values('PG0001', 'SP0004', 2, 3000)
insert into CTPHIEUGIAO values('PG0001', 'SP0005', 3, 5000)
insert into CTPHIEUGIAO values('PG0001', 'SP0001', 1, 262000)
insert into CTPHIEUGIAO values('PG0002', 'SP0001', 3, 262000)
insert into CTPHIEUGIAO values('PG0003', 'SP0003', 1, 32000)
insert into CTPHIEUGIAO values('PG0003', 'SP0004', 7, 3000)
insert into CTPHIEUGIAO values('PG0003', 'SP0005', 3, 5000)
insert into CTPHIEUGIAO values('PG0003', 'SP0001', 2, 262000)
insert into CTPHIEUGIAO values('PG0003', 'SP0010', 10, 471000)
---------------------------------------------------
---------------------------------------------------
--1.	In ra danh sách các sản phẩm (MaSP, TenSP) của đối tác "Thiên Long"
SELECT MaSP, TenSP 
FROM SANPHAM SP LEFT JOIN DOITAC DT ON SP.MaDT = DT.MaDT
WHERE TenDT = N'Thiên Long'

--2.	In ra hoá đơn bán ra trong 1/2022
SELECT *
FROM DONHANG 
WHERE MONTH(NgayDat)=1 AND YEAR(NgayDat)=2022

--3.	In ra danh sách sản phẩm của khách hàng tên "Lê Nhật Minh"
SELECT DH.MaDH, SP.TenSP, DH.NgayDat, CTDH.SoLuong
FROM KHACHHANG KH RIGHT JOIN DONHANG DH ON KH.MaKH = DH.MaKH JOIN CTDONHANG CTDH ON DH.MaDH = CTDH.MaDH JOIN SANPHAM SP ON CTDH.MaSP = SP.MaSP
WHERE KH.TenKH = N'Lê Nhật Minh'
ORDER BY DH.NgayDat DESC

select HinhAnh from SANPHAM WHERE MaSP = 'SP0001'






