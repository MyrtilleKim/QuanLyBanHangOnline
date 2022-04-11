/*CREATE DATABASE qlbh_onl ON PRIMARY
( NAME = qlbh_data, FILENAME = 'D:\CSDL\qlbh_data.mdf', SIZE = 10, MAXSIZE = 1000, FILEGROWTH = 10)
LOG ON
( NAME = qlbh_log, FILENAME = 'D:\CSDL\qlbh_log.ldf', SIZE = 10, FILEGROWTH = 5)*/

USE qlbh_onl
GO
DROP TABLE RECEIPT_DETAIL
DROP TABLE DELIVERY_NOTE
DROP TABLE RECEIPT
DROP TABLE STORAGE 
DROP TABLE BRANCH
DROP TABLE PRODUCT
DROP TABLE PRODUCT_TYPE
DROP TABLE CUSTOMER
DROP TABLE SHIPPER
DROP TABLE ADMINS
DROP TABLE RENEWAL_REC
DROP TABLE CONTRACTS
DROP TABLE PARTNERS
DROP TABLE STAFF
DROP TABLE ACCOUNT
DROP FUNCTION AUTO_RecID
DROP FUNCTION AUTO_ReceiptID
GO
CREATE FUNCTION AUTO_RecID()
RETURNS CHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(RecID) FROM RENEWAL_REC) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(RecID, 3)) FROM RENEWAL_REC
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'RR000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'RR00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'RR0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
---------------------------------------------------
CREATE FUNCTION AUTO_ReceiptID()
RETURNS CHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(ReceiptID) FROM RECEIPT) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(ReceiptID, 3)) FROM RECEIPT
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'DH000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'DH00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'DH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
---------------------------------------------------
-- ACCOUNT
CREATE TABLE ACCOUNT
(
	Email varchar(30) NOT NULL PRIMARY KEY,
	Pass varchar(30) NOT NULL,
	Roles char(2) NOT NULL
	CHECK(Roles = 'AD' OR Roles = 'DT' OR Roles = 'NV' OR Roles = 'TX' OR Roles = 'KH')
)

---------------------------------------------------
-- SHIPPER
CREATE TABLE SHIPPER
(
	ShipperID char(6) NOT NULL PRIMARY KEY,
	ShipperName varchar(30),
	Tele varchar(15),
	Email varchar(30) NOT NULL,
	Addr varchar(50),
	District varchar(30),
	NoID varchar(12),
	NoPlate varchar(15),
	NoAcc varchar(20)
)


---------------------------------------------------
-- CUSTOMER
CREATE TABLE CUSTOMER
(
	CustomerID char(6) NOT NULL PRIMARY KEY,
	CustomerName varchar(30),	
	Tele varchar(15),
	Email varchar(30) NOT NULL,
	Addr varchar(50),
	District varchar(30),
)

---------------------------------------------------
-- STAFF
CREATE TABLE STAFF
(
	StaffID char(6) NOT NULL PRIMARY KEY,
	StaffName varchar(30),
	Email varchar(30) NOT NULL,
)

---------------------------------------------------
-- ADMINS
CREATE TABLE ADMINS
(
	AdminID char(6) NOT NULL PRIMARY KEY,
	AdminName varchar(30) NOT NULL,
	Email varchar(30) NOT NULL
)

---------------------------------------------------
-- PARTNERS
CREATE TABLE PARTNERS
(
	PartnerID char(6) NOT NULL PRIMARY KEY,
	PartnerName varchar(30),
	Representative varchar(30),
	Addr varchar(50),
	District varchar(30),
	Tele varchar(15),
	Email varchar(30) NOT NULL,
	NoBranch int,
	TaxCode varchar(15) 
)

---------------------------------------------------
-- BRANCH
CREATE TABLE BRANCH
(
	BranchID char(6) NOT NULL PRIMARY KEY,
	PartnerID char(6) NOT NULL,
	Addr varchar(50),
	District varchar(30),
)

