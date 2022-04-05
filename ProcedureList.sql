USE qlbh_onl
GO
---------------------------------------------------
--STORE PROCEDURE & TRANSACTION

---------------------------------------------------
--Truyen vao MaGiao, xuat ra tong tien cua phieu giao
DROP PROC pr_Total

CREATE PROC	pr_Total
	@mapg char(6), 
	@tongtien int OUTPUT
AS
BEGIN
	IF NOT EXISTS( SELECT * FROM DELIVERY_DETAIL WHERE DeliveryID = @mapg )
		RETURN 0
	SELECT @tongtien = (SUM(DD.Quantity * DD.Price) + DN.DeliveryCharges)
	FROM DELIVERY_DETAIL DD JOIN DELIVERY_NOTE DN ON DD.DeliveryID = DN.DeliveryID
	WHERE DN.DeliveryID = @mapg
	GROUP BY DN.DeliveryCharges
	RETURN 1
END

DECLARE @tt int 
DECLARE @kq tinyint
EXEC @kq = pr_Total 'PG0003', @tt OUTPUT
IF @kq = 0
	PRINT N'Mã phiếu giao không tồn tại'
ELSE
	PRINT N'Tổng tiền: ' + CAST(@tt as nvarchar(20))

---------------------------------------------------
--Truyền vào MaDH và MaHH, xuất ra số lượng
DROP PROC pr_QuantityProd
CREATE PROC pr_QuantityProd
	@madh char(6), 
	@masp char(6), 
	@soluong int OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM RECEIPT WHERE ReceiptID = @madh)
		RETURN 0;
	SELECT @soluong=Quantity FROM RECEIPT_DETAIL WHERE ReceiptID = @madh AND ProductID = @masp
	IF @soluong IS NULL
		RETURN 0;
	RETURN 1;
END

DECLARE @solg int 
DECLARE @kq tinyint
EXEC @kq = pr_QuantityProd 'DH0001', 'SP0010', @solg OUTPUT
IF @kq = 0
	PRINT N'Mã đơn hàng hoặc mã sản phẩm không tồn tại'
ELSE
	PRINT N'Số lượng sản phẩm có trong đơn hàng: ' + CAST(@solg as nvarchar(5))

---------------------------------------------------
---------------------------------------------------
--Thêm mới sản phẩm
DROP PROC pr_InsProd
CREATE PROC pr_InsProd
	@masp char(6), 
	@tensp varchar(100), 
	@malsp char(6),
	@donvi varchar(15),
	@dongia int, 
	@img image
AS
BEGIN
	IF EXISTS(SELECT * FROM PRODUCT WHERE ProductID = @masp OR ProductName = @tensp)
		RETURN 0;
	INSERT INTO PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) VALUES(@masp, @tensp, @malsp, @donvi, @dongia, @img)
	RETURN 1;
END 

DECLARE @kq tinyint
EXEC @kq = pr_InsProd
	'SP0012', 
	'Southern Star Sweetened Condensed Creamer 380g', 
	'08', 
	'Can', 
	17000, 
	'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648207120/Shopping_onl/fc8511700715fa6dd2f4087a03fe304d_lhmjla.jpg'
IF @kq = 0
	PRINT N'Không thể thêm sản phẩm';
ELSE
	PRINT N'Thêm thành công';
---------------------------------------------------
-- Order confirmation
DROP PROC pr_OrderConfirmation
CREATE PROC pr_OrderConfirmation
	@makh char(6),
	@phiship int,
	@pttt bit
AS
BEGIN
	INSERT INTO RECEIPT (CustomerID,OrderDate,DeliveryCharges,PaymentMethod) VALUES(@makh, GETDATE(), @phiship, @pttt)
END 

EXEC pr_OrderConfirmation 'KH0005',15000,1
select * from RECEIPT
SELECT * FROM PRODUCT
---------------------------------------------------
-- Add Receipt Detail
DROP PROC pr_addRDetail
CREATE PROC pr_addRDetail
	@madh char(6),
	@masp char(6),
	@solg int
AS
BEGIN
	/*IF @solg > (SELECT NoInventory FROM PRODUCT WHERE ProductID = @masp)
		RETURN 0;*/
	INSERT INTO RECEIPT_DETAIL (ReceiptID,ProductID,Quantity,Price) VALUES(@madh,@masp,@solg,(SELECT Price FROM PRODUCT WHERE ProductID = @masp))
		--RETURN 1;
END
DECLARE @kq tinyint
EXEC pr_addRDetail 'DH0009', 'SP0002', 1
if(@kq = 0)
	print 'ko có hàng'

---------------------------------------------------
-- Update Inventory
DROP PROC pr_InventoryUpd_UPD
CREATE PROC pr_InventoryUpd_UPD
	@tonkho int
AS
BEGIN
	
END