--Trans1
CREATE
--ALTER
PROC USP_CoDL1.1
	@GiaSP int
AS
BEGIN TRAN

SET TRAN ISOLATION LEVEL READ COMMITED

	DECLARE @GiaSP_HT int
	SET @GiaSP_HT =(SELECT Price FROM PRODUCT)
	IF (@GiaSP = @GiaSP_HT)
	BEGIN
		PRINT N'New product price you want to change is the same as one before'
		ROLLBACK TRAN
		RETURN 1
	END

		ELSE
		WAITFOR DELAY 'O:O:05'

	BEGIN TRY	
		UPDATE PRODUCT
		SET Price = @GiaSP	
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
PROC USP_CoDL2.1
	@TenSP nvarchar(30)
AS
BEGIN TRAN

SET TRAN ISOLATION LEVEL REPEATABLE READ

	DECLARE @TenSP_HT nvarchar(30)
	SET @TenSP_HT = (SELECT ProductName FROM PRODUCT)
	IF (@TenSP = @TenSP_HT)
	BEGIN
		PRINT N'New product name you want to change is the same as one before'  
		ROLLBACK TRAN
		RETURN 1
	END

		ELSE
		WAITFOR DELAY '0:0:05'

	BEGIN TRY
		UPDATE PRODUCT
		SET ProductName = @TenSP
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