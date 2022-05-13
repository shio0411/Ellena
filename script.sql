USE master

GO

DROP DATABASE ProduceManagement

GO

CREATE DATABASE ProduceManagement

GO

USE ProduceManagement

GO

CREATE TABLE tblUsers(
	userID		varchar(50) NOT NULL,
	fullName	nvarchar(50),
	[password]	varchar(50),
	roleID		varchar(20),
	[address]	nvarchar(100),
	birthday	date,
	phone		varchar(20),
	email		varchar(50)

 CONSTRAINT PK_tblUsers PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE tblRoles(
	roleID		varchar(20) PRIMARY KEY NOT NULL,
	roleName	nvarchar(50)
)

GO

ALTER TABLE dbo.tblUsers
ADD CONSTRAINT FK_UserRole
FOREIGN KEY (roleID) REFERENCES dbo.tblRoles(roleID);

GO

CREATE TABLE tblOrder(
	orderID			int PRIMARY KEY NOT NULL,
	orderDate		datetime,
	totalPrice		float, 
	userID			varchar(50)
)
 
GO

ALTER TABLE dbo.tblOrder
ADD CONSTRAINT FK_OrderUser
FOREIGN KEY (userID) REFERENCES dbo.tblUsers(userID);

GO	

CREATE TABLE tblProduct(
	productID		varchar(20) PRIMARY KEY NOT NULL,
	productName		nvarchar(40),
	[image]			nvarchar(MAX),
	currentPrice	float,
	categoryID		varchar(20),
	unitInStock		float,
	importDate		date,
	expiryDate		date,
	[status]        bit
)

GO

CREATE TABLE tblCategory(
	categoryID		varchar(20) PRIMARY KEY NOT NULL,
	categoryName	nvarchar(40)
)

GO

ALTER TABLE dbo.tblProduct
ADD CONSTRAINT FK_ProductCategory
FOREIGN KEY (categoryID) REFERENCES dbo.tblCategory(categoryID);

GO

CREATE TABLE tblOrderDetail(
	detailID		int PRIMARY KEY NOT NULL,
	orderID			int,
	productID		varchar(20),
	unitPrice		float,
	quantity		float
)

GO

ALTER TABLE dbo.tblOrderDetail
ADD CONSTRAINT FK_DetailOrder
FOREIGN KEY (orderID) REFERENCES dbo.tblOrder(orderID);

ALTER TABLE dbo.tblOrderDetail
ADD CONSTRAINT FK_DetailProduct
FOREIGN KEY (productID) REFERENCES dbo.tblProduct(productID);

GO

INSERT dbo.tblRoles (roleID, roleName) VALUES ('AD', 'Admin')
INSERT dbo.tblRoles (roleID, roleName) VALUES ('US', 'User')

GO

INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'admin', N'Toi la admin', N'1', N'AD', N'12 Tran Hung Dao, Phu Tho', '1999/01/01', '0123456789')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone, email) VALUES (N'Hoadnt', N'Hoa Doan', N'1', N'US', N'8 Hung Vuong, District 2, Ho Chi Minh', '1992/12/22', '0912482956', 'giamanho37@gmail.com')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'SE130363', N'Ngo Ha Tri Bao', N'1', N'AD', '8 Hung Vuong, District 2, Ho Chi Minh', '1995/07/23', '0948854956')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'SE140103', N'Phuoc Ha', N'1', N'US', N'12 Tran Hung Dao, Phu Tho', '1995/07/13', '0918854956')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'SE140119', N'Trai Nguyen', N'1', N'AD', N'12 Tran Hung Dao, Phu Tho', '1995/04/17', '0942854956')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'SE140130', N'Tam Tran', N'1', N'AD', '8 Hung Vuong, District 2, Ho Chi Minh', '2002/11/04', '0943854956')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'SE140201', N'PHAM HOANG TU', N'1', N'AD', N'355/23 Kenh Tan Hoa, Phu Thanh, Tan Phu, Ho Chi Minh', '1991/11/02', '0942472975')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'SE140969', N'Nguyen Gia Tin', N'123', N'US', N'355/23 Kenh Tan Hoa, Phu Thanh, Tan Phu, Ho Chi Minh', '1995/03/28', '0948296836')
INSERT dbo.tblUsers (UserID, fullName, [password], roleID, [address], birthday, phone) VALUES (N'SE150443', N'LE MINH KHOA', N'1', N'US', N'12 Tran Hung Dao, Phu Tho', '2002/12/14', '0918572867')	

GO

INSERT dbo.tblCategory (categoryID, categoryName) VALUES ('F', 'Fruit')
INSERT dbo.tblCategory (categoryID, categoryName) VALUES ('V', 'Vegetable')
INSERT dbo.tblCategory (categoryID, categoryName) VALUES ('D', 'Dried')
GO

INSERT dbo.tblProduct (productID, productName, [image], currentPrice, unitInStock, categoryID, importDate, expiryDate, [status]) VALUES ('01', 'Strawberry', '/ProduceManagement/images/product-2.jpg', 21, 2, 'F', '2022/03/1', '2022/03/19', 1) 
INSERT dbo.tblProduct (productID, productName, [image], currentPrice, unitInStock, categoryID, importDate, expiryDate, [status]) VALUES ('02', 'Apple', '/ProduceManagement/images/product-10.jpg', 15, 15, 'F', '2022/03/1', '2022/03/17', 1)
INSERT dbo.tblProduct (productID, productName, [image], currentPrice, unitInStock, categoryID, importDate, expiryDate, [status]) VALUES ('03', 'Bell Pepper', '/ProduceManagement/images/product-1.jpg', 20, 5, 'F', '2022/03/1', '2022/03/14', 1)
INSERT dbo.tblProduct (productID, productName, [image], currentPrice, unitInStock, categoryID, importDate, expiryDate, [status]) VALUES ('04', 'Broccoli', '/ProduceManagement/images/product-6.jpg', 30, 5, 'V', '2022/03/1', '2022/03/20', 1)
INSERT dbo.tblProduct (productID, productName, [image], currentPrice, unitInStock, categoryID, importDate, expiryDate, [status]) VALUES ('05', 'Tomato', '/ProduceManagement/images/product-5.jpg', 30, 25, 'F', '2022/03/1', '2022/03/20', 1)
INSERT dbo.tblProduct (productID, productName, [image], currentPrice, unitInStock, categoryID, importDate, expiryDate, [status]) VALUES ('06', 'Carrot', '/ProduceManagement/images/product-7.jpg', 2, 25, 'F', '2022/03/1', '2022/03/18', 1)

INSERT dbo.tblOrder (orderID, orderDate, totalPrice, userID) VALUES (1, '2022-3-6', 12, 'hoadnt')
INSERT dbo.tblOrderDetail (detailID, unitPrice, quantity, productID, orderID) VALUES (1, 15, 1, '02', 1) 
