CREATE DATABASE Ellena

GO

USE Ellena

GO

CREATE TABLE tblRoles(
	roleID   nvarchar(10) PRIMARY KEY,
	roleName nvarchar(50),
	[status] bit
)

GO

CREATE TABLE tblUsers(
	userID     char(100) PRIMARY KEY,
	fullName   nvarchar(100),
	[password] varchar(100),
	sex		   bit,
	roleID     nvarchar(10) REFERENCES tblRoles(roleID),
	[address]  nvarchar(150),
	birthday   date,
	phone      varchar(20),
	[status]   bit
)

GO

CREATE TABLE tblOrderStatus(
	statusID int PRIMARY KEY,
	statusName nvarchar(50)
)

GO

CREATE TABLE tblOrder(
	orderID   int PRIMARY KEY,
	orderDate date,
	total     int,
	userID    char(100) REFERENCES tblUsers(userID),
	statusID  int REFERENCES tblOrderStatus(statusID)
)

GO

CREATE TABLE tblCategory(
	categoryID   int identity(1,1) PRIMARY KEY,
	categoryName nvarchar(50),
	[order] int,
	[status]	 bit
)

GO

CREATE TABLE tblProduct(
	productID       		int PRIMARY KEY,
	productName		nvarchar(50),
	[description]		nvarchar(500),
	price			int,
	categoryID		int REFERENCES tblCategory(categoryID),
	[status]			bit
)

GO

CREATE TABLE tblProductDetail(
	productID int REFERENCES tblProduct(productID),
	size	varchar(50),
	color	nvarchar(50),
	[image] varchar(200),
	quantity int,
	importDate      date,
	PRIMARY KEY(productID, size, color)

)

GO

CREATE TABLE tblRating(
	productID	int REFERENCES tblProduct(productID),	
	userID 		char(100) REFERENCES tblUsers(userID),
	content	nvarchar(500),
	star		int
	PRIMARY KEY (productID, userID)
)

GO

CREATE TABLE tblOrderDetail(
	detailID  	int identity(1,1) PRIMARY KEY,
	price     	int,
	quantity  	int,
	size		varchar(50),
	color		nvarchar(50),
	orderID   	int REFERENCES tblOrder(orderID),
	productID 	int REFERENCES tblProduct(productID),
)
GO

INSERT INTO tblRoles VALUES
('AD', 'Admin', 1),
('CM', 'Customer', 1),
('MN', 'Manager', 1),
('EM', 'Employee', 1)

GO

INSERT INTO tblUsers VALUES
('ellena_admin@gmail.com', N'Phạm Trung Nguyên', '12345', 1, 'AD', 'Vinhome Nguyễn Xiển, Quận 9, TP.HCM', '1992/01/09', '0922882738', 1),
('khanhtran@gmail.com', N'Trần Thị Vân Khánh', '12345', 0, 'MN', N'30 Trần Phú, Đông Hà, Quảng Trị', '2002/12/16', '0945167243', 1),
('giaman@gmail.com', N'Hồ Gia Mẫn', '12345', 0, 'MN', N'73 Nguyễn Xiển Quận 9, TP.HCM', '2002/12/17', '0973472223', 1),
('lamduy@gmail.com', N'Lê Vũ Lâm Duy', 'duy12345', 1, 'MN', N'89/112 Đỗ Xuân Hợp Quận 9, TP.HCM', '2002/05/10', '093672627', 1),
('trungtong@gmail.com', N'Tống Đức Trung', 'trung123', 1, 'MN', N'85 Yên Đỗ Quận Bình Thạnh, TP.HCM', '2002/05/04', '093672627', 1),
('matthews121@gmail.com', 'Matthews Samuel', 'matt123', 1, 'EM', N'232 Trần Phú, Quận 2, TP.HCM', '1992/01/09', '122-334-222', 1),
('martin1221@gmail.com', 'Martin Thompson', 'martin69', 1, 'CM', N'100 Harriet Blv., Wisconsin', '1982/01/09', '233-332-575', 1),
('kobi@gmail.com', 'Lee Jung Jae', 'ljj123', 1, 'EM', N'23 Lê Lợi, Hóc Môn, TP.HCM', '1991/02/04', '090229339', 1),
('harrypotter12@gmail.com', 'Harry Potter', '123321', 1, 'CM', N'18 Hùng Vương, Quận 1, TP.HCM', '1992/11/09', '019283882', 1),
('monicaluv@gmail.com', 'Monica Risa', 'monica1609', 0, 'CM', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '2009/10/09', '687-343-787', 1),
('godrick888@gmail.com', 'Godrick Min', 'thelord', 1,'CM', N'991 La Thành, Quận Ba Đình, Hà Nội', '1988/12/10', '0822947382', 1),
('maitran21@gmail.com', 'Mai Tran', 'mai123', 0, 'CM', N'90 Lê Văn Việt Quận 9, TP.HCM', '2005/12/10', '0947436728', 1),
('haunguyen@gmail.com', N'Nguyễn Văn Hậu', 'haunguyen', 1, 'CM', N'12 Huỳnh Thúc Kháng Quận 1, TP.HCM', '2003/05/10', '0938338835', 1),
('hanguyenanh@gmail.com', 'Nguyen Anh Ha', 'ha1999', 0, 'CM', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '2003/05/10', '0938338835', 1)


