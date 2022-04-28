USE qlbh_onl
GO
CREATE PROC usp_getReceiptByDistrict
	@quan varchar(30)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	BEGIN TRAN
	EXEC pr_getReceiptByReceipt @quan
	WAITFOR DELAY '00:00:20'
	EXEC pr_getReceiptByReceipt @quan
	COMMIT TRAN
END

CREATE PROC usp_TakeDelivery
	@madh char(6), @matx char(6)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	BEGIN TRAN
		INSERT INTO DELIVERY_NOTE (ReceiptID, ShipperID) values(@madh, @matx)
	COMMIT TRAN
END