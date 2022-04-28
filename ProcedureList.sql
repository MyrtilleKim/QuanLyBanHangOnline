USE qlbh_onl
GO
---------------------------------------------------
--STORE PROCEDURE & TRANSACTION
/*DROP PROC pr_Total
DROP PROC pr_getReceipt
DROP PROC pr_getReceiptByDistrict
DROP PROC pr_getDeliveryNote
DROP PROC pr_getProductByType
DROP PROC pr_getProductByPartner
DROP PROC pr_ProductUpd
DROP PROC pr_InsProd
DROP PROC pr_OrderConfirmation
DROP PROC pr_addRDetail*/
GO
---------------------------------------------------
--Total
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
GO
---------------------------------------------------
--Get receipt 
CREATE PROC pr_getReceipt
AS
BEGIN
	SELECT R.ReceiptID, C.CustomerName, C.Addr , C.District, R.OrderDate, R.DeliveryCharges 
	FROM RECEIPT R LEFT JOIN CUSTOMER C ON R.CustomerID = C.CustomerID 
	WHERE ReceiptStatus = 1
END
GO
---------------------------------------------------
--Get receipt by District
CREATE PROC pr_getReceiptByDistrict
	@quan varchar(30)
AS
BEGIN
	SELECT R.ReceiptID, C.CustomerName, C.Addr , C.District, R.OrderDate, R.DeliveryCharges 
	FROM RECEIPT R LEFT JOIN CUSTOMER C ON R.CustomerID = C.CustomerID 
	WHERE ReceiptStatus = 1 AND C.District = @quan
END
GO 
---------------------------------------------------
-- Get Delivery note
CREATE PROC pr_getDeliveryNote
	@matx char(6)
AS
BEGIN
	SELECT R.ReceiptID, C.CustomerName, C.Addr , C.District, DN.DeliveryDate, R.DeliveryCharges, R.ReceiptStatus
	FROM DELIVERY_NOTE DN LEFT JOIN RECEIPT R ON DN.ReceiptID = R.ReceiptID LEFT JOIN CUSTOMER C ON R.CustomerID = C.CustomerID 
	WHERE ShipperID = @matx
END
GO
---------------------------------------------------
-- Get Product By Type
CREATE PROC pr_getProductByType
	@malsp char(2)
AS 
BEGIN
	SELECT ProductID, ProductName, Unit, Price, NoInventory, Img 
	FROM dbo.PRODUCT 
	WHERE ProdTypeID = @malsp
END
GO

---------------------------------------------------
-- Get Product By PartnerID
CREATE PROC pr_getProductByPartner
	@madt char(6)
AS
BEGIN
	SELECT BR.BranchID, P.ProductID, P.ProductName, PT.ProdTypeName, ST.Quantity, P.Price, P.Unit
	FROM ((BRANCH BR JOIN STORAGE ST ON BR.BranchID = ST.BranchID) LEFT JOIN PRODUCT P ON ST.ProductID = P.ProductID) LEFT JOIN PRODUCT_TYPE PT ON P.ProdTypeID = PT.ProdTypeID
	WHERE BR.PartnerID = @madt
END
GO
---------------------------------------------------
-- Update Product
CREATE PROC pr_ProductUpd
	@macn char(6),
	@masp char(6),
	@tensp varchar(100),
	@tonkho int,
	@gia int
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION ProductUpd
		UPDATE PRODUCT SET ProductName = @tensp, Price=@gia, NoInventory = NoInventory + @tonkho - (SELECT Quantity FROM STORAGE WHERE BranchID = @macn AND ProductID = @masp) WHERE ProductID = @masp
		UPDATE STORAGE SET Quantity = @tonkho WHERE BranchID = @macn AND ProductID = @masp
				
	COMMIT TRANSACTION ProductUpd
	END TRY
	BEGIN CATCH
	DECLARE @ErrorNumber INT = ERROR_NUMBER();
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE() 
	RAISERROR('Error Number-%d : Error Message-%s', 16, 1, @ErrorNumber, @ErrorMessage)
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION ProductUpd;
	END CATCH
END
GO
---------------------------------------------------
-- Add new products to branch
CREATE PROC pr_InsProd
	@masp char(6), 
	@tensp varchar(100), 
	@malsp char(2),
	@donvi varchar(15),
	@dongia int, 
	@macn char(6),
	@solg int
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM PRODUCT WHERE ProductID = @masp)
		INSERT INTO PRODUCT (ProductID,ProductName,ProdTypeID,Unit,Price) VALUES(@masp, @tensp, @malsp, @donvi, @dongia)
	INSERT INTO STORAGE VALUES(@macn,@masp,@solg)	
