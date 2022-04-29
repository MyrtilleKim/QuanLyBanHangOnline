--Trans1
CREATE
--ALTER
PROC USP_CyDL1.2
	@LoaiSP nvarchar(30),
	@MaSP char(6)
AS
BEGIN TRAN

SET TRAN ISOLATION LEVEL REPEATABLE READ

	IF @MaSP NOT IN (SELECT ProductID FROM PRODUCT)
	BEGIN
		PRINT @MaSP + N'is not a valid product id'  
		ROLLBACK TRAN
		RETURN 1
	END

		ELSE
		WAITFOR DELAY 'O:O:05'

	BEGIN TRY	
		UPDATE PRODUCT_TYPE
		SET ProdTypeName = @LoaiSP 
		
		UPDATE PRODUCT
		SET ProductName = @TenSP 
		WHERE ProductID = @MaSP 
	END TRY

	BEGIN CATCH
		DECLARE @ErrorMsg VARCHAR(2000)
		SELECT @ErrorMsg = N'ERROR: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMsg, 16,1)
		ROLLBACK TRAN
		RETURN
	END CATCH
		
COMMIT TRAN
GO

--Trans2
CREATE
--ALTER
PROC USP_CyDL2.2
	@LoaiSP nvarchar(30),
	@MaSP char(6)
AS
BEGIN TRAN

SET TRAN ISOLATION LEVEL REPEATABLE READ

	IF @MaSP NOT IN (SELECT ProductID FROM PRODUCT)
	BEGIN
		PRINT @MaSP + N'is not a valid product id'
		ROLLBACK TRAN
		RETURN 1
	END

		ELSE

	BEGIN TRY
		UPDATE PRODUCT_TYPE
		SET ProdTypeName = @LoaiSP		

		UPDATE PRODUCT
		SET ProductName = @TenSP 
		WHERE ProductID = @MaSP 
	END TRY

	BEGIN CATCH
		DECLARE @ErrorMsg VARCHAR(2000)
		SELECT @ErrorMsg = N'ERROR: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMsg, 16,1)
		ROLLBACK TRAN
		RETURN
	END CATCH
		
COMMIT TRAN
GO