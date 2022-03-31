CREATE DATABASE qlbh_onl ON PRIMARY
( NAME = qlbh_data, FILENAME = 'D:\CSDL\qlbh_data.mdf', SIZE = 10, MAXSIZE = 1000, FILEGROWTH = 10)
LOG ON
( NAME = qlbh_log, FILENAME = 'D:\CSDL\qlbh_log.ldf', SIZE = 10, FILEGROWTH = 5)

USE qlbh_onl
GO
DROP TABLE RECEIPT_DETAIL
DROP TABLE DELIVERY_DETAIL
DROP TABLE DELIVERY_NOTE
DROP TABLE RECEIPT
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

GO

DROP FUNCTION AUTO_RecID
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
-- ACCOUNT
CREATE TABLE ACCOUNT
(
	Email varchar(30) NOT NULL PRIMARY KEY,
	Pass varchar(30) NOT NULL,
	Roles int NOT NULL
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
	City varchar(30),
	NoID varchar(11),
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
	City varchar(30),
)

---------------------------------------------------
-- STAFF
CREATE TABLE STAFF
(
	StaffID char(6) NOT NULL PRIMARY KEY,
	StaffName varchar(30),
	Tele varchar(15),
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
	Tele varchar(15),
	Email varchar(30) NOT NULL,
	Addr varchar(50),
	District varchar(30),
	City varchar(30),
	NoBranch int,
	NoReceipt int,
	TaxCode varchar(15) 

)

---------------------------------------------------
-- CONTRACTS
CREATE TABLE CONTRACTS
(
	ContractID char(6) NOT NULL PRIMARY KEY,
	PartnerID char(6) NOT NULL,
	StaffID char(6) NOT NULL,
	Sales int NOT NULL,
	Duration int,
	StartDate date NOT NULL,
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
	StartDate date NOT NULL,
	EndDate date NOT NULL,
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
	PartnerID char(6) NOT NULL,
	ProdTypeID char(6) NOT NULL,
	NoInventory int,
	Unit varchar(30),
	Price int,
	Img image
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
	ReceiptStatus bit NOT NULL
)

---------------------------------------------------
-- RECEIPT_DETAIL
CREATE TABLE RECEIPT_DETAIL
(
	ReceiptID char(6) NOT NULL,
	ProductID char(6) NOT NULL,
	Quantity int,
	PRIMARY KEY(ReceiptID, ProductID)
)

---------------------------------------------------
-- DELIVERY_NOTE
CREATE TABLE DELIVERY_NOTE
(
	DeliveryID char(6) NOT NULL PRIMARY KEY,
	ReceiptID char(6) NOT NULL,
	ShipperID char(6) NOT NULL,
	DeliveryDate Date NOT NULL,
	DeliveryCharges int NOT NULL
)

---------------------------------------------------
-- DELIVERY_DETAIL
CREATE TABLE DELIVERY_DETAIL
(
	DeliveryID char(6) NOT NULL,
	ProductID char(6) NOT NULL,
	Quantity int,
	Price int,
	PRIMARY KEY(DeliveryID, ProductID)
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
ALTER TABLE PRODUCT ADD CONSTRAINT FK02_SP FOREIGN KEY(PartnerID) REFERENCES PARTNERS(PartnerID)

-- Foreign key for table RECEIPT
ALTER TABLE RECEIPT ADD CONSTRAINT FK_DH FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)

-- Foreign key for table RECEIPT_DETAIL
ALTER TABLE RECEIPT_DETAIL ADD CONSTRAINT FK01_CTDH FOREIGN KEY(ReceiptID) REFERENCES RECEIPT(ReceiptID)
ALTER TABLE RECEIPT_DETAIL ADD CONSTRAINT FK02_CTDH FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)

-- Foreign key for table DELIVERY_NOTE
ALTER TABLE DELIVERY_NOTE ADD CONSTRAINT FK01_PG FOREIGN KEY(ReceiptID) REFERENCES RECEIPT(ReceiptID)
ALTER TABLE DELIVERY_NOTE ADD CONSTRAINT FK02_PG FOREIGN KEY(ShipperID) REFERENCES SHIPPER(ShipperID)

-- Foreign key for table DELIVERY_DETAIL
ALTER TABLE DELIVERY_DETAIL ADD CONSTRAINT FK01_CTPG FOREIGN KEY(DeliveryID) REFERENCES DELIVERY_NOTE(DeliveryID)
ALTER TABLE DELIVERY_DETAIL ADD CONSTRAINT FK02_CTPG FOREIGN KEY(ProductID) REFERENCES PRODUCT(ProductID)