---tblUsers(userID, fullName, [password], sex, roleID, [address], birthday, phone, [status])---

GO

INSERT INTO tblOrderStatus VALUES
(1, 'Chưa xác nhận'),
(2, 'Đã xác nhận'),
(3, 'Đang giao'),
(4, 'Đã giao'),
(5, 'Đã hủy')
--tblOrderStatus(statusID,statusName)-------

GO

GO
INSERT INTO tblOrder VALUES 
(190, '2022/05/02', 100000, 'harrypotter12@gmail.com', 3),
(191, '2022/05/03', 1230000, 'monicaluv@gmail.com', 2),
(192, '2022/05/03', 120000, 'kobi@gmail.com', 3),
(193, '2022/05/03', 350000, 'monicaluv@gmail.com', 4),
(194, '2022/05/03', 540000, 'martin1221@gmail.com', 4),
(195, '2022/05/03', 130000, 'maitran21@gmail.com', 2),
(196, '2022/05/03', 560000, 'haunguyen@gmail.com', 2),
(197, '2022/05/04', 430000, 'godrick888@gmail.com', 3),
(198, '2022/05/04', 290000, 'maitran21@gmail.com', 1),
(199, '2022/05/04', 210000, 'godrick888@gmail.com', 1),
(200, '2022/05/04', 310000, 'hanguyenanh@gmail.com', 1)


----tblOrder(orderID, orderDate, total, userID, statusID)---------

GO

INSERT INTO tblCategory
VALUES
(N'Áo khoác', 1, 1),
(N'Váy đầm mẹ và bé', 2, 1),
(N'Quần short', 3, 1),
(N'Áo sơ mi', 4, 1),
(N'Quần dài', 5, 1),
(N'Áo thun', 6, 1),
(N'Váy oversize', 7, 1),
(N'Váy đầm dự tiệc', 8, 1),
(N'Váy công sở', 9, 1),
(N'Chân váy', 10, 1);
---tblCategory(categoryID, categoryName, order, [status])--------

GO

INSERT INTO tblProduct
VALUES 
(120, N'ÁO THUN TAY NGẮN CỔ V.', N'Form dáng basic, hiện đại dễ kết hợp với các item khác nhau hòa nhịp với xu hướng thời trang Hàn Quốc.',  216000, 6, 1),
(121, N'QUẦN JEANS SKINNY', N'Chiếc quần được thiết kế ôm vừa vặn, phom quần lửng, dáng quần được nghiên cứu hiện đại, thoải mái từ phần hông cho tới phần cẳng chân, giúp tôn đôi chân thon dài của khách hàng.', 424000, 5, 1),
(122, N'ĐẦM TAY NGẮN KHOÉT TH N SAU', N'Là chiếc đầm bằng vải voan nhẹ nhàng, tay áo lựng có độ phồng nhẹ. Thiết kế trang trí nơ trước ngực, tăng thêm nét dịu dàng cho bạn nữ. Là một chiếc đầm phù hợp cho bạn diện ở nhiều trường hợp khác nhau như đi làm, đi chơi, dạo phố,…', 389000, 2, 1),
(123, N'ÁO KIỂU TAY DÀI NHÚN THUN VAI ', N'Chiếc áo kiểu này là một nét đẹp nữ tính cho các bạn nữ  yêu thích sự nhẹ nhàng. Với chất vải mềm mại kết hợp cùng thiết kế tay áo rộng.', 299000, 5, 1),
(124, N'ÁO KHOÁC DENIM NỮ CORDUROY TÚI ĐẮP.', N'Áo khoác denim cổ ve lật, dài tay, cổ tay bo và cài khuy. Có hai túi có nắp trước ngực và túi may viền hai bên hông. Vải hiệu ứng bạc màu. Cài khuy phía trước.', 460000, 1, 1),
(125, N'QUẦN KAKI CARROT', N'',  320000, 5, 1),
(126, N'ÁO DỆT KIM TAY NGẮN', N'', 495000, 6, 1),
(127, N'QUẦN SHORT TÚI XÉO 2 NÚT', N'', 520000, 7, 1),
(128, N'ĐẦM CARO RÚT NGỰC', N'', 520000, 8, 1),
(129, N'ÁO IN CHỮ LOANG ', N'', 185000, 6, 1),
(130, N'ÁO KHOÁC JEANS CƠ BẢN', N'', 595000, 9, 1),
(131, N'ĐẦM SUÔNG BUỘC EO', N'', 495000, 2, 1),
(132, N'ĐẦM SUÔNG BUỘC EO', N'', 495000, 2, 1),
(133, N'CH N VÁY RÚT D Y', N'', 285000, 7, 1),
(134, N'VÁY RÚT D Y', N'', 285000, 7, 1);

