CREATE PROC usp_getReceiptByDistrict
	@quan varchar(30)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	BEGIN TRAN
	EXEC pr_getReceiptByReceipt 'District 5'
	WAITFOR DELAY '00:00:20'
	EXEC pr_getReceiptByReceipt 'District 5'
	COMMIT TRAN
END