---------------------------------------------------
-- Contraint
ALTER TABLE RECEIPT ADD CONSTRAINT DF_DH DEFAULT GETDATE() FOR OrderDate
ALTER TABLE DELIVERY_NOTE ADD CONSTRAINT DF_PG DEFAULT GETDATE() FOR DeliveryDate  
---------------------------------------------------
set dateformat dmy
---------------------------------------------------
-- ACCOUNT
insert into ACCOUNT values('nva@gmail.com','123456',5)
insert into ACCOUNT values('tnhan@gmail.com','123456',5)
insert into ACCOUNT values('tmlong@gmail.com','123456',5)
insert into ACCOUNT values('pvvinh@gmail.com','123456',5)
insert into ACCOUNT values('lnminh@gmail.com','123456',5)
insert into ACCOUNT values('tnlinh@gmail.com','123456',3)
insert into ACCOUNT values('bvien@gmail.com','123456',3)
insert into ACCOUNT values('hdlap@gmail.com','123456',3)
insert into ACCOUNT values('thquang@gmail.com','123456',3)
insert into ACCOUNT values('tlnong@gmail.com','123456',3)
insert into ACCOUNT values('lntuan@gmail.com','123456',3)
insert into ACCOUNT values('nnnhut@gmail.com','123456',2)
insert into ACCOUNT values('ltpyen@gmail.com','123456',2)
insert into ACCOUNT values('nvb@gmail.com','123456',2)
insert into ACCOUNT values('nttuan@gmail.com','123456',2)
insert into ACCOUNT values('nttthanh@gmail.com','123456',2)
insert into ACCOUNT values('vtudi@gmail.com','123456',4)
insert into ACCOUNT values('vttinh@gmail.com','123456',4)
insert into ACCOUNT values('ttkhon@gmail.com','123456',4)
insert into ACCOUNT values('hmhao@gmail.com','123456',4)
insert into ACCOUNT values('ccdinh@gmail.com','123456',4)
insert into ACCOUNT values('ptthua@gmail.com','123456',1)
insert into ACCOUNT values('tquy@gmail.com','123456',1)

--ADMINS
insert into ADMINS values('AD0001','Pham Thua Thua', 'ptthua@gmail.com')
insert into ADMINS values('AD0002', 'Tieu Quy', 'tquy@gmail.com')

-- CUSTOMER
insert into CUSTOMER values('KH0001', 'Nguyen Van A','0123456789', 'nva@gmail.com', '731 Tran Hung Đao Street', 'District 5', 'HCMc')
insert into CUSTOMER values('KH0002', 'Tran Ngoc Han', '0123456789', 'tnhan@gmail.com', '23/5 Nguyen Trai Street', 'District 5', 'HCMc')
insert into CUSTOMER values('KH0004', 'Tran Minh Long', '0123456789', 'tmlong@gmail.com', '50/34 Le Đai Hanh Street', 'District 10', 'HCMc')
insert into CUSTOMER values('KH0005', 'Pham Van Vinh', '0123456789', 'pvvinh@gmail.com', '45 Trung Vuong Street', 'Sơn Tây District', 'Hanoi')
insert into CUSTOMER values('KH0006', 'Le Nhat Minh', '0123456789', 'lnminh@gmail.com', '34 Truong Dinh Street', 'District 3', 'HCMc')

-- PARTNERS
insert into PARTNERS values('DT0001', 'Thien Long', 'Tran Ngoc Linh','0123456789', 'tnlinh@gmail.com', '27 Le Van Quoi Street', 'Binh Tan District', 'HCMc', 15, 500, '3500806643')
insert into PARTNERS values('DT0002', 'Campus', 'Ha Duy Lap','0123456789', 'hdlap@gmail.com', '87 Phan Van Tri Street', 'Go Vap District', 'HCMc', 7, 173, '0102859048')
insert into PARTNERS values('DT0003', 'Lock&Lock', 'Tran Hong Quang','0123456789', 'thquang@gmail.com', '275 CMT8 Street', 'District 10', 'HCMc', 50, 300, '03202869022')
insert into PARTNERS values('DT0004', 'Vinamilk', 'Tran Lap Nong','0123456789', 'tlnong@gmail.com', '153 Xo Viet Nghe Tinh Street', 'Binh Thanh District', 'HCMc', 27, 1200, '04523869022')
insert into PARTNERS values('DT0005', 'LG Electronics', 'Lam Ngan Tuan','0123456789', 'lntuan@gmail.com', '57 Hoa Hung Street', 'District 10', 'HCMc', 10, 156, '03205678122')
insert into PARTNERS values('DT0006', 'Unilever', 'Ba Vien','0123456789', 'bvien@gmail.com', '332 Nguyen Thai Hoc Street', 'District 1', 'HCMc', 10, 156, '03212348128')

