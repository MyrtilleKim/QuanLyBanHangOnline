USE qlbh_onl
GO
-------------------------------------------------------------------
CREATE PROC usp_Purchase_Fix
	@makh char(6), 
	@gia int, 
	@pttt bit, 
	@masp1 char(6), @qty1 int, 
	@masp2 char(6), @qty2 int
AS
BEGIN
	BEGIN TRY
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
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
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	END CATCH
END
-------------------------------------------------------------------
CREATE PROC usp_ProductUpdQty_Fix
	@madt char(6),
	@macn char(6),
	@masp char(6),
	@tensp varchar(100),
	@tonkho int,
	@gia int
AS
BEGIN
	BEGIN TRY
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
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