---------------------------------------------------
-- STORAGE
CREATE TABLE STORAGE
(
	BranchID char(6) NOT NULL,
	ProductID char(6) NOT NULL,
	Quantity int,
	PRIMARY KEY(BranchID, ProductID),
	CHECK(Quantity >= 0)
)
---------------------------------------------------
-- CONTRACTS
CREATE TABLE CONTRACTS
(
	ContractID char(6) NOT NULL PRIMARY KEY,
	PartnerID char(6) NOT NULL,
	StaffID char(6),
	Sales int,
	Duration int,
	StartDate date,
	EndDate date,
	ContractStatus int,
	CommissionP float
)
---------------------------------------------------
-- RENEWAL_REC
CREATE TABLE RENEWAL_REC
(
	RecID char(6) PRIMARY KEY CONSTRAINT IDKH DEFAULT DBO.AUTO_RecID(),
	ContractID char(6) NOT NULL,
	StartDate date,
	EndDate date,
	CommissionP float,
	RecTimestamp datetime NOT NULL,
	Operation char(3) NOT NULL
	CHECK(Operation = 'INS' OR Operation = 'UPD' OR Operation = 'DEL')
)

---------------------------------------------------
-- PRODUCT
CREATE TABLE PRODUCT 
(
	ProductID char(6) NOT NULL PRIMARY KEY,
	ProductName varchar(100) NOT NULL,
	ProdTypeID char(6) NOT NULL,
	NoInventory int DEFAULT 0,
	Unit varchar(30),
	Price int,
	Img varchar(200),
	CHECK (NoInventory >= 0)
)

---------------------------------------------------
-- PRODUCT_TYPE
CREATE TABLE PRODUCT_TYPE
(
	ProdTypeID char(6) NOT NULL PRIMARY KEY,
	ProdTypeName varchar(30)
)

---------------------------------------------------
-- RECEIPT
CREATE TABLE RECEIPT
(
	ReceiptID char(6) NOT NULL PRIMARY KEY,
	CustomerID char(6) NOT NULL,
	OrderDate date NOT NULL,
	DeliveryCharges int NOT NULL,
	PaymentMethod bit NOT NULL,
	ReceiptStatus tinyint NOT NULL DEFAULT 1,
	CHECK(ReceiptStatus = 0 OR ReceiptStatus = 1 OR ReceiptStatus = 2 OR ReceiptStatus = 3 OR ReceiptStatus = 4)
)

---------------------------------------------------
-- RECEIPT_DETAIL
CREATE TABLE RECEIPT_DETAIL
(
	ReceiptID char(6) NOT NULL,
	ProductID char(6) NOT NULL,
	Quantity int,
	Price int,
	PRIMARY KEY(ReceiptID, ProductID),
	CHECK (Quantity > 0)
)

---------------------------------------------------
-- DELIVERY_NOTE
CREATE TABLE DELIVERY_NOTE
(
	ReceiptID char(6) NOT NULL UNIQUE,
	ShipperID char(6) NOT NULL,
	DeliveryDate Date,
	PRIMARY KEY(ReceiptID, ShipperID)
)
GO
---------------------------------------------------
-- Foreign key for table PARTNERS
ALTER TABLE PARTNERS ADD CONSTRAINT FK_DT FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Foreign key for table STAFF
ALTER TABLE STAFF ADD CONSTRAINT FK_NV FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Foreign key for table CUSTOMER
ALTER TABLE CUSTOMER ADD CONSTRAINT FK_KH FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Foreign key for table SHIPPER
ALTER TABLE SHIPPER ADD CONSTRAINT FK_TX FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Foreign key for table ADMINS
ALTER TABLE ADMINS ADD CONSTRAINT FK_AD FOREIGN KEY(Email) REFERENCES ACCOUNT(Email)

-- Foreign key for table CONTRACTS
ALTER TABLE CONTRACTS ADD CONSTRAINT FK01_HD FOREIGN KEY(PartnerID) REFERENCES PARTNERS(PartnerID)
ALTER TABLE CONTRACTS ADD CONSTRAINT FK02_HD FOREIGN KEY(StaffID) REFERENCES STAFF(StaffID)

-- Foreign key for table RENEWAL_REC
ALTER TABLE RENEWAL_REC ADD CONSTRAINT FK_LSGH FOREIGN KEY(ContractID) REFERENCES CONTRACTS(ContractID)

-- Foreign key for table PRODUCT
ALTER TABLE PRODUCT ADD CONSTRAINT FK01_SP FOREIGN KEY(ProdTypeID) REFERENCES PRODUCT_TYPE(ProdTypeID)

-- Foreign key for table BRANCH
ALTER TABLE BRANCH ADD CONSTRAINT FK_CN FOREIGN KEY(PartnerID) REFERENCES PARTNERS(PartnerID)