---tblProduct (productID, productName, [description], price, categoryID, [status] )---

GO

INSERT INTO tblProductDetail
VALUES 
(120, 'S', N'Trắng', '', 230, '2022/02/01'),
(120, 'M', N'Trắng', '', 187, '2022/02/04'),
(120, 'L', N'Trắng', '', 150, '2022/02/04'),
(120, 'S', N'Đen', '', 210, '2022/02/04'),
(120, 'M', N'Đen', '', 157, '2022/02/05'),
(120, 'L', N'Đen', '', 142, '2022/02/05'),
(120, 'S', N'Be', '', 112, '2022/02/07'),
(120, 'M', N'Be', '', 133, '2022/02/08'),
(120, 'L', N'Be', '', 190, '2022/02/10'),
(120, 'M', N'Nâu', '', 133, '2022/02/10'),
(120, 'L', N'Nâu', '', 190, '2022/02/11'),
(120, 'S', N'Nâu', '', 190, '2022/02/11'),
(121, '26', N'Xanh Blue', '', 133, '2022/02/08'),
(121, '27', N'Xanh Blue', '', 190, '2022/02/10'),
(121, '28', N'Xanh Blue', '', 133, '2022/02/10'),
(121, '29', N'Xanh Blue', '', 140, '2022/02/11'),
(121, '30', N'Xanh Blue', '', 130, '2022/02/11'),
(122, 'XS', N'Xanh nhạt', '', 138, '2022/02/12'),
(122, 'S', N'Xanh nhạt', '', 144, '2022/02/13'),
(122, 'M', N'Xanh nhạt', '', 240, '2022/02/13'),
(123, 'XS', N'Be', '', 138, '2022/03/15'),
(123, 'S', N'Be', '', 144, '2022/03/15'),
(123, 'M', N'Be', '', 240, '2022/03/15'),
(123, 'L', N'Be', '', 240, '2022/03/15'),
(124, 'S', N'Xanh Olive', '', 131, '2022/03/15'),
(124, 'M', N'Xanh Olive', '', 50, '2022/03/15'),
(124, 'L', N'Xanh Olive', '', 77, '2022/03/15'),
(125, 'S', N'Đen', '', 240, '2022/03/14'),
(125, 'M', N'Đen', '', 131, '2022/03/14'),
(125, 'S', N'Be', '', 50, '2022/03/15'),
(125, 'M', N'Be', '', 77, '2022/03/16'),
(126, 'S', N'Nâu', '', 77, '2022/03/16'),
(126, 'M', N'Nâu', '', 127, '2022/03/16'),
(126, 'L', N'Nâu', '', 90, '2022/03/16'),
(127, 'S', N'Be', '', 240, '2022/03/14'),
(127, 'M', N'Be', '', 123, '2022/03/14'),
(127, 'L', N'Be', '', 56, '2022/03/14'),
(128, 'M', N'Đen', '', 56, '2022/03/14'),
(129, 'M', N'Xanh', '', 56, '2022/03/14'),
(130, 'M', N'Đen', '', 56, '2022/03/14'),
(131, 'M', N'Be', '', 56, '2022/03/14'),
(132, 'M', N'Vàng', '', 56, '2022/03/14'),
(133, 'M', N'Xám', '', 56, '2022/03/14'),
(134, 'M', N'Be', '', 56, '2022/03/14')



---tblProductDetail (productID, size, color, [image], quantity, importDate) ----

GO

INSERT INTO tblOrderDetail
VALUES
(216000, 2, 'S', N'Trắng', 190, 120),
(216000, 1, 'M', N'Be', 190, 120),
(185000, 1, 'S', N'Xanh nhạt', 190, 122),
(185000, 1, 'M', N'Xanh nhạt', 190, 122),
(185000, 1, 'M', N'Be', 190, 134),
(185000, 1, 'M', N'Xanh nhạt', 191, 122),
(299000, 2, 'XS', N'Be', 191, 123),
(79000, 1, 'S', N'Đen', 192, 125),
(79000, 2, 'M', N'Đen', 192, 128),
(185000, 1, 'M', N'Xanh nhạt', 192, 122),
(185000, 2, 'S', N'Xanh nhạt', 193, 122),
(595000, 2,  'M', N'Đen', 193, 130),
(495000, 1,  'M', N'Be', 194, 131),
(520000, 1,  'L', N'Be', 194, 127),
(216000, 1, 'L', N'Đen', 195, 120),
(185000, 3, 'XS', N'Xanh nhạt', 195, 122),
(424000, 3, '28', N'Xanh Blue', 196, 121),
(179000, 1, 'L', N'Be', 197, 123),
(199900, 1, 'L', N'Nâu', 197, 126),
(139900, 1, 'M', N'Đen', 198, 125),
(355000, 2, 'M', N'Be', 199, 127),
(274000, 1, 'L', N'Be', 200, 123),
(228000, 1,  'S', N'Be', 200, 123)
---tblOrderDetail(detailID la tu tang, price, quantity, size, color, orderID, productID)----

