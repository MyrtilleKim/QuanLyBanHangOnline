USE qlbh_onl
GO
---------------------------------------------------
--STORE PROCEDURE & TRANSACTION

---------------------------------------------------
--Truyen vao MaGiao, xuat ra tong tien cua phieu giao
DROP PROC pr_TongTien_PhieuGiao

CREATE PROC	pr_TongTien_PhieuGiao
	@mapg varchar(6), 
	@tongtien int OUTPUT
AS
BEGIN
	IF NOT EXISTS( SELECT * FROM CTPHIEUGIAO WHERE MaGiao = @mapg )
		RETURN 0
	SELECT @tongtien = (SUM(CTPG.SoLuong * CTPG.DonGia) + PG.PhiGiao)
	FROM CTPHIEUGIAO CTPG JOIN PHIEUGIAO PG ON CTPG.MaGiao = PG.MaGiao
	WHERE PG.MaGiao = @mapg
	GROUP BY PG.PhiGiao
	RETURN 1
END

DECLARE @tt int 
DECLARE @kq tinyint
EXEC @kq = pr_TongTien_PhieuGiao 'PG0003', @tt OUTPUT
IF @kq = 0
	PRINT N'Mã phiếu giao không tồn tại'
ELSE
	PRINT N'Tổng tiền: ' + CAST(@tt as nvarchar(20))

---------------------------------------------------
--Truyền vào MaDH và MaHH, xuất ra số lượng
DROP PROC pr_SoLuongSP
CREATE PROC pr_SoLuongSP
	@madh varchar(6), 
	@masp varchar(6), 
	@soluong int OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM DONHANG WHERE MaDH = @madh)
		RETURN 0;
	SELECT @soluong=SoLuong FROM CTDONHANG WHERE MaDH = @madh AND MaSP = @masp
	IF @soluong IS NULL
		RETURN 0;
	RETURN 1;
END

DECLARE @solg int 
DECLARE @kq tinyint
EXEC @kq = pr_SoLuongSP 'DH0001', 'SP0010', @solg OUTPUT
IF @kq = 0
	PRINT N'Mã đơn hàng hoặc mã sản phẩm không tồn tại'
ELSE
	PRINT N'Số lượng sản phẩm có trong đơn hàng: ' + CAST(@solg as nvarchar(5))

---------------------------------------------------
--Truyền vào MaKH, hiện thị lịch sử đơn hàng
DROP PROC pr_LichSuDH
CREATE PROC pr_LichSuDH
	@makh varchar(9)
AS
BEGIN
	SELECT DH.MaDH, DH.NgayDat, PG.MaGiao, PG.NgayGiao 
	FROM DONHANG DH LEFT JOIN PHIEUGIAO PG ON DH.MaDH = PG.MaGiao
	WHERE DH.MaKH = @makh
END

EXEC pr_LichSuDH 'KH0001'

---------------------------------------------------
--Thêm mới sản phẩm
DROP PROC pr_ThemSP
CREATE PROC pr_ThemSP
	@masp varchar(6), 
	@tensp nvarchar(100), 
	@madt varchar(6), 
	@malsp varchar(6),
	@donvi nvarchar(9), 
	@dongia int, 
	@img image
AS
BEGIN
	IF EXISTS(SELECT * FROM SANPHAM WHERE MaSP = @masp OR TenSP = @tensp)
		RETURN 0;
	IF @dongia <= 0
		RETURN 0;
	INSERT INTO SANPHAM (MaSP, TenSP, MaDT, MaLoaiSP, DonVi, DonGia, HinhAnh) VALUES(@masp, @tensp, @madt, @malsp, @donvi, @dongia, @img)
	RETURN 1;
END 

DECLARE @kq tinyint
EXEC @kq = pr_ThemSP 
	'SP0011', 
	N'Creamer đặc Ngôi Sao Phương Nam xanh lá lon 380g', 
	'DT0004', 
	'07', 
	N'Lon', 
	17000, 
	'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648207120/Shopping_onl/fc8511700715fa6dd2f4087a03fe304d_lhmjla.jpg'
