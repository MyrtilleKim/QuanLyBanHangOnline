USE qlbh_onl
GO
---------------------------------------------------
--STORE PROCEDURE & TRANSACTION

---------------------------------------------------
--Truyen vao MaGiao, xuat ra tong tien cua phieu giao
DROP PROC pr_Total

CREATE PROC	pr_Total
	@mapg char(6), 
	@tongtien int OUTPUT
AS
BEGIN
	IF NOT EXISTS( SELECT * FROM DELIVERY_DETAIL WHERE DeliveryID = @mapg )
		RETURN 0
	SELECT @tongtien = (SUM(DD.Quantity * DD.Price) + DN.DeliveryCharges)
	FROM DELIVERY_DETAIL DD JOIN DELIVERY_NOTE DN ON DD.DeliveryID = DN.DeliveryID
	WHERE DN.DeliveryID = @mapg
	GROUP BY DN.DeliveryCharges
	RETURN 1
END

DECLARE @tt int 
DECLARE @kq tinyint
EXEC @kq = pr_Total 'PG0003', @tt OUTPUT
IF @kq = 0
	PRINT N'Mã phiếu giao không tồn tại'
ELSE
	PRINT N'Tổng tiền: ' + CAST(@tt as nvarchar(20))

---------------------------------------------------
--Truyền vào MaDH và MaHH, xuất ra số lượng
DROP PROC pr_QuantityProd
CREATE PROC pr_QuantityProd
	@madh char(6), 
	@masp char(6), 
	@soluong int OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM RECEIPT WHERE ReceiptID = @madh)
		RETURN 0;
	SELECT @soluong=Quantity FROM RECEIPT_DETAIL WHERE ReceiptID = @madh AND ProductID = @masp
	IF @soluong IS NULL
		RETURN 0;
	RETURN 1;
END

DECLARE @solg int 
DECLARE @kq tinyint
EXEC @kq = pr_QuantityProd 'DH0001', 'SP0010', @solg OUTPUT
IF @kq = 0
	PRINT N'Mã đơn hàng hoặc mã sản phẩm không tồn tại'
ELSE
	PRINT N'Số lượng sản phẩm có trong đơn hàng: ' + CAST(@solg as nvarchar(5))

---------------------------------------------------
--Truyền vào MaKH, hiện thị lịch sử đơn hàng
DROP PROC pr_ShoppingRec
CREATE PROC pr_ShoppingRec
	@makh char(6)
AS
BEGIN
	SELECT R.ReceiptID, R.OrderDate, DN.DeliveryID, DN.DeliveryDate 
	FROM RECEIPT R LEFT JOIN DELIVERY_NOTE DN ON R.ReceiptID = DN.ReceiptID 
	WHERE R.CustomerID = @makh
END

EXEC pr_ShoppingRec 'KH0001'

---------------------------------------------------
--Thêm mới sản phẩm
DROP PROC pr_InsProd
CREATE PROC pr_InsProd
	@masp char(6), 
	@tensp varchar(100), 
	@madt char(6), 
	@malsp char(6),
	@tonkho int, 
	@donvi varchar(15),
	@dongia int, 
	@img image
AS
BEGIN
	IF EXISTS(SELECT * FROM PRODUCT WHERE ProductID = @masp OR ProductName = @tensp)
		RETURN 0;
	IF @dongia <= 0 OR @tonkho <= 0
		RETURN 0;
	INSERT INTO PRODUCT VALUES(@masp, @tensp, @madt, @malsp, @tonkho, @donvi, @dongia, @img)
	RETURN 1;
END 

DECLARE @kq tinyint
EXEC @kq = pr_InsProd
	'SP0012', 
	'Southern Star Sweetened Condensed Creamer 380g', 
	'DT0004', 
	'08', 500,
	'Can', 
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
CREATE TRIGGER tr_Receipt_DeliNote
ON DELIVERY_NOTE
AFTER INSERT
AS
	DECLARE @madh varchar(6)
	BEGIN
		SELECT @madh = ReceiptID
		FROM inserted

		IF EXISTS(SELECT * FROM DELIVERY_NOTE WHERE ReceiptID = @madh)
		BEGIN 
			RAISERROR (N'Một đơn hàng chỉ có một phiếu giao',16,1)
			ROLLBACK
			RETURN;
		END
	END

---------------------------------------------------
-- Ngày giao hàng phải bằng hoặc sau ngày đặt hàng nhưng không được quá 30 ngày
CREATE TRIGGER tr_DeliDate_OrderDate
ON DELIVERY_NOTE
AFTER INSERT, UPDATE
AS
	DECLARE @madh char(6), @ngaygiao date, @ngaydat date
	--Trường hợp thêm mới
	IF NOT EXISTS (SELECT * FROM deleted)
	BEGIN
		SELECT @madh = ReceiptID, @ngaygiao = DeliveryDate
		FROM inserted

		SELECT @ngaydat = OrderDate 
		FROM RECEIPT
		WHERE ReceiptID = @madh

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
		IF UPDATE(DeliveryDate)
		BEGIN
			SELECT @madh = ReceiptID, @ngaygiao = DeliveryDate
			FROM inserted

			SELECT @ngaydat = OrderDate
			FROM RECEIPT
			WHERE ReceiptID = @madh

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
DROP TRIGGER tr_RenewalRec
CREATE TRIGGER tr_RenewalRec
ON CONTRACTS
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO RENEWAL_REC(
		ContractID,
		StartDate,
		EndDate,
		CommissionP,
		RecTimestamp,
		Operation
	)
	SELECT ins.ContractID, ins.StartDate, ins.EndDate, ins.CommissionP, GETDATE(), 'INS'
	FROM inserted ins
	UNION ALL
	SELECT del.ContractID, del.StartDate, del.EndDate, del.CommissionP, GETDATE(), 'DEL'
	FROM deleted del
END

CREATE TRIGGER tr_RenewalRec_UPD
ON CONTRACTS
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO RENEWAL_REC(
		ContractID,
		StartDate,
		EndDate,
		CommissionP,
		RecTimestamp,
		Operation
	)
	SELECT ins.ContractID, ins.StartDate, ins.EndDate, ins.CommissionP, GETDATE(), 'UPD'
	FROM inserted ins
END