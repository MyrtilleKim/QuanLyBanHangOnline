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
-- Get Product By PartnerID
DROP PROC pr_getProductByPartner
CREATE PROC pr_getProductByPartner
	@madt char(6)
AS
BEGIN
	SELECT BR.BranchID, P.ProductID, P.ProductName, ST.Quantity, P.Price
	FROM (BRANCH BR JOIN STORAGE ST ON BR.BranchID = ST.BranchID) LEFT JOIN PRODUCT P ON ST.ProductID = P.ProductID 
	WHERE BR.PartnerID = @madt
END
---------------------------------------------------
--Thêm mới sản phẩm
DROP PROC pr_InsProd
CREATE PROC pr_InsProd
	@masp char(6), 
	@tensp varchar(100), 
	@malsp char(6),
	@donvi varchar(15),
	@dongia int, 
	@img image
AS
BEGIN
	IF EXISTS(SELECT * FROM PRODUCT WHERE ProductID = @masp OR ProductName = @tensp)
		RETURN 0;
	INSERT INTO PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) VALUES(@masp, @tensp, @malsp, @donvi, @dongia, @img)
	RETURN 1;
END 

DECLARE @kq tinyint
EXEC @kq = pr_InsProd
	'SP0012', 
	'Southern Star Sweetened Condensed Creamer 380g', 
	'08', 
	'Can', 
	17000, 
	'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648207120/Shopping_onl/fc8511700715fa6dd2f4087a03fe304d_lhmjla.jpg'
IF @kq = 0
	PRINT N'Không thể thêm sản phẩm';
ELSE
	PRINT N'Thêm thành công';
---------------------------------------------------
-- Order confirmation
DROP PROC pr_OrderConfirmation
CREATE PROC pr_OrderConfirmation
	@mahd char(6),
	@makh char(6),
	@phiship int,
	@pttt bit
AS
BEGIN
	INSERT INTO RECEIPT (ReceiptID,CustomerID,OrderDate,DeliveryCharges,PaymentMethod) VALUES(@mahd, @makh, GETDATE(), @phiship, @pttt)
END 

EXEC pr_OrderConfirmation 'DH0009','KH0005',15000,1

---------------------------------------------------
-- Get Product By PartnerID
DROP PROC pr_getProductByPartner
CREATE PROC pr_getProductByPartner
	@madt char(6)
AS
BEGIN
	SELECT BR.BranchID, P.ProductID, P.ProductName, PT.ProdTypeName, ST.Quantity, P.Price, P.Unit
	FROM ((BRANCH BR JOIN STORAGE ST ON BR.BranchID = ST.BranchID) LEFT JOIN PRODUCT P ON ST.ProductID = P.ProductID) LEFT JOIN PRODUCT_TYPE PT ON P.ProdTypeID = PT.ProdTypeID
	WHERE BR.PartnerID = @madt
END
EXEC pr_getProductByPartner 'DT0004'
---------------------------------------------------
-- Update Product
DROP PROC pr_ProductUpd
CREATE PROC pr_ProductUpd
	@macn char(6),
	@masp char(6),
	@tensp varchar(100),
	@tonkho int,
	@gia int
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION
		UPDATE PRODUCT SET ProductName = @tensp, Price=@gia, NoInventory = NoInventory + @tonkho -
			(SELECT Quantity FROM STORAGE WHERE BranchID = @macn AND ProductID = @masp) 
			WHERE ProductID = @masp
		UPDATE STORAGE SET Quantity = @tonkho WHERE BranchID = @macn AND ProductID = @masp
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0 ROLLBACK TRAN; 
	END CATCH
END
---------------------------------------------------
-- Take delivery
DROP PROC pr_TakeDelivery
CREATE PROC pr_TakeDelivery
	@madh char(6),
	@matx char(6)
AS
BEGIN 
	IF (SELECT ReceiptStatus FROM RECEIPT WHERE ReceiptID = @madh) != 1
		RETURN 0;
	BEGIN TRY
		BEGIN TRANSACTION 
			UPDATE RECEIPT SET ReceiptStatus = 2 WHERE ReceiptID = @madh
			INSERT INTO DELIVERY_NOTE (ReceiptID, ShipperID) VALUES(@madh,@matx)
		COMMIT TRANSACTION;
		RETURN 1;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; 
		RETURN 0;
	END CATCH
END
DECLARE @kq tinyint
EXEC @kq = pr_TakeDelivery 'DH0001', 'TX0006'
if @kq = 0
	PRINT 'Can not take delivery'
---------------------------------------------------
-- Cancel delivery
DROP PROC pr_CancelDelivery
CREATE PROC pr_CancelDelivery
	@madh char(6)
AS
BEGIN 
	DECLARE @tinhtrang tinyint
	SELECT @tinhtrang=ReceiptStatus FROM RECEIPT WHERE ReceiptID = @madh
	IF @tinhtrang = 1 OR @tinhtrang = 0 OR @tinhtrang = 4
		RETURN 0
	IF NOT EXISTS(SELECT * FROM DELIVERY_NOTE WHERE ReceiptID = @madh)
		RETURN 0
	BEGIN TRANSACTION
		UPDATE RECEIPT SET ReceiptStatus = 1 WHERE ReceiptID = @madh
		DELETE DELIVERY_NOTE WHERE ReceiptID = @madh
	COMMIT TRANSACTION
	RETURN 1
END
DECLARE @kq tinyint
EXEC @kq = pr_CancelDelivery 'DH0001'
if @kq = 0
	PRINT 'Can not Cancel delivery'