IF @kq = 0
	PRINT N'Không thể thêm sản phẩm';
ELSE
	PRINT N'Thêm thành công';

---------------------------------------------------
--TRIGGER
---------------------------------------------------
-- Mỗi đơn đặt hàng chỉ có tối đa 1 phiếu giao hàng
CREATE TRIGGER tr_PhieuGiao_DonHang
ON PHIEUGIAO
AFTER INSERT
AS
	DECLARE @madh varchar(6)
	BEGIN
		SELECT @madh = MaDH
		FROM inserted

		IF EXISTS(SELECT * FROM PHIEUGIAO WHERE MaDH = @madh)
		BEGIN 
			RAISERROR (N'Một đơn hàng chỉ có một phiếu giao',16,1)
			ROLLBACK
			RETURN;
		END
	END

---------------------------------------------------
-- Ngày giao hàng phải bằng hoặc sau ngày đặt hàng nhưng không được quá 30 ngày
CREATE TRIGGER tr_NgayGiao_NgayDat
ON PHIEUGIAO
AFTER INSERT, UPDATE
AS
	DECLARE @madh varchar(6), @ngaygiao date, @ngaydat date
	--Trường hợp thêm mới
	IF NOT EXISTS (SELECT * FROM deleted)
	BEGIN
		SELECT @madh = MaDH, @ngaygiao = NgayGiao
		FROM inserted

		SELECT @ngaydat = NgayDat 
		FROM DONHANG
		WHERE MaDH = @madh

		IF @ngaygiao < @ngaydat
		BEGIN 
			RAISERROR (N'Ngày giao phải sau ngày đặt',16,1)
			ROLLBACK
			RETURN;
		END

		IF DATEDIFF(DD, @ngaydat, @ngaygiao) > 30
		BEGIN
			RAISERROR (N'Ngày giao không thể trễ hơn 30 ngày',16,1)
			ROLLBACK
			RETURN
		END
	END
	ELSE
	--Trường hợp sửa
	BEGIN 
		IF UPDATE(NgayGiao)
		BEGIN
			SELECT @madh = MaDH, @ngaygiao = NgayGiao
			FROM inserted

			SELECT @ngaydat = NgayDat 
			FROM DONHANG
			WHERE MaDH = @madh

			IF @ngaygiao < @ngaydat
			BEGIN 
				RAISERROR (N'Ngày giao phải sau ngày đặt',16,1)
				ROLLBACK
				RETURN;
			END

			IF DATEDIFF(DD, @ngaydat, @ngaygiao) > 30
			BEGIN
				RAISERROR (N'Ngày giao không thể trễ hơn 30 ngày',16,1)
				ROLLBACK
				RETURN
			END
		END
	END

---------------------------------------------------
--Lịch sử gia hạn hợp đồng
DROP TRIGGER tr_LICHSUGIAHAN
CREATE TRIGGER tr_LICHSUGIAHAN
ON HOPDONG
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO LICHSUGIAHAN(
		MaHD,
		NgayHL,
		NgayKT,
		PTHoaHong,
		NgayCapNhat,
		ThaoTac
	)
	SELECT ins.MaHD, ins.NgayBD, ins.NgayKT, ins.PTHoaHong, GETDATE(), 'INS'
	FROM inserted ins
	UNION ALL
	SELECT del.MaHD, del.NgayBD, del.NgayKT, del.PTHoaHong, GETDATE(), 'DEL'
	FROM deleted del
END

CREATE TRIGGER tr_LICHSUGIAHAN_UPD
ON HOPDONG
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO LICHSUGIAHAN(
		MaHD,
		NgayHL,
		NgayKT,
		PTHoaHong,
		NgayCapNhat,
		ThaoTac
	)
	SELECT del.MaHD, del.NgayBD, del.NgayKT, del.PTHoaHong, GETDATE(), 'UPD'
	FROM deleted del
END