END 
GO
/*EXEC pr_InsProd
	'SP0012', 
	'Southern Star Condensed Creamer', 
	'07', 
	'Can', 
	17000, 
--	'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648207120/Shopping_onl/fc8511700715fa6dd2f4087a03fe304d_lhmjla.jpg',
	'CN0007',20

SELECT * FROM RECEIPT
select * from RECEIPT_DETAIL where ReceiptID = 'DH0009'*/
---------------------------------------------------
-- Order confirmation
CREATE PROC pr_OrderConfirmation
	@mahd char(6),
	@makh char(6),
	@phiship int,
	@pttt bit
AS
BEGIN
	INSERT INTO RECEIPT (ReceiptID,CustomerID,OrderDate,DeliveryCharges,PaymentMethod) VALUES(@mahd, @makh, GETDATE(), @phiship, @pttt)
END 
GO
---------------------------------------------------
-- Add Receipt Detail
CREATE PROC pr_addRDetail
	@madh char(6),
	@masp char(6),
	@solg int
AS
BEGIN
	INSERT INTO RECEIPT_DETAIL (ReceiptID,ProductID,Quantity,Price) VALUES(@madh,@masp,@solg,(SELECT Price FROM PRODUCT WHERE ProductID = @masp))
END
GO
---------------------------------------------------
CREATE PROC usp_ProductUpd
	@madt char(6),
	@macn char(6),
	@masp char(6),
	@tensp varchar(100),
	@tonkho int,
	@gia int
AS
BEGIN
	BEGIN TRY
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRANSACTION 
		EXEC pr_getProductByPartner @madt
		DECLARE @ton int
		SET @ton = (SELECT Quantity FROM STORAGE WHERE BranchID = @macn AND ProductID = @masp)
		UPDATE STORAGE SET Quantity = @tonkho WHERE BranchID = @macn AND ProductID = @masp		
		UPDATE PRODUCT SET ProductName = @tensp, Price=@gia, NoInventory = NoInventory + @tonkho - @ton WHERE ProductID = @masp				
	COMMIT TRANSACTION 
	END TRY
	BEGIN CATCH
	DECLARE @ErrorNumber INT = ERROR_NUMBER();
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE() 
	RAISERROR('Error Number-%d : Error Message-%s', 16, 1, @ErrorNumber, @ErrorMessage)
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	END CATCH
END
GO
---------------------------------------------------
CREATE PROC usp_ProductView
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRANSACTION 
		SELECT ProductID, ProductName, Unit, Price, NoInventory,Img FROM PRODUCT		
	COMMIT TRANSACTION 
END
GO
---------------------------------------------------
CREATE PROC usp_Purchase
	@makh char(6), 
	@gia int, 
	@pttt bit, 
	@masp1 char(6), @qty1 int, 
	@masp2 char(6), @qty2 int
AS
BEGIN
	BEGIN TRY
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRANSACTION 
		SELECT ProductID, ProductName, Unit, Price, NoInventory,Img FROM PRODUCT
		WAITFOR DELAY '00:00:20'
		DECLARE @id char(6)
		SET @id = DBO.AUTO_ReceiptID();
		EXEC pr_OrderConfirmation @id, @makh, @gia, @pttt
		EXEC pr_addRDetail @id, @masp1, @qty1
		EXEC pr_addRDetail @id, @masp2, @qty2		
	COMMIT TRANSACTION 
	RETURN 1;
	END TRY
	BEGIN CATCH
	DECLARE @ErrorNumber INT = ERROR_NUMBER();
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE() 
	RAISERROR('Error Number-%d : Error Message-%s', 16, 1, @ErrorNumber, @ErrorMessage)
	WAITFOR DELAY '00:00:20'
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	END CATCH
END
GO
---------------------------------------------------
CREATE PROC usp_getProductByType
	@malsp char(2)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRAN
	EXEC pr_getProductByType '01'
	WAITFOR DELAY '00:00:20'
	EXEC pr_getProductByType '01'
	COMMIT TRAN
END
GO
---------------------------------------------------
CREATE PROC usp_TakeDelivery
	@madh char(6), @matx char(6)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	BEGIN TRAN
		INSERT INTO DELIVERY_NOTE (ReceiptID, ShipperID) values(@madh, @matx)
	COMMIT TRAN
END
GO
---------------------------------------------------
CREATE PROC usp_getReceiptByDistrict
	@quan varchar(30)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	BEGIN TRAN
	EXEC pr_getReceiptByDistrict @quan
	WAITFOR DELAY '00:00:20'
	EXEC pr_getReceiptByDistrict @quan
	COMMIT TRAN
END