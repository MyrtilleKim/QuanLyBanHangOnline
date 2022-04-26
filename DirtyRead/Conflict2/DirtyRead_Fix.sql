USE qlbh_onl
GO
-------------------------------------------------------------------
CREATE PROC usp_ProductUpd_Fix
	@macn char(6),
	@masp char(6),
	@tensp varchar(100),
	@tonkho int,
	@gia int
AS
BEGIN
	BEGIN TRY
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION 
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
-------------------------------------------------------------------
CREATE PROC usp_ProductView_Fix
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION 
		SELECT ProductID, ProductName, Unit, Price, NoInventory,Img FROM PRODUCT		
	COMMIT TRANSACTION 
END