-- Foreign key for table STORAGE
ALTER TABLE STORAGE ADD CONSTRAINT FK01_LK FOREIGN KEY(BranchID) REFERENCES BRANCH(BranchID)
ALTER TABLE STORAGE ADD CONSTRAINT FK02_LK FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)

-- Foreign key for table RECEIPT
ALTER TABLE RECEIPT ADD CONSTRAINT FK_DH FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)

-- Foreign key for table RECEIPT_DETAIL
ALTER TABLE RECEIPT_DETAIL ADD CONSTRAINT FK01_CTDH FOREIGN KEY(ReceiptID) REFERENCES RECEIPT(ReceiptID)
ALTER TABLE RECEIPT_DETAIL ADD CONSTRAINT FK02_CTDH FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)

-- Foreign key for table DELIVERY_NOTE
ALTER TABLE DELIVERY_NOTE ADD CONSTRAINT FK01_PG FOREIGN KEY(ReceiptID) REFERENCES RECEIPT(ReceiptID)
ALTER TABLE DELIVERY_NOTE ADD CONSTRAINT FK02_PG FOREIGN KEY(ShipperID) REFERENCES SHIPPER(ShipperID)

---------------------------------------------------
-- Contraint
ALTER TABLE RECEIPT ADD CONSTRAINT DF_DH DEFAULT GETDATE() FOR OrderDate

---------------------------------------------------
--TRIGGER
---------------------------------------------------
-- Ngày giao hàng phải bằng hoặc sau ngày đặt hàng nhưng không được quá 30 ngày
/*CREATE TRIGGER tr_DeliDate_OrderDate
ON DELIVERY_NOTE
AFTER INSERT, UPDATE
AS
	DECLARE @madh char(6), @ngaygiao date, @ngaydat date
	--Trường hợp thêm mới
	IF NOT EXISTS (SELECT * FROM deleted)
	BEGIN
		SELECT @madh = ReceiptID, @ngaygiao = DeliveryDate
		FROM inserted

		SELECT @ngaydat = OrderDate 
		FROM RECEIPT
		WHERE ReceiptID = @madh

		IF @ngaygiao < @ngaydat
		BEGIN 
			RAISERROR (N'Ngày giao phải sau ngày đặt',16,1)
			ROLLBACK
			RETURN;
		END

		IF DATEDIFF(DD, @ngaydat, @ngaygiao) > 30
		BEGIN
			RAISERROR (N'Ngày giao không thể trễ hơn 30 ngày',16,1)
			ROLLBACK
			RETURN
		END
	END
	ELSE
	--Trường hợp sửa
	BEGIN 
		IF UPDATE(DeliveryDate)
		BEGIN
			SELECT @madh = ReceiptID, @ngaygiao = DeliveryDate
			FROM inserted

			SELECT @ngaydat = OrderDate
			FROM RECEIPT
			WHERE ReceiptID = @madh

			IF @ngaygiao < @ngaydat
			BEGIN 
				RAISERROR (N'Ngày giao phải sau ngày đặt',16,1)
				ROLLBACK
				RETURN;
			END

			IF DATEDIFF(DD, @ngaydat, @ngaygiao) > 30
			BEGIN
				RAISERROR (N'Ngày giao không thể trễ hơn 30 ngày',16,1)
				ROLLBACK
				RETURN
			END
		END
	END*/
---------------------------------------------------
--Lịch sử gia hạn hợp đồng
CREATE TRIGGER tr_RenewalRec
ON CONTRACTS
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO RENEWAL_REC(
		ContractID,
		StartDate,
		EndDate,
		CommissionP,
		RecTimestamp,
		Operation
	)
	SELECT ins.ContractID, ins.StartDate, ins.EndDate, ins.CommissionP, GETDATE(), 'INS'
	FROM inserted ins
	UNION ALL
	SELECT del.ContractID, del.StartDate, del.EndDate, del.CommissionP, GETDATE(), 'DEL'
	FROM deleted del
END
---------------------------------------------------
CREATE TRIGGER tr_RenewalRec_UPD
ON CONTRACTS
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO RENEWAL_REC(
		ContractID,
		StartDate,
		EndDate,
		CommissionP,
		RecTimestamp,
		Operation
	)
	SELECT ins.ContractID, ins.StartDate, ins.EndDate, ins.CommissionP, GETDATE(), 'UPD'
	FROM inserted ins
