USE qlbh_onl
GO
---------------------------------------------------
--STORE PROCEDURE & TRANSACTION

---------------------------------------------------
--Total
DROP PROC pr_Total

CREATE PROC	pr_Total
	@mapg char(6), 
	@tongtien int OUTPUT
AS
BEGIN
	IF NOT EXISTS( SELECT * FROM RECEIPT_DETAIL WHERE ReceiptID = @mapg )
		RETURN 0
	SELECT @tongtien = (SUM(DD.Quantity * DD.Price) + DN.DeliveryCharges)
	FROM RECEIPT_DETAIL DD JOIN RECEIPT DN ON DD.ReceiptID = DN.ReceiptID
	WHERE DN.ReceiptID = @mapg
	GROUP BY DN.DeliveryCharges
	RETURN 1
END

DECLARE @tt int 
DECLARE @kq tinyint
EXEC @kq = pr_Total 'DH0003', @tt OUTPUT
IF @kq = 0
	PRINT N'Mã phiếu giao không tồn tại'
ELSE
	PRINT N'Tổng tiền: ' + CAST(@tt as nvarchar(20))
---------------------------------------------------
--Get receipt 
DROP PROC pr_getReceipt
CREATE PROC pr_getReceipt
AS
BEGIN
	SELECT R.ReceiptID, C.CustomerName, C.Addr , C.District, R.OrderDate, R.DeliveryCharges 
	FROM RECEIPT R LEFT JOIN CUSTOMER C ON R.CustomerID = C.CustomerID 
	WHERE ReceiptStatus = 1
END
EXEC pr_getReceipt
---------------------------------------------------
-- Get Delivery note
DROP PROC pr_getDeliveryNote
CREATE PROC pr_getDeliveryNote
	@matx char(6)
AS
BEGIN
	SELECT R.ReceiptID, C.CustomerName, C.Addr , C.District, DN.DeliveryDate, R.DeliveryCharges, R.ReceiptStatus
	FROM DELIVERY_NOTE DN LEFT JOIN RECEIPT R ON DN.ReceiptID = R.ReceiptID LEFT JOIN CUSTOMER C ON R.CustomerID = C.CustomerID 
	WHERE ShipperID = @matx
END
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
	DECLARE @ErrorNumber INT = ERROR_NUMBER();
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE() 
	RAISERROR('Error Number-%d : Error Message-%s', 16, 1, @ErrorNumber, @ErrorMessage)
	IF @@TRANCOUNT > 0 ROLLBACK TRAN; 
	END CATCH
END
---------------------------------------------------
-- Add new products to branch
DROP PROC pr_InsProd
CREATE PROC pr_InsProd
	@masp char(6), 
	@tensp varchar(100), 
	@malsp char(6),
	@donvi varchar(15),
	@dongia int, 
	@img varchar(200),
	@macn char(6),
	@solg int
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM PRODUCT WHERE ProductID = @masp)
		INSERT INTO PRODUCT (ProductID,ProductName,ProdTypeID,Unit,Price,Img) VALUES(@masp, @tensp, @malsp, @donvi, @dongia,@img)
	INSERT INTO STORAGE VALUES(@macn,@masp,@solg)	
END 

EXEC pr_InsProd
	'SP0012', 
	'Southern Star Condensed Creamer', 
	'07', 
	'Can', 
	17000, 
	'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648207120/Shopping_onl/fc8511700715fa6dd2f4087a03fe304d_lhmjla.jpg',
	'CN0007',20

SELECT * FROM PRODUCT WHERE Price < 50000
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
-- Add Receipt Detail
DROP PROC pr_addRDetail
CREATE PROC pr_addRDetail
	@madh char(6),
	@masp char(6),
	@solg int
AS
BEGIN
	INSERT INTO RECEIPT_DETAIL (ReceiptID,ProductID,Quantity,Price) VALUES(@madh,@masp,@solg,(SELECT Price FROM PRODUCT WHERE ProductID = @masp))
END
EXEC pr_addRDetail 'DH0009', 'SP0002', 1
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
		DECLARE @ErrorNumber INT = ERROR_NUMBER();
		DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE() 
		RAISERROR('Error Number-%d : Error Message-%s', 16, 1, @ErrorNumber, @ErrorMessage)
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

