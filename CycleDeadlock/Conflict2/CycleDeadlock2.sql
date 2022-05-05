USE qlbh_onl
GO

DROP PROC USP_CyDL1
DROP PROC USP_CyDL2
GO

--Trans1
CREATE
--ALTER
PROC USP_CyDL1
	@LoaiSP nvarchar(30),
	@TenSP varchar(100),
	@MaSP char(6)
AS
BEGIN
BEGIN TRAN

SET TRAN ISOLATION LEVEL REPEATABLE READ

	IF @MaSP NOT IN (SELECT ProductID FROM PRODUCT)
	BEGIN
		PRINT @MaSP + 'is not a valid product id'  
		ROLLBACK TRAN
		RETURN 1
	END

		ELSE

	BEGIN TRY	
		UPDATE PRODUCT_TYPE
		SET ProdTypeName = @LoaiSP 
		
		WAITFOR DELAY '0:0:05'
		
		UPDATE PRODUCT
		SET ProductName = @TenSP 
		WHERE ProductID = @MaSP 
	END TRY

	BEGIN CATCH
		DECLARE @ErrorMsg VARCHAR(2000)
		SELECT @ErrorMsg = 'ERROR: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMsg, 16,1)
		ROLLBACK TRAN
		RETURN
	END CATCH
		
COMMIT TRAN
END
GO

--Trans2
CREATE
--ALTER
PROC USP_CyDL2
	@LoaiSP nvarchar(30),
	@TenSP varchar(100),
	@MaSP char(6)
AS
BEGIN TRAN

SET TRAN ISOLATION LEVEL REPEATABLE READ

	IF @MaSP NOT IN (SELECT ProductID FROM PRODUCT)
	BEGIN
		PRINT @MaSP + 'is not a valid product id'
		ROLLBACK TRAN
		RETURN 1
	END
		ELSE

	BEGIN TRY
		UPDATE PRODUCT
		SET ProductName = @TenSP 
		WHERE ProductID = @MaSP

		UPDATE PRODUCT_TYPE
		SET ProdTypeName = @LoaiSP 
	END TRY

	BEGIN CATCH
		DECLARE @ErrorMsg VARCHAR(2000)
		SELECT @ErrorMsg = 'ERROR: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMsg, 16,1)
		ROLLBACK TRAN
		RETURN
	END CATCH
		
COMMIT TRAN
GO