END
---------------------------------------------------
-- Inventory Update
CREATE TRIGGER tr_InventoryUpd_INS
ON STORAGE
AFTER INSERT
AS
BEGIN
	UPDATE PRODUCT SET NoInventory = NoInventory + (
		SELECT Quantity FROM inserted WHERE ProductID = PRODUCT.ProductID
	)FROM PRODUCT JOIN inserted ins ON PRODUCT.ProductID = ins.ProductID	
END
---------------------------------------------------
CREATE TRIGGER tr_InventoryUpd_DEL
ON STORAGE
AFTER DELETE
AS
BEGIN
	UPDATE PRODUCT SET NoInventory = NoInventory - (
		SELECT Quantity FROM deleted WHERE ProductID = PRODUCT.ProductID
	)FROM PRODUCT JOIN deleted del ON PRODUCT.ProductID = del.ProductID	
END
---------------------------------------------------
-- Update Inventory_Receipt
CREATE TRIGGER tr_InventoryReceipt_INS
ON RECEIPT_DETAIL
AFTER INSERT
AS
BEGIN
	UPDATE PRODUCT SET NoInventory = NoInventory - (
		SELECT Quantity FROM inserted WHERE ProductID = PRODUCT.ProductID
	)FROM PRODUCT JOIN inserted ins ON PRODUCT.ProductID = ins.ProductID	
END
---------------------------------------------------
CREATE TRIGGER tr_InventoryReceipt_UPD
ON RECEIPT_DETAIL
AFTER UPDATE
AS
BEGIN
	UPDATE PRODUCT SET NoInventory = NoInventory - (
		SELECT Quantity FROM inserted WHERE ProductID = PRODUCT.ProductID) +
		(SELECT Quantity FROM deleted WHERE ProductID = PRODUCT.ProductID
	)FROM PRODUCT JOIN deleted del ON PRODUCT.ProductID = del.ProductID		
END
---------------------------------------------------
CREATE TRIGGER tr_InventoryReceipt_DEL
ON RECEIPT_DETAIL
AFTER DELETE
AS
BEGIN
	UPDATE PRODUCT SET NoInventory = NoInventory + (
		SELECT Quantity FROM deleted WHERE ProductID = PRODUCT.ProductID
	)FROM PRODUCT JOIN deleted del ON PRODUCT.ProductID = del.ProductID	
END
---------------------------------------------------
---------------------------------------------------
set dateformat dmy
---------------------------------------------------
-- ACCOUNT
insert into ACCOUNT values('nva@gmail.com','123456','KH')
insert into ACCOUNT values('tnhan@gmail.com','123456','KH')
insert into ACCOUNT values('tmlong@gmail.com','123456','KH')
insert into ACCOUNT values('pvvinh@gmail.com','123456','KH')
insert into ACCOUNT values('lnminh@gmail.com','123456','KH')
insert into ACCOUNT values('tnlinh@gmail.com','123456','DT')
insert into ACCOUNT values('bvien@gmail.com','123456','DT')
insert into ACCOUNT values('hdlap@gmail.com','123456','DT')
insert into ACCOUNT values('thquang@gmail.com','123456','DT')
insert into ACCOUNT values('tlnong@gmail.com','123456','DT')
insert into ACCOUNT values('lntuan@gmail.com','123456','DT')
insert into ACCOUNT values('nnnhut@gmail.com','123456','NV')
insert into ACCOUNT values('ltpyen@gmail.com','123456','NV')
insert into ACCOUNT values('nvb@gmail.com','123456','NV')
insert into ACCOUNT values('nttuan@gmail.com','123456','NV')
insert into ACCOUNT values('nttthanh@gmail.com','123456','NV')
insert into ACCOUNT values('vtudi@gmail.com','123456','TX')
insert into ACCOUNT values('vttinh@gmail.com','123456','TX')
insert into ACCOUNT values('ttkhon@gmail.com','123456','TX')
insert into ACCOUNT values('hmhao@gmail.com','123456','TX')
insert into ACCOUNT values('ccdinh@gmail.com','123456','TX')
insert into ACCOUNT values('ptthua@gmail.com','123456','AD')
insert into ACCOUNT values('tquy@gmail.com','123456','AD')

--ADMINS
insert into ADMINS values('AD0001','Pham Thua Thua', 'ptthua@gmail.com')
insert into ADMINS values('AD0002', 'Tieu Quy', 'tquy@gmail.com')

