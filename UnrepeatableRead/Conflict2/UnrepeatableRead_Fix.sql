CREATE PROC usp_getReceiptByDistrict_Fix3
	@quan varchar(30)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
	BEGIN TRAN
	EXEC pr_getReceiptByReceipt 'District 5'
	WAITFOR DELAY '00:00:20'
	EXEC pr_getReceiptByReceipt 'District 5'
	COMMIT TRAN
END

