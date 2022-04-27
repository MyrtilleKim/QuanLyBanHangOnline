USE qlbh_onl
GO

-------------------------------------------------------------------
CREATE PROC usp_Purchase_Fix2
	@makh char(6), 
	@gia int, 
	@pttt bit, 
	@masp1 char(6), @qty1 int, 
	@masp2 char(6), @qty2 int
AS
BEGIN
	BEGIN TRY
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
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
-------------------------------------------------------------------
CREATE PROC usp_ProductView_Fix
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION 
		SELECT ProductID, ProductName, Unit, Price, NoInventory,Img FROM PRODUCT		
	COMMIT TRANSACTION 
END