-- CUSTOMER
insert into CUSTOMER values('KH0001', 'Nguyen Van A','0123456789', 'nva@gmail.com', '731 Tran Hung Đao Street', 'District 5')
insert into CUSTOMER values('KH0002', 'Tran Ngoc Han', '0123456789', 'tnhan@gmail.com', '23/5 Nguyen Trai Street', 'District 5')
insert into CUSTOMER values('KH0004', 'Tran Minh Long', '0123456789', 'tmlong@gmail.com', '50/34 Le Đai Hanh Street', 'District 10')
insert into CUSTOMER values('KH0005', 'Pham Van Vinh', '0123456789', 'pvvinh@gmail.com', '45 Trung Vuong Street', 'District 1')
insert into CUSTOMER values('KH0006', 'Le Nhat Minh', '0123456789', 'lnminh@gmail.com', '34 Truong Dinh Street', 'District 3')

-- PARTNERS
insert into PARTNERS values('DT0001', 'Thien Long', 'Tran Ngoc Linh','123 Le Van Sy','Phu Nhuan District','0123456789', 'tnlinh@gmail.com', NULL, '3500806643')
insert into PARTNERS values('DT0002', 'Campus', 'Ha Duy Lap','875/52 Tran Van Dang','Tan Phu District','0123456789', 'hdlap@gmail.com', NULL, '0102859048')
insert into PARTNERS values('DT0003', 'Lock&Lock', 'Tran Hong Quang','23/745 Nguyen Van Troi','Binh Tan District','0123456789', 'thquang@gmail.com', NULL, '03202869022')
insert into PARTNERS values('DT0004', 'Vinamilk', 'Tran Lap Nong','54 Binh Tri Dong A','Binh Tan District','0123456789', 'tlnong@gmail.com', NULL, '04523869022')
insert into PARTNERS values('DT0005', 'LG Electronics', 'Lam Ngan Tuan','532 CMT8','District 10','0123456789', 'lntuan@gmail.com', NULL, '03205678122')
insert into PARTNERS values('DT0006', 'Unilever', 'Ba Vien','846 Phan Van Tri','District 6','0123456789', 'bvien@gmail.com', NULL, '03212348128')

-- BRANCH
insert into BRANCH values('CN0001','DT0001','27 Le Van Quoi Street', 'Binh Tan District')
insert into BRANCH values('CN0002','DT0001','87 Phan Van Tri Street', 'Go Vap District')
insert into BRANCH values('CN0003','DT0001','275 CMT8 Street', 'District 10')
insert into BRANCH values('CN0004','DT0005','57 Hoa Hung Street', 'District 10')
insert into BRANCH values('CN0005','DT0006','332 Nguyen Thai Hoc Street', 'District 1')
insert into BRANCH values('CN0006','DT0004','153 Xo Viet Nghe Tinh Street', 'Binh Thanh District')
insert into BRANCH values('CN0007','DT0004','12 Street 3/2', 'District 10')
insert into BRANCH values('CN0008','DT0004','283 Nguyen Thuong Hien Street', 'District 10')
insert into BRANCH values('CN0009','DT0004','857 Le Hong Phong Street', 'District 5')
insert into BRANCH values('CN0010','DT0003','51 Vo Thi Sau Street', 'Tan Binh District')
insert into BRANCH values('CN0011','DT0002','454 Tan Ki Tan Quy Street', 'Binh Chanh District')
insert into BRANCH values('CN0012','DT0002','87 Bach Dang Street', 'District 1')

-- STAFF
insert into STAFF values('NV0001','Nguyen Nhu Nhat','nnnhut@gmail.com')
insert into STAFF values('NV0002','Le Thi Phi Yen','ltpyen@gmail.com')
insert into STAFF values('NV0003','Nguyen Van B','nvb@gmail.com')
insert into STAFF values('NV0004','Ngo Thanh Tuan','nttuan@gmail.com')
insert into STAFF values('NV0005','Nguyen Thi Truc Thanh','nttthanh@gmail.com')

