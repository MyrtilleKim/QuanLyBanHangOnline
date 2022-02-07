/*CREATE DATABASE qlbh_onl ON PRIMARY
( NAME = qlbh_data, FILENAME = 'D:\CSDL\qlsv_data.mdf', SIZE = 10, MAXSIZE = 1000, FILEGROWTH = 10)
LOG ON
( NAME = qlbh_log, FILENAME = 'D:\CSDL\qlsv_log.ldf', SIZE = 10, FILEGROWTH = 5)*/

USE qlbh_onl
GO
DROP TABLE DOITAC
DROP TABLE HOPDONG
DROP TABLE SANPHAM 
DROP TABLE KHACHHANG
DROP TABLE NHANVIEN
DROP TABLE USERS
DROP TABLE TAIXE
DROP TABLE QUYEN
DROP TABLE CTQUYEN
DROP TABLE DONHANG
DROP TABLE CTDONHANG
DROP TABLE LOAISANPHAM
DROP TABLE USERS_QUYEN
GO
---------------------------------------------------
-- DOITAC
CREATE TABLE DOITAC
(
	MaDT varchar(9) NOT NULL PRIMARY KEY,
	TenDT nvarchar(30),
	TenDaiDien nvarchar(30),
	SDT varchar(15),
	Email varchar(30) NOT NULL,
	DChi nvarchar(30),
	Quan nvarchar(15),
	ThanhPho nvarchar(15),
	SoChiNhanh smallint,
	SoDH smallint,
	MST varchar(15) 

)

---------------------------------------------------
-- HOPDONG
CREATE TABLE HOPDONG
(
	MaHD varchar(9) NOT NULL PRIMARY KEY,
	MaDT varchar(9) NOT NULL,
	MaNV varchar(9) NOT NULL,
	DoanhSo int NOT NULL,
	ThoiHan smallint,
	NgayBD date NOT NULL,
	NgayKT date,
	TrangThai tinyint,
	PTHoaHong float
)

---------------------------------------------------
-- SANPHAM
CREATE TABLE SANPHAM 
(
	MaSP varchar(9) NOT NULL PRIMARY KEY,
	TenSP nvarchar(100) NOT NULL,
	MaDT varchar(9) NOT NULL,
	MaLoaiSP varchar(9) NOT NULL,
	DonVi nvarchar(9),
	DonGia int,
	HinhAnh image
)

---------------------------------------------------
-- LOAISANPHAM
CREATE TABLE LOAISANPHAM
(
	MaLoaiSP varchar(9) NOT NULL PRIMARY KEY,
	TenLoaiSP nvarchar(30)
)

---------------------------------------------------
-- KHACHHANG
CREATE TABLE KHACHHANG
(
	MaKH varchar(9) NOT NULL PRIMARY KEY,
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
	MaNV varchar(9) NOT NULL PRIMARY KEY,
	TenNV nvarchar(30),
	SDT varchar(15),
	Email varchar(30) NOT NULL,
)

---------------------------------------------------
-- DONHANG
CREATE TABLE DONHANG
(
	MaDH varchar(9) NOT NULL PRIMARY KEY,
	MaKH varchar(9) NOT NULL,
	NgayDat date NOT NULL,
	MaTX varchar(9),
	NgayGiao date,
	PTThanhToan bit NOT NULL, 
	PhiVanChuyen int,
	TrangThai tinyint NOT NULL
)

---------------------------------------------------
-- CTDONHANG
CREATE TABLE CTDONHANG
(
	MaDH varchar(9) NOT NULL,
	MaSP varchar(9) NOT NULL,
	SoLuong tinyint,
	PRIMARY KEY(MaDH, MaSP)
)

