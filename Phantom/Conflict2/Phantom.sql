CREATE PROC usp_getProductByPrice
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRAN
	SELECT ProductID, ProductName, Unit, Price, NoInventory,Img FROM PRODUCT WHERE Price < 50000 
	WAITFOR DELAY '00:00:20'
	SELECT ProductID, ProductName, Unit, Price, NoInventory,Img FROM PRODUCT WHERE Price < 50000 
	COMMIT TRAN
END
GO
CREATE PROC usp_InsProd
	@masp char(6), 
	@tensp varchar(100), 
	@malsp char(2),
	@donvi varchar(15),
	@dongia int, 
	@macn char(6),
	@solg int
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRAN
		IF NOT EXISTS(SELECT * FROM PRODUCT WHERE ProductID = @masp)
			INSERT INTO PRODUCT (ProductID,ProductName,ProdTypeID,Unit,Price) VALUES(@masp, @tensp, @malsp, @donvi, @dongia)
		INSERT INTO STORAGE VALUES(@macn,@masp,@solg)	
	COMMIT TRAN
END