-- SHIPPER
insert into SHIPPER values('TX0001', 'Vuong Tu Di','0123456789', 'vtudi@gmail.com', '45 Nguyen Canh Chan Street', 'District 1', '350080664','64-V1521.87','9706410034567890')
insert into SHIPPER values('TX0003', 'Vuu Truong Tinh','0123456789', 'vttinh@gmail.com', '873 Le Hong Phong Street', 'District 5', '010285904','64-V1523.69','1234567812345678')
insert into SHIPPER values('TX0004', 'Thai Tu Khon','0123456789', 'ttkhon@gmail.com', '27/53 Street 3/2', 'District 10', '0320286902','36-Z1582.54','1078668165705213')
insert into SHIPPER values('TX0005', 'Hoang Minh Hao','0123456789', 'hmhao@gmail.com', '227 Nguyen Van Cu Street', 'District 5', '0320286902','51-A1756.59','3564803412341234')
insert into SHIPPER values('TX0006', 'Chu Chinh Đinh','0123456789', 'ccdinh@gmail.com', '45/2 An Duong Vuong Street', 'District 5', '0320286902','59-Z1316.69','4000123456789010')

-- PRODUCT_TYPE
insert into PRODUCT_TYPE values('01', 'Stationery')
insert into PRODUCT_TYPE values('02', 'Electric Appliances')
insert into PRODUCT_TYPE values('03', 'Kitchen Utensils & Appliances')
insert into PRODUCT_TYPE values('04', 'Phone Accessories')
insert into PRODUCT_TYPE values('05', 'Detergents')
insert into PRODUCT_TYPE values('06', 'Beauty & Personal Care')
insert into PRODUCT_TYPE values('07', 'Food')
insert into PRODUCT_TYPE values('08', 'Beverage')