---------------------------------------------------
-- TAIXE
CREATE TABLE TAIXE 
(
	MaTX varchar(9) NOT NULL PRIMARY KEY,
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
-- USERS
CREATE TABLE USERS
(
	MaUser varchar(9) NOT NULL PRIMARY KEY,
	Email nvarchar(30) NOT NULL,
	Pass nvarchar(30) NOT NULL,
)

---------------------------------------------------
-- QUYEN
CREATE TABLE QUYEN
(
	MaQuyen varchar(9) NOT NULL PRIMARY KEY,
	TenQuyen nvarchar(30) NOT NULL,
)

---------------------------------------------------
-- CTQUYEN
CREATE TABLE CTQUYEN
(
	MaCTQuyen varchar(9) NOT NULL PRIMARY KEY,
	MaQuyen varchar(9) NOT NULL,
	ACTION_CODE varchar(30) NOT NULL,
	KTraAction BIT
)

---------------------------------------------------
-- USERS_QUYEN
CREATE TABLE USERS_QUYEN
(
	MaUQ varchar(9) NOT NULL PRIMARY KEY,
	MaUser varchar(9) NOT NULL,
	MaQuyen varchar(9) NOT NULL,
	License BIT
)
GO

---------------------------------------------------
-- Khoa ngoai cho bang HOPDONG
ALTER TABLE HOPDONG ADD CONSTRAINT FK01_HD FOREIGN KEY(MaDT) REFERENCES DOITAC(MaDT)
ALTER TABLE HOPDONG ADD CONSTRAINT FK02_HD FOREIGN KEY(MaNV) REFERENCES NHANVIEN(MaNV)

-- Khoa ngoai cho bang SANPHAM
ALTER TABLE SANPHAM ADD CONSTRAINT FK01_SP FOREIGN KEY(MaLoaiSP) REFERENCES LOAISANPHAM(MaLoaiSP)
ALTER TABLE SANPHAM ADD CONSTRAINT FK02_SP FOREIGN KEY(MaDT) REFERENCES DOITAC(MaDT)

-- Khoa ngoai cho bang DONHANG
ALTER TABLE DONHANG ADD CONSTRAINT FK01_DH FOREIGN KEY(MaKH) REFERENCES KHACHHANG(MaKH)
ALTER TABLE DONHANG ADD CONSTRAINT FK02_DH FOREIGN KEY(MaTX) REFERENCES TAIXE(MaTX)

-- Khoa ngoai cho bang CTDONHANG
ALTER TABLE CTDONHANG ADD CONSTRAINT FK01_CTDH FOREIGN KEY(MaDH) REFERENCES DONHANG(MaDH)
ALTER TABLE CTDONHANG ADD CONSTRAINT FK02_CTDH FOREIGN KEY(MaSP) REFERENCES SANPHAM(MaSP)

-- Khoa ngoai cho bang CTQUYEN
ALTER TABLE CTQUYEN ADD CONSTRAINT FK_CTQUYEN FOREIGN KEY(MaQuyen) REFERENCES QUYEN(MaQuyen)

-- Khoa ngoai cho bang USERS_QUYEN
ALTER TABLE USERS_QUYEN ADD CONSTRAINT FK01_UQ FOREIGN KEY(MaQuyen) REFERENCES QUYEN(MaQuyen)
ALTER TABLE USERS_QUYEN ADD CONSTRAINT FK02_UQ FOREIGN KEY(MaUser) REFERENCES USERS(MaUser)
ALTER TABLE USERS_QUYEN ADD CONSTRAINT FK03_UQ FOREIGN KEY(MaUser) REFERENCES DOITAC(MaDT)
ALTER TABLE USERS_QUYEN ADD CONSTRAINT FK04_UQ FOREIGN KEY(MaUser) REFERENCES NHANVIEN(MaNV)
ALTER TABLE USERS_QUYEN ADD CONSTRAINT FK05_UQ FOREIGN KEY(MaUser) REFERENCES TAIXE(MaTX)
ALTER TABLE USERS_QUYEN ADD CONSTRAINT FK06_UQ FOREIGN KEY(MaUser) REFERENCES KHACHHANG(MaKH)
---------------------------------------------------
---------------------------------------------------
set dateformat mdy
---------------------------------------------------
-- KHACHHANG
insert into KHACHHANG values('KH001',N'Nguyễnn Văn A','0123456789', 'nva@gmail.com', N'731 Trần Hưng Đạo', N'Q5', N'TP.HCM')
insert into KHACHHANG values('KH002',N'Trần Ngọc Hân', '0123456789', 'tnhan@gmail.com', N'23/5 Nguyễn Trãi', N'Q5', N'TP.HCM')
insert into KHACHHANG values('KH004',N'Trần Minh Long', '0123456789', 'tmlong@gmail.com', N'50/34 Lê Đại Hành', N'Q10', N'TP.HCM')
insert into KHACHHANG values('KH005',N'Phạm Văn Vinh', '0123456789', 'pvvinh@gmail.com', N'45 Trưng Vương', N'Sơn Tây', N'Hà Nội')
insert into KHACHHANG values('KH006',N'Lê Nhật Minh', '0123456789', 'lnminh@gmail.com', N'34 Trương Định', N'Q3', N'TP.HCM')

--DOITAC
insert into DOITAC values('DT001',N'Thiên Long', N'Trần Ngọc Linh','0123456789', 'tnlinh@gmail.com', N'27 Lê Văn Quới', N'Bình Tân', N'TP.HCM', 15, 500, '3500806643')
insert into DOITAC values('DT002',N'Campus', N'Hà Duy Lập','0123456789', 'hdlap@gmail.com', N'87 Phan Văn Trị', N'Gò Vấp', N'TP.HCM', 7, 173, '0102859048')
insert into DOITAC values('DT003',N'Lock&Lock', N'Trần Hồng Quang','0123456789', 'thquang@gmail.com', N'275 CMT8', N'Q10', N'TP.HCM', 50, 300, '03202869022')
insert into DOITAC values('DT004',N'Vinamilk', N'Trần Lập Nông','0123456789', 'tlnong@gmail.com', N'153 Xô Viết Nghệ Tĩnh', N'Bình Thạnh', N'TP.HCM', 27, 1200, '04523869022')
insert into DOITAC values('DT005',N'LG Electronics', N'Lâm Ngạn Tuấn','0123456789', 'lntuan@gmail.com', N'57 Hoà Hưng', N'Q10', N'TP.HCM', 10, 156, '03205678122')
insert into DOITAC values('DT006',N'Unilever', N'Bá Viễn','0123456789', 'bvien@gmail.com', N'332 Nguyễn Thái Học', N'Q1', N'TP.HCM', 10, 156, '03212348128')

-- NHANVIEN
insert into NHANVIEN values('NV001',N'Nguyễn Như Nhật','927345678','nnnhut@gmail.com')
insert into NHANVIEN values('NV002',N'Lê Thị Phi Yến','987567390','ltpyen@gmail.com')
insert into NHANVIEN values('NV003',N'Nguyễn Văn B','997047382','nvb@gmail.com')
insert into NHANVIEN values('NV004',N'Ngô Thanh Tuấn','913758498','nttuan@gmail.com')
insert into NHANVIEN values('NV005',N'Nguyễn Thị Trúc Thanh','918590387','nttthanh@gmail.com')

--TAIXE
insert into TAIXE values('TX001', N'Vương Tử Dị','0123456789', 'vtudi@gmail.com', N'45 Nguyễn Cảnh Chân', N'Q1', N'TP.HCM', '350080664','64-V1521.87','9706410034567890')
insert into TAIXE values('TX003', N'Vưu Trường Tĩnh','0123456789', 'vttinh@gmail.com', N'873 Lê Hồng Phong', N'Q5', N'TP.HCM', '010285904','64-V1523.69','1234567812345678')
insert into TAIXE values('TX004', N'Thái Từ Khôn','0123456789', 'ttkhon@gmail.com', N'27/53 Đường 3/2', N'Q10', N'TP.HCM', '0320286902','36-Z1582.54','1078668165705213')
insert into TAIXE values('TX005', N'Hoàng Minh Hạo','0123456789', 'hmhao@gmail.com', N'227 Nguyễn Văn Cừ', N'Q5', N'TP.HCM', '0320286902','51-A1756.59','3564803412341234')
insert into TAIXE values('TX006', N'Chu Chính Đình','0123456789', 'ccdinh@gmail.com', N'45/2 An Duong Vuong', N'Q5', N'TP.HCM', '0320286902','59-Z1316.69','4000123456789010')

--LOAISANPHAM
insert into LOAISANPHAM values('01', N'Văn phòng phẩm')
insert into LOAISANPHAM values('02', N'Điện gia dụng')
insert into LOAISANPHAM values('03', N'Đồ gia dụng nhà bếp')
insert into LOAISANPHAM values('04', N'Phụ kiện điện thoại')
insert into LOAISANPHAM values('05', N'Chất Tẩy Rửa')
insert into LOAISANPHAM values('06', N'Chăm sóc da')
insert into LOAISANPHAM values('07', N'Thực phẩm')

--SANPHAM
insert into SANPHAM values('SP0001', N'Bột giặt OMO cửa trên 6kg','DT006','05', N'Túi', 262000, NULL)
insert into SANPHAM values('SP0002', N'Máy lạnh Inverter 1HP V10ENH','DT005','02', N'Cái', 6850000, NULL)
insert into SANPHAM values('SP0003', N'Bột giặt OMO Comfort 720g','DT006','05', N'Túi', 32000, NULL)
insert into SANPHAM values('SP0004', N'Bút bi','DT001','01', N'Cây', 3000, NULL)
insert into SANPHAM values('SP0005', N'Bút lông','DT001','01', N'Cây', 5000, NULL)
insert into SANPHAM values('SP0006', N'Tập 100 trang','DT002','01', N'Chục', 23000, NULL)
insert into SANPHAM values('SP0007', N'Tập 200 trang','DT002','01', N'Quyển', 4500, NULL)
insert into SANPHAM values('SP0008', N'Sữa đặc Ông thọ lon 380g','DT004','07', N'Lon',19000, NULL)
insert into SANPHAM values('SP0009', N'Nước táo ép 100% Vfresh 1 lít','DT006','05', N'Hộp', 40000, NULL)
insert into SANPHAM values('SP0010', N'Hộp bảo quản thủy tinh LocknLock Top Class 2L - Màu xanh dương','DT003','03', N'Hộp', 471000, NULL)

--HOPDONG
insert into HOPDONG values('HD0001', 'DT001','NV003', 262000000, NULL, '06/13/2021','02/01/2022', 3, 10.2)
insert into HOPDONG values('HD0002', 'DT004','NV005', 780000000, NULL, '02/01/2022','06/01/2022', 1, 11)
insert into HOPDONG values('HD0003', 'DT002','NV003', 145000000, NULL, '02/13/2022','07/13/2022', 2, 10.7)
insert into HOPDONG values('HD0004', 'DT005','NV002', 560000000, NULL, '11/11/2021','01/11/2022', 4, 12)
insert into HOPDONG values('HD0005', 'DT003','NV002', 1250000000, NULL, '02/10/2022','08/10/2022', 1, 10)

--DONHANG
insert into DONHANG values('DH0001', 'KH006', '12/10/2021',NULL, NULL, 1, 15000, 1)
insert into DONHANG values('DH0002', 'KH001', '08/11/2021',NULL, NULL, 1, 17000, 2)
insert into DONHANG values('DH0003', 'KH002', '06/11/2021',NULL, NULL, 0, 21000, 2)
insert into DONHANG values('DH0004', 'KH006', '12/23/2021',NULL, NULL, 1, 15000, 3)
insert into DONHANG values('DH0005', 'KH004', '12/19/2021',NULL, NULL, 0, 17000, 1)
insert into DONHANG values('DH0006', 'KH005', '11/10/2021',NULL, NULL, 0, 0, 2)
insert into DONHANG values('DH0007', 'KH002', '01/10/2022',NULL, NULL, 1, 12000, 3)
insert into DONHANG values('DH0008', 'KH006', '01/28/2022',NULL, NULL, 0, 30000, 1)

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
insert into CTDONHANG values('DH0008', 'SP0010', 1)

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