CREATE PROC usp_getReceiptByDistrict_Fix3
	@quan varchar(30)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
	BEGIN TRAN
	EXEC pr_getReceiptByReceipt @quan
	WAITFOR DELAY '00:00:20'
	EXEC pr_getReceiptByReceipt @quan
	COMMIT TRAN
END

CREATE PROC usp_TakeDelivery_Fix
	@madh char(6), @matx char(6)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
	BEGIN TRAN
		INSERT INTO DELIVERY_NOTE (ReceiptID, ShipperID) values(@madh, @matx)
	COMMIT TRAN
END