-- PRODUCT
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0001', 'OMO Powder 6kg ','05', 'Pack', 262000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648138549/Shopping_onl/Bot-Giat-Omo-6kg_q4lden.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0002', 'Air conditioner','02', 'Piece', 6850000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648138680/Shopping_onl/May-lanh-LG-1-HP-V10ENH-Inverter-Chinh-Hang-1_xzii6t.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0003', 'OMO Powder 720g','05', 'Pack', 32000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648185476/Shopping_onl/8934868135029_mob01a.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0004', 'Pen TL-027','01', 'Piece', 3000, 'https://res.cloudinary.com/gia-minh/image/upload/v1649232433/but_bi_thien_long_kz5kyf.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0005', 'Oil brush PM-04','01', 'Piece', 5000, 'https://res.cloudinary.com/gia-minh/image/upload/v1649232591/but_long_dau_thien_long_anfhsh.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0006', '100-page nobook','01', 'Pack of 10', 23000, 'https://res.cloudinary.com/gia-minh/image/upload/v1649232652/tap-100-trang-lang-huong-37_gaouas.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0007', '200-page nobook','01', 'Piece', 4500, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648188654/Shopping_onl/tap-sinh-vien-ke-ngang-campus-great-200-trang-qh64r_123f1ef94abf41c981e50a555b249634_cxa0ok.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0008', 'OngTho milk 480','07', 'Can', 19000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189010/Shopping_onl/sua-dac-co-duong-ong-tho-trang-nhan-xanh-lon-380g-201911071524564853_1_mkbxbc.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0009', 'Juice-Apple 1L ','07', 'Pack', 40000, 'https://res.cloudinary.com/gia-minh/image/upload/v1649232786/nuoc_ep_oroxta.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0010', 'Glass storage  ','03', 'Box', 471000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189207/Shopping_onl/JVjoEIfp6XMcc3wBSSwH_simg_de2fe0_500x500_maxb_mkvta6.jpg')
insert into PRODUCT (ProductID,ProductName,ProdTypeID, Unit, Price, Img) values('SP0011', 'Skin Body Wash ','06', 'Bottle', 289000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648697400/Shopping_onl/8e6d2f417e66b1a7ca36696566ac08f0_exqi70.jpg')

-- STORAGE
insert into STORAGE values('CN0005', 'SP0001', 500)
insert into STORAGE values('CN0005', 'SP0003', 250)
insert into STORAGE values('CN0005', 'SP0011', 80)
insert into STORAGE values('CN0004', 'SP0002', 100)
insert into STORAGE values('CN0010', 'SP0010', 320)
insert into STORAGE values('CN0011', 'SP0006', 27)
insert into STORAGE values('CN0011', 'SP0007', 1000)
insert into STORAGE values('CN0012', 'SP0006', 15)
insert into STORAGE values('CN0001', 'SP0004', 41)
insert into STORAGE values('CN0002', 'SP0004', 215)
insert into STORAGE values('CN0003', 'SP0004', 126)
insert into STORAGE values('CN0001', 'SP0005', 99)
insert into STORAGE values('CN0006', 'SP0008', 554)
insert into STORAGE values('CN0007', 'SP0008', 12)
insert into STORAGE values('CN0007', 'SP0009', 654)
insert into STORAGE values('CN0008', 'SP0008', 78)
insert into STORAGE values('CN0008', 'SP0009', 5)
insert into STORAGE values('CN0009', 'SP0009', 546)
insert into STORAGE values('CN0009', 'SP0008', 54)

-- CONTRACTS
insert into CONTRACTS values('HD0001', 'DT0001','NV0003', 262000000, 180, '13/06/2021',NULL, 4, 10.2)
insert into CONTRACTS values('HD0002', 'DT0004','NV0005', 780000000, 180, NULL, NULL, 1, 11)
insert into CONTRACTS values('HD0003', 'DT0002','NV0003', 145000000, 180, '13/02/2022',NULL, 3, 10.7)
insert into CONTRACTS values('HD0004', 'DT0005','NV0002', 560000000, 180, '11/11/2021',NULL, 3, 12)
insert into CONTRACTS values('HD0005', 'DT0003','NV0002', 1250000000, 180, '10/05/2022', NULL, 2, 10)

-- RECEIPT
insert into RECEIPT values('DH0001', 'KH0006', '10/12/2021', 15000,1,2)
insert into RECEIPT values('DH0002', 'KH0001', '01/04/2022', 15000,1,1)
insert into RECEIPT values('DH0003', 'KH0002', '04/04/2022', 15000,0,1)
insert into RECEIPT values('DH0004', 'KH0006', '05/04/2022', 15000,0,1)
insert into RECEIPT values('DH0005', 'KH0004', '19/12/2021', 15000,0,2)
insert into RECEIPT values('DH0006', 'KH0005', '22/03/2022', 15000,0,1)
insert into RECEIPT values('DH0007', 'KH0002', '30/03/2022', 15000,1,1)
insert into RECEIPT values('DH0008', 'KH0006', '28/01/2022', 15000,1,2)

-- RECEIPT_DETAIL
insert into RECEIPT_DETAIL values('DH0001', 'SP0003', 1,32000)
insert into RECEIPT_DETAIL values('DH0001', 'SP0004', 2,3000)
insert into RECEIPT_DETAIL values('DH0001', 'SP0005', 3,5000)
insert into RECEIPT_DETAIL values('DH0001', 'SP0001', 1,262000)
insert into RECEIPT_DETAIL values('DH0002', 'SP0002', 4,6850000)
insert into RECEIPT_DETAIL values('DH0002', 'SP0003', 4,32000)
insert into RECEIPT_DETAIL values('DH0002', 'SP0004', 1,3000)
insert into RECEIPT_DETAIL values('DH0003', 'SP0005', 2,5000)
insert into RECEIPT_DETAIL values('DH0003', 'SP0003', 2,32000)
insert into RECEIPT_DETAIL values('DH0004', 'SP0006', 20,23000)
insert into RECEIPT_DETAIL values('DH0004', 'SP0005', 3,5000)
insert into RECEIPT_DETAIL values('DH0005', 'SP0001', 3,262000)
insert into RECEIPT_DETAIL values('DH0006', 'SP0005', 1,5000)
insert into RECEIPT_DETAIL values('DH0007', 'SP0009', 3,40000)
insert into RECEIPT_DETAIL values('DH0007', 'SP0008', 2,19000)
insert into RECEIPT_DETAIL values('DH0008', 'SP0003', 1,32000)
insert into RECEIPT_DETAIL values('DH0008', 'SP0006', 20,23000)
insert into RECEIPT_DETAIL values('DH0008', 'SP0005', 3,5000)
insert into RECEIPT_DETAIL values('DH0008', 'SP0001', 2,262000)
insert into RECEIPT_DETAIL values('DH0008', 'SP0010', 10,471000)

-- DELIVERY_NOTE
insert into DELIVERY_NOTE values('DH0001', 'TX0003', NULL)
insert into DELIVERY_NOTE values('DH0005', 'TX0001', NULL)
insert into DELIVERY_NOTE values('DH0008', 'TX0005', NULL)

---------------------------------------------------
---------------------------------------------------