GO

CREATE FUNCTION [dbo].[fuChuyenCoDauThanhKhongDau]
(
      @strInput NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN    
    IF @strInput IS NULL RETURN @strInput
    IF @strInput = '' RETURN @strInput
    DECLARE @RT NVARCHAR(4000)
    DECLARE @SIGN_CHARS NCHAR(136)
    DECLARE @UNSIGN_CHARS NCHAR (136)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế
                 ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý
                 Ă ĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ
                 ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ'
                  +NCHAR(272)+ NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee
                 iiiiiooooooooooooooouuuuuuuuuuyyyyy
                 AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII
                 OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER INT
    DECLARE @COUNTER1 INT
    SET @COUNTER = 1
 
    WHILE (@COUNTER <=LEN(@strInput))
    BEGIN  
      SET @COUNTER1 = 1
      --Tìm trong chuỗi mẫu
       WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
       BEGIN
     IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1))
            = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
     BEGIN          
          IF @COUNTER=1
              SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)                  
          ELSE
              SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1)
              +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
              BREAK
               END
             SET @COUNTER1 = @COUNTER1 +1
       END
      --Tìm tiếp
       SET @COUNTER = @COUNTER +1
    END
    RETURN @strInput
END

GO 

CREATE FUNCTION [dbo].[fuChuyenCoDauThanhKhongDauThemGach]
(
      @strInput NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN    
    IF @strInput IS NULL RETURN @strInput
    IF @strInput = '' RETURN @strInput
    DECLARE @RT NVARCHAR(4000)
    DECLARE @SIGN_CHARS NCHAR(136)
    DECLARE @UNSIGN_CHARS NCHAR (136)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế
                 ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý
                 Ă ĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ
                 ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ'
                  +NCHAR(272)+ NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee
                 iiiiiooooooooooooooouuuuuuuuuuyyyyy
                 AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII
                 OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER INT
    DECLARE @COUNTER1 INT
    SET @COUNTER = 1
 
    WHILE (@COUNTER <=LEN(@strInput))
    BEGIN  
      SET @COUNTER1 = 1
      --Tìm trong chuỗi mẫu
       WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
       BEGIN
     IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1))
            = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
     BEGIN          
          IF @COUNTER=1
              SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)                  
          ELSE
              SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1)
              +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
              BREAK
               END
             SET @COUNTER1 = @COUNTER1 +1
       END
      --Tìm tiếp
       SET @COUNTER = @COUNTER +1
    END
	SET @strInput = REPLACE(@strInput, ' ', '-')
    RETURN @strInput
END


--------------------------------------------------------------------------

with subTable as(
	SELECT A.productID, productName, image, description, size, color, price, quantity, categoryID, importDate, status, ROW_NUMBER() over(ORDER BY A.productID ASC) as row# 
	FROM tblProduct A inner join tblProductDetail B on (A.productID = B.productID)
	) 
		select productID, productName, image, description, size, color, price, quantity, categoryID, importDate, status, row# 
		from subTable 
		where row# between 0 and 10

---------Order by none ( ROW_NUMBER() over(ORDER BY (SELECT NULL)) as row# )

with subTable as(
	SELECT productID, productName, categoryID, status, ROW_NUMBER() over(ORDER BY productID ASC) as row# 
	FROM tblProduct
	) 
		select productID, productName, categoryID, status, row# 
		from subTable 
		where row# between 0 and 10

select Top 1 COUNT (*) OVER () AS ROW_COUNT from tblProduct



WITH subTable AS(SELECT productID, productName, categoryID, status, ROW_NUMBER() OVER(ORDER BY productID ASC) as row# FROM tblProduct) SELECT productID, productName, categoryID, status, row# FROM subTable WHERE row# between 0 and 10



WITH subTable AS(
				SELECT productID, productName, categoryID, status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL) ASC) as row# 
				FROM tblProduct
				WHERE productName LIKE '%a%' AND status=1
				)
		SELECT productID, productName, categoryID, status, row# 
		FROM subTable 
		WHERE row# BETWEEN 1 AND 5


SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct WHERE productName LIKE '%v%' AND status=1