-- STAFF
insert into STAFF values('NV0001','Nguyen Nhu Nhat','927345678','nnnhut@gmail.com')
insert into STAFF values('NV0002','Le Thi Phi Yen','987567390','ltpyen@gmail.com')
insert into STAFF values('NV0003','Nguyen Van B','997047382','nvb@gmail.com')
insert into STAFF values('NV0004','Ngo Thanh Tuan','913758498','nttuan@gmail.com')
insert into STAFF values('NV0005','Nguyen Thi Truc Thanh','918590387','nttthanh@gmail.com')

-- SHIPPER
insert into SHIPPER values('TX0001', 'Vuong Tu Di','0123456789', 'vtudi@gmail.com', '45 Nguyen Canh Chan Street', 'District 1', 'HCMc', '350080664','64-V1521.87','9706410034567890')
insert into SHIPPER values('TX0003', 'Vuu Truong Tinh','0123456789', 'vttinh@gmail.com', '873 Le Hong Phong Street', 'District 5', 'HCMc', '010285904','64-V1523.69','1234567812345678')
insert into SHIPPER values('TX0004', 'Thai Tu Khon','0123456789', 'ttkhon@gmail.com', '27/53 Street 3/2', 'District 10', 'HCMc', '0320286902','36-Z1582.54','1078668165705213')
insert into SHIPPER values('TX0005', 'Hoang Minh Hao','0123456789', 'hmhao@gmail.com', '227 Nguyen Van Cu Street', 'District 5', 'HCMc', '0320286902','51-A1756.59','3564803412341234')
insert into SHIPPER values('TX0006', 'Chu Chinh Đinh','0123456789', 'ccdinh@gmail.com', '45/2 An Duong Vuong Street', 'District 5', 'HCMc', '0320286902','59-Z1316.69','4000123456789010')

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
insert into PRODUCT values('SP0001', 'OMO Auto Washing Powder 6kg','DT0006','05', 100, 'Pack', 262000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648138549/Shopping_onl/Bot-Giat-Omo-6kg_q4lden.jpg')
insert into PRODUCT values('SP0002', 'Inverter air conditioner 1HP V10ENH','DT0005','02', 20, 'Piece', 6850000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648138680/Shopping_onl/May-lanh-LG-1-HP-V10ENH-Inverter-Chinh-Hang-1_xzii6t.jpg')
insert into PRODUCT values('SP0003', 'OMO Auto Washing Powder with a Touch of Comfort Freshness 720g','DT0006','05', 500, 'Pack', 32000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648185476/Shopping_onl/8934868135029_mob01a.jpg')
insert into PRODUCT values('SP0004', 'Ballpoint pen TL-027','DT0001','01', 500, 'Piece', 3000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648185490/Shopping_onl/but_bi_thien_long_tl-027_fd2ed94624164e949898577f64580185_1_jbcy94.webp')
insert into PRODUCT values('SP0005', 'Oil brush  PM-04','DT0001','01', 200, 'Piece', 5000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648185653/Shopping_onl/but_long_dau_thien_long_pm-04_fbc72b61c6b24523aac15593f7553306_xo43a7.webp')
insert into PRODUCT values('SP0006', '100-page notebook','DT0002','01', 150, 'Pack of 10', 23000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648186004/Shopping_onl/vo-5-o-ly-2x2mm-doraemon-fly-96t-jpeg_etze4n.webp')
insert into PRODUCT values('SP0007', '200-page notebook','DT0002','01', 200, 'Piece', 4500, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648188654/Shopping_onl/tap-sinh-vien-ke-ngang-campus-great-200-trang-qh64r_123f1ef94abf41c981e50a555b249634_cxa0ok.jpg')
insert into PRODUCT values('SP0008', 'Ong Tho sweetened condensed milk 380g','DT0004','07', 15, 'Can', 19000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189010/Shopping_onl/sua-dac-co-duong-ong-tho-trang-nhan-xanh-lon-380g-201911071524564853_1_mkbxbc.jpg')
insert into PRODUCT values('SP0009', 'Vfresh 100% Fruit Juice-Apple 1L','DT0006','07', 44, 'Pack', 40000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189098/Shopping_onl/nuoc-tao-ep-vfresh-tba1l-2_0f761e1289b840df9773016a9d9a0679_master_ac5mua.webp')
insert into PRODUCT values('SP0010', 'Glass storage box LocknLock Top Class 2L - Blue','DT0003','03', 12, 'Box', 471000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648189207/Shopping_onl/JVjoEIfp6XMcc3wBSSwH_simg_de2fe0_500x500_maxb_mkvta6.jpg')
insert into PRODUCT values('SP0011', 'Sensitive Skin Body Wash','DT0006','06', 930, 'Bottle', 289000, 'https://res.cloudinary.com/dzpxhrxsq/image/upload/v1648697400/Shopping_onl/8e6d2f417e66b1a7ca36696566ac08f0_exqi70.jpg')


-- CONTRACTS
insert into CONTRACTS values('HD0001', 'DT0001','NV0003', 262000000, NULL, '13/06/2021','02/01/2022', 3, 10.2)
insert into CONTRACTS values('HD0002', 'DT0004','NV0005', 780000000, NULL, '02/01/2022','06/01/2022', 1, 11)
insert into CONTRACTS values('HD0003', 'DT0002','NV0003', 145000000, NULL, '13/02/2022','13/07/2022', 2, 10.7)
insert into CONTRACTS values('HD0004', 'DT0005','NV0002', 560000000, NULL, '11/11/2021','11/01/2022', 4, 12)
insert into CONTRACTS values('HD0005', 'DT0003','NV0002', 1250000000, NULL, '10/02/2022','10/08/2022', 1, 10)

-- RECEIPT
insert into RECEIPT values('DH0001', 'KH0006', '10/12/2021', 1)
insert into RECEIPT values('DH0002', 'KH0001', '11/08/2021', 0)
insert into RECEIPT values('DH0003', 'KH0002', '11/06/2021', 0)
insert into RECEIPT values('DH0004', 'KH0006', '23/12/2021', 0)
insert into RECEIPT values('DH0005', 'KH0004', '19/12/2021', 1)
insert into RECEIPT values('DH0006', 'KH0005', '10/11/2021', 0)
insert into RECEIPT values('DH0007', 'KH0002', '10/01/2022', 0)
insert into RECEIPT values('DH0008', 'KH0006', '28/01/2022', 1)

-- RECEIPT_DETAIL
insert into RECEIPT_DETAIL values('DH0001', 'SP0003', 1)
insert into RECEIPT_DETAIL values('DH0001', 'SP0004', 2)
insert into RECEIPT_DETAIL values('DH0001', 'SP0005', 3)
insert into RECEIPT_DETAIL values('DH0001', 'SP0001', 1)
insert into RECEIPT_DETAIL values('DH0002', 'SP0002', 4)
insert into RECEIPT_DETAIL values('DH0002', 'SP0003', 4)
insert into RECEIPT_DETAIL values('DH0002', 'SP0004', 1)
insert into RECEIPT_DETAIL values('DH0003', 'SP0005', 2)
insert into RECEIPT_DETAIL values('DH0003', 'SP0003', 2)
insert into RECEIPT_DETAIL values('DH0004', 'SP0006', 1)
insert into RECEIPT_DETAIL values('DH0004', 'SP0005', 3)
insert into RECEIPT_DETAIL values('DH0005', 'SP0001', 3)
insert into RECEIPT_DETAIL values('DH0006', 'SP0005', 1)
insert into RECEIPT_DETAIL values('DH0007', 'SP0009', 3)
insert into RECEIPT_DETAIL values('DH0007', 'SP0008', 2)
insert into RECEIPT_DETAIL values('DH0008', 'SP0003', 1)
insert into RECEIPT_DETAIL values('DH0008', 'SP0004', 7)
insert into RECEIPT_DETAIL values('DH0008', 'SP0005', 3)
insert into RECEIPT_DETAIL values('DH0008', 'SP0001', 2)
insert into RECEIPT_DETAIL values('DH0008', 'SP0010', 10)

-- DELIVERY_NOTE
insert into DELIVERY_NOTE values('PG0001', 'DH0001', 'TX0003', '17/12/2021', 15000)
insert into DELIVERY_NOTE values('PG0002', 'DH0005', 'TX0001', '01/01/2022', 20000)
insert into DELIVERY_NOTE values('PG0003', 'DH0008', 'TX0005', '03/02/2022', 20000)

-- DELIVERY_DETAIL
insert into DELIVERY_DETAIL values('PG0001', 'SP0003', 1, 32000)
insert into DELIVERY_DETAIL values('PG0001', 'SP0004', 2, 3000)
insert into DELIVERY_DETAIL values('PG0001', 'SP0005', 3, 5000)
insert into DELIVERY_DETAIL values('PG0001', 'SP0001', 1, 262000)
insert into DELIVERY_DETAIL values('PG0002', 'SP0001', 3, 262000)
insert into DELIVERY_DETAIL values('PG0003', 'SP0003', 1, 32000)
insert into DELIVERY_DETAIL values('PG0003', 'SP0004', 7, 3000)
insert into DELIVERY_DETAIL values('PG0003', 'SP0005', 3, 5000)
insert into DELIVERY_DETAIL values('PG0003', 'SP0001', 2, 262000)
insert into DELIVERY_DETAIL values('PG0003', 'SP0010', 10, 471000)
---------------------------------------------------
---------------------------------------------------





