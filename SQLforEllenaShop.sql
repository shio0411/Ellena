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
-----tblOrderStatus(statusID, statusName)---------
GO

CREATE TABLE tblOrder(
	orderID   int identity(1,1) PRIMARY KEY,
	orderDate date,
	total     int,
	userID    char(100) REFERENCES tblUsers(userID),
	trackingID varchar(40)
)
------tblOrder(orderID{identity}, orderDate, total, userID, trackingID)-------
GO


CREATE TABLE tblOrderStatusUpdate(
	ID int identity(1,1) PRIMARY KEY,
	statusID int REFERENCES tblOrderStatus(statusID),
	orderID int REFERENCES tblOrder(orderID),
	updateDate smalldatetime
)
----tblOrderStatusUpdate(ID{identity}, statusID, orderID, updateDate)----

CREATE TABLE tblCategory(
	categoryID   int identity(1,1) PRIMARY KEY,
	categoryName nvarchar(50),
	[order] int,
	[status]	 bit
)

GO

CREATE TABLE tblProduct(
	productID       		int identity(1,1) PRIMARY KEY,
	productName		nvarchar(50),
	[description]		nvarchar(500),
	price			int,
	categoryID		int REFERENCES tblCategory(categoryID),
	discount		float,
	lowStockLimit 		int, 
	[status]			bit
)
----tblProduct(productID{identity}, productName, [description], price, categoryID, discount, lowStockLimit, [status])--------

GO

CREATE TABLE tblProductColors(
	productColorID int identity(1,1) PRIMARY KEY,
	productID int REFERENCES tblProduct(productID),
color nvarchar(50)
)
--tblProductColors(productColorID  [identity] , productID , color )----
GO

CREATE TABLE tblColorImage(
	colorImageID int identity(1,1) PRIMARY KEY,
	productColorID int REFERENCES tblProductColors(productColorID),
	[image] nvarchar(250)
)
	--tblColorImage(colorImageID   [identity] , productColorID , [image])----

CREATE TABLE tblColorSizes(
	colorSizeID int identity(1,1) PRIMARY KEY,
	productColorID int REFERENCES tblProductColors(productColorID),
	size	varchar(50),
	quantity int,
)

--tblColorSizes(colorSizeID , productColorID, size, quantity)----
GO

CREATE TABLE tblRating(
	id	int identity(1,1) PRIMARY KEY,
	productID	int REFERENCES tblProduct(productID),	
	userID 		char(100) REFERENCES tblUsers(userID),
	content	nvarchar(500),
	star		int,
	rateDate	date
)
---tblRating(id [identity], productID, userID, content, star, rateDate)----

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
---tblOrderDetail(detailID la tu tang, price, quantity, size, color, orderID, productID)----

INSERT INTO tblRoles VALUES
('AD', 'Admin', 1),
('CM', 'Customer', 1),
('MN', 'Manager', 1),
('EM', 'Employee', 1)

GO

INSERT INTO tblUsers VALUES
('ellena_admin@gmail.com', N'Phạm Trung Nguyên', '12345', 1, 'AD', N'Vinhome Nguyễn Xiển, Quận 9, TP.HCM', '1992/01/09', '0922882738', 1),
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
(1, N'Chưa xác nhận'),
(2, N'Đã xác nhận'),
(3, N'Đang giao'),
(4, N'Đã giao'),
(5, N'Đã hủy')
--tblOrderStatus(statusID,statusName)-------

GO

GO
INSERT INTO tblOrder VALUES 
('2022/05/02', 100000, 'harrypotter12@gmail.com', 'SSLVN4454497778797641810'),
('2022/05/04', 1230000, 'monicaluv@gmail.com', 'SSLVN37480191943152553458'),
('2022/05/05', 120000, 'kobi@gmail.com', 'SSLVN36160885032451795902'),
('2022/05/06', 350000, 'monicaluv@gmail.com', 'SSLVN80743025514474155713'),
('2022/05/07', 540000, 'martin1221@gmail.com', 'SSLVN11371807270314380917'),
('2022/05/23', 130000, 'maitran21@gmail.com', 'SSLVN21085947711528507560'),
('2022/05/23', 560000, 'haunguyen@gmail.com', 'SSLVN11187708803131808013'),
('2022/05/21', 430000, 'godrick888@gmail.com', 'SSLVN54103113879066105821'),
('2022/05/20', 290000, 'maitran21@gmail.com', 'SSLVN11341725634716085101'),
('2022/05/22', 210000, 'godrick888@gmail.com', 'SSLVN37490191625152553458'),
('2022/05/04', 310000, 'hanguyenanh@gmail.com', 'SSLVN76091081515898125245'),
('2022/05/06', 130000, 'maitran21@gmail.com', 'SSLVN76091081721838125245'),
('2022/05/07', 560000, 'haunguyen@gmail.com', 'SSLVN87237126686276585086'),
('2022/05/10', 430000, 'godrick888@gmail.com', 'SSLVN81526126686276585086'),
('2022/05/12', 290000, 'maitran21@gmail.com', 'SSLVN61405555828311583407'),
('2022/05/15', 210000, 'godrick888@gmail.com', 'SSLVN32401242828311583407'),
('2022/05/17', 310000, 'hanguyenanh@gmail.com', 'SSLVN38070795908852759427'),
('2022/05/12', 130000, 'maitran21@gmail.com', 'SSLVN97480191943152553458'),
('2022/05/20', 560000, 'haunguyen@gmail.com', 'SSLVN66561052929520581017'),
('2022/05/21', 430000, 'godrick888@gmail.com', 'SSLVN51811923132770990465'),
('2022/05/07', 290000, 'maitran21@gmail.com', 'SSLVN55011923132770990465'),
('2022/05/08', 210000, 'godrick888@gmail.com', 'SSLVN27991671134443514734'),
('2022/05/09', 310000, 'hanguyenanh@gmail.com', 'SSLVN21426471134443514734'),
('2022/01/02', 100000, 'harrypotter12@gmail.com', 'SSLVN4454497778791641810'),
('2022/02/03', 1230000, 'monicaluv@gmail.com', 'SSLVN37480191943152653458'),
('2022/03/03', 120000, 'kobi@gmail.com', 'SSLVN36160885032451795952'),
('2022/01/03', 350000, 'monicaluv@gmail.com', 'SSLVN80743025514477155713'),
('2022/02/03', 540000, 'martin1221@gmail.com', 'SSLVN11371807270384380917'),
('2022/03/23', 130000, 'maitran21@gmail.com', 'SSLVN21085947711520507560'),
('2022/04/23', 560000, 'haunguyen@gmail.com', 'SSLVN11187708803141808013'),
('2022/01/21', 430000, 'godrick888@gmail.com', 'SSLVN54103113879076105821'),
('2022/02/20', 290000, 'maitran21@gmail.com', 'SSLVN11341725634719085101'),
('2022/03/22', 210000, 'godrick888@gmail.com', 'SSLVN3749019162512553458'),
('2022/05/04', 310000, 'hanguyenanh@gmail.com', 'SSLVN76091081545898125245'),
('2022/01/06', 130000, 'maitran21@gmail.com', 'SSLVN76091081721838125245'),
('2022/02/07', 560000, 'haunguyen@gmail.com', 'SSLVN87237126686476585086'),
('2022/03/10', 430000, 'godrick888@gmail.com', 'SSLVN81526126686576585086'),
('2022/04/12', 290000, 'maitran21@gmail.com', 'SSLVN61405555828361583407'),
('2022/05/15', 210000, 'godrick888@gmail.com', 'SSLVN32401242828711583407'),
('2022/01/17', 310000, 'hanguyenanh@gmail.com', 'SSLVN38070795988852759427'),
('2022/01/12', 130000, 'maitran21@gmail.com', 'SSLVN97480191943192553458'),
('2022/02/20', 560000, 'haunguyen@gmail.com', 'SSLVN66561052929020581017'),
('2022/03/21', 430000, 'godrick888@gmail.com', 'SSLVN51811923139770990465'),
('2022/04/07', 290000, 'maitran21@gmail.com', 'SSLVN55011923132070990465'),
('2022/05/08', 210000, 'godrick888@gmail.com', 'SSLVN27991671133443514734'),
('2022/03/09', 310000, 'hanguyenanh@gmail.com', 'SSLVN21426471133443514734'),
('2021/06/02', 100000, 'harrypotter12@gmail.com', 'SSLVN4454437778791641810'),
('2021/07/03', 1230000, 'monicaluv@gmail.com', 'SSLVN37480196943152653458'),
('2021/08/03', 120000, 'kobi@gmail.com', 'SSLVN36160885032458795952'),
('2021/09/03', 350000, 'monicaluv@gmail.com', 'SSLVN80743025114477155713'),
('2021/07/03', 540000, 'martin1221@gmail.com', 'SSLVN11371805270384380917'),
('2021/07/23', 130000, 'maitran21@gmail.com', 'SSLVN21085947811520507560'),
('2021/08/23', 560000, 'haunguyen@gmail.com', 'SSLVN11187404803141808013'),
('2021/09/21', 430000, 'godrick888@gmail.com', 'SSLVN54103516879076105821'),
('2021/01/20', 290000, 'maitran21@gmail.com', 'SSLVN11341765614719085101'),
('2021/05/22', 210000, 'godrick888@gmail.com', 'SSLVN3749018112512553458'),
('2021/07/04', 310000, 'hanguyenanh@gmail.com', 'SSLVN76061081545898125245'),
('2021/11/06', 130000, 'maitran21@gmail.com', 'SSLVN76091081721838125245'),
('2021/10/07', 560000, 'haunguyen@gmail.com', 'SSLVN87237156686476585086'),
('2021/12/10', 430000, 'godrick888@gmail.com', 'SSLVN81526166686576585086'),
('2021/10/12', 290000, 'maitran21@gmail.com', 'SSLVN61405554828361583407'),
('2021/11/15', 210000, 'godrick888@gmail.com', 'SSLVN3240112828711583407'),
('2021/12/17', 310000, 'hanguyenanh@gmail.com', 'SSLVN38070795988852759427'),
('2021/12/12', 130000, 'maitran21@gmail.com', 'SSLVN97480191943192553458'),
('2021/11/20', 560000, 'haunguyen@gmail.com', 'SSLVN66561752929020581017'),
('2021/12/21', 430000, 'godrick888@gmail.com', 'SSLVN51811123139770990465'),
('2021/11/07', 290000, 'maitran21@gmail.com', 'SSLVN55011953132070990465'),
('2021/10/08', 210000, 'godrick888@gmail.com', 'SSLVN27991871133443514734'),
('2021/09/09', 310000, 'hanguyenanh@gmail.com', 'SSLVN21426471133443514734')



------tblOrder(orderID{identity}, orderDate, total, userID, trackingID)------- NEW*

GO

INSERT INTO tblCategory
VALUES
(N'Áo khoác', 1, 1),
(N'Quần short', 2, 1),
(N'Áo sơ mi', 3, 1),
(N'Quần dài', 4, 1),
(N'Áo thun', 5, 1),
(N'Váy đầm', 6, 1),
(N'Áo vest', 7, 1),
(N'Chân váy', 8, 1)
---tblCategory(categoryID, categoryName, order, [status])--------

GO

INSERT INTO tblProduct
VALUES 
(N'ÁO THUN TAY NGẮN CỔ V', N'Form dáng basic, hiện đại dễ kết hợp với các item khác nhau hòa nhịp với xu hướng thời trang Hàn Quốc.',  216000, 5, 0.6, 10, 1),
(N'QUẦN JEANS SKINNY', N'Chiếc quần được thiết kế ôm vừa vặn, phom quần lửng, dáng quần được nghiên cứu hiện đại, thoải mái từ phần hông cho tới phần cẳng chân, giúp tôn đôi chân thon dài của khách hàng.', 424000, 2, 0.3, 10, 1),
(N'ĐẦM TAY NGẮN KHOÉT EO', N'Là chiếc đầm bằng vải voan nhẹ nhàng, tay áo lựng có độ phồng nhẹ. Thiết kế trang trí nơ trước ngực, tăng thêm nét dịu dàng cho bạn nữ. Là một chiếc đầm phù hợp cho bạn diện ở nhiều trường hợp khác nhau như đi làm, đi chơi, dạo phố,…', 389000, 6, 0, 10, 1),
(N'ÁO KIỂU TAY DÀI NHÚN THUN VAI', N'Chiếc áo kiểu này là một nét đẹp nữ tính cho các bạn nữ  yêu thích sự nhẹ nhàng. Với chất vải mềm mại kết hợp cùng thiết kế tay áo rộng.', 299000, 3, 0.3, 10, 1),
(N'ÁO KHOÁC DENIM NỮ CORDUROY TÚI ĐẮP.', N'Áo khoác denim cổ ve lật, dài tay, cổ tay bo và cài khuy. Có hai túi có nắp trước ngực và túi may viền hai bên hông. Vải hiệu ứng bạc màu. Cài khuy phía trước.', 460000, 1, 0.2, 10, 1),
(N'QUẦN KAKI CARROT', N'Form quần carrot vừa xuất hiện đã thu hút giới trẻ bởi phong cách năng động và hiện đại, dễ dàng mix-match và làm mới phong cách của riêng bạn.',  320000, 2, 0.5, 10,1),
(N'ÁO DỆT KIM TAY NGẮN', N'Chất liệu dệt kim đem lại form cảm giác thoải mái khi mặc. Kích thước phù hợp cho các bạn nữ <55kg, form xuông mặc rất cá tính, thoải mái và dễ phối đồ. Sản phẩm có thể phối với chân váy hoặc quần cạp cao sẽ trở thành nột set đồ lí tưởng cho chị em.', 495000, 3, 0.25, 10,1),
(N'QUẦN SHORT TÚI XÉO 2 NÚT', N'Quần được thiết kế với hình dáng khỏe khoắn, mang lại cho các bạn nữ một ngoại hình sảng khoái và phá cách.', 520000, 2, 0.15, 10,1),
(N'ĐẦM CARO RÚT NGỰC', N'Đầm caro rút ngực tay phồng với tay phồng nhún nhẹ nhàng. Điểm nhấn phá cách bằng dây rút tạo nhún ngay ngực, sexy mà vẫn không hở hang.', 520000, 6, 0, 10,1),
(N'ÁO IN CHỮ LOANG ', N'Sắc màu cực tươi và sáng, họa tiết in hình sau lưng đang xu hướng. Kiểu dáng form rộng năng động cá tính. Dáng áo cực dễ phối đồ, quần short hay quần jean đều hợp. Chất liệu vải mềm mịn.', 185000, 5, 0.25, 10,1),
(N'ÁO KHOÁC JEANS CƠ BẢN', N'Áo khoác jeans form cơ bản, có nút ở giữa, áo wash rách ở ngực bên trái, tạo kiểu, áo rã đô, có 2 túi 2 bên ngực, có túi mổ bên hông, áo wash rách thân sau tạo kiểu.', 595000, 1, 0.2, 10, 1),
(N'ĐẦM SUÔNG BUỘC EO', N'Đầm form suông, bâu danton, tay ngắn, xếp ly nhún ở cửa tay, viền cửa tay khoảng 1cm, thân sau có xẻ tà, đần kèm dây thắt đai eo, không dây kéo.', 495000, 2, 0.3, 10, 1),
(N'ĐẦM SƠ MI PHỐI BÈO', N'Đầm form A nhẹ, cổ tròn, không tay, phối bèo tạo kiểu, giữa đầm có nút giả, dây kéo phía sau, cổ sau có khuy nút tháo mở được.', 285000, 2, 0.1, 10,1),
(N'VÁY RÚT D Y', N'Chiếc váy mang đậm phong cách nữ tính, dễ thương và duyên dáng, được rất nhiều chị em yêu thích bởi sự đơn giản và tạo sự thoải mái khi diện bộ trang phục này. Với tạng người dù cao, thấp hay ốm đều có thể tự tin khi diện.', 285000, 8, 0.2, 10, 1),
(N'ÁO KHOÁC JEANS PHỐI TÚI', N'Áo khoác jeans form croptop, có nút ở giữa, tay dài phối măng sết, bản măng sết khoảng 4cm có nút cài, áo rã đô, rã cách điệu tạo kiểu, ở trước 2 bên ngực có túi hộp, phần lai áo tua rua tạo kiểu.', 312000, 1, 0.14, 10, 1),
(N'ÁO VEST BLAZER', N'Áo vest blazer, tay dài, cửa tay có xẻ khoảng 11cm, có 3 nút trang trí, phía trước có mổ túi giả, phía sau có xẻ khoảng 18cm.', 665000, 7, 1, 10, 1),
(N'VÁY BÚT CHÌ TÚI ĐẮP', N'Chân váy bút chì, lưng liền, phía trước có 2 túi đắp, trên túi có nút nhựa, đây kéo phía sau, xẻ tà đắp khoảng 21cm', 265000, 8, 0.08, 5, 1),
(N'ÁO CỔ TIM SỌC NGANG', N'Áo thun form ôm, cổ tim, tay ngắn, siêu đáng yêu.', 145000, 5, 0.15, 5, 1),
(N'ÁO SƠ MI GIẤU NÚT', N'Áo sơ mi form cơ bản, tay dài, bản măng sết khoảng 3.5cm, phần nẹp áo là nẹp che giấu nút, thân sau có xếp ly', 300000, 3, 0.05, 10, 1),
(N'ÁO THẮT NƠ TAY PHỒNG', N'Áo sơ mi chui đầu, cổ tim, cổ có dây nơ tạo kiểu, tay dài, có măng sết khoảng 6cm, có 2 nút nhựa cài.', 300000, 3, 0, 10, 1)



----tblProduct(productID{identity}, productName, [description], price, categoryID, discount, lowStockLimit, [status])--------

GO

INSERT INTO tblProductColors
VALUES 
(1, N'Trắng'),
(1, N'Đen'),
(2, N'Trắng'),
(2, N'Nâu'),
(3, N'Nâu'),
(3, N'Xanh nhạt'),
(4, N'Đỏ'),
(4, N'Nâu'),
(5, N'Xanh rêu'),
(6,  N'Kem'),
(6, N'Bò'),
(7, N'Đen'),
(7, N'Be'),
(8, N'Nâu'),
(9, N'Be'),
(10, N'Đen'),
(10, N'Xanh'),
(11, N'Be'),
(11, N'Vàng'),
(11, N'Xám'),
(12, N'Be'),
(13, N'Trắng'),
(14, N'Đen'),
(15, N'Xanh'),
(15, N'Xanh nhạt'),
(16, N'Đen'),
(17, N'Đen'),
(18, N'Be'),
(18, N'Hồng'),
(19, N'Trắng'),
(20, N'Hồng'),
(20, N'Xanh')

--tblProductColors(productColorID [identity] , productID, color, [image])---- NEW*

GO

INSERT INTO tblColorImage
VALUES
(1, './images/ao-thun-tay-ngan-co-v-trang'),
(1,  './images/ao-thun-tay-ngan-co-v-trang-1'),
(2, './images/ao-thun-tay-ngan-co-v-den'),
(3, './images/quan-jeans-skinny-trang'),
(4, './images/quan-jeans-skinny-nau'),
(5, './images/dam-tay-ngan-khoet-eo-nau'),
(6, './images/dam-tay-ngan-khoet-eo-xanh-nhat'),
(7, './images/ao-kieu-tay-dai-nhun-thun-vai-do'),
(8, './images/ao-kieu-tay-dai-nhun-thun-vai-nau'),
(9, './images/ao-khoac-denim-nu-corduroy-tui-dap-xanh-reu'),
(10, './images/quan-kaki-carrot-kem'),
(11, './images/quan-kaki-carrot-bo'),
(12, './images/ao-det-kim-tay-ngan-den'),
(13, './images/ao-det-kim-tay-ngan-be'),
(14, './images/quan-shorts-tui-xeo-2-nut-nau'),
(15, './images/dam-caro-rut-nguc-be'),
(16, './images/ao-in-chu-loang-den'),
(17, './images/ao-in-chu-loang-xanh'),
(18, './images/ao-khoac-jeans-co-ban-be'),
(19, './images/ao-khoac-jeans-co-ban-vang'),
(20, './images/ao-khoac-jeans-co-ban-xam'),
(21, './images/dam-suong-buoc-eo-be'),
(22, './images/dam-so-mi-phoi-beo-trang'),
(23, './images/cay-rut-day-den'),
(24, './images/ao-khoac-jeans-phoi-tui-xanh'),
(25, './images/ao-khoac-jeans-phoi-tui-xanh-nhat'),
(26, './images/ao-vest-blazer-den'),
(27, './images/vay-but-chi-tui-dap-den'),
(28, './images/ap-co-tim-soc-ngang-be'),
(29, './images/ap-co-tim-soc-ngang-hong'),
(30, './images/ao-so-mi-giau-nut-trang'),
(31, './images/ao-that-no-tay-phong-hong'),
(32, './images/ao-that-no-tay-phong-xanh')



GO
--tblColorImage(colorImageID   [identity] , productColorID , [image])----


INSERT INTO tblColorSizes(productColorID, size, quantity) VALUES
(1, 'XS', 30),
(1, 'S', 32),
(2, 'XS', 230),
(2, 'S', 30),
(3, '27', 22),
(3, '28', 154),
(4, '27', 123),
(4, '28', 23),
(5,  'M', 56),
(5, 'L', 70),
(6,  'M', 56),
(6, 'L', 74),
(7, 'M', 93),
(7, 'L', 10),
(8, 'S', 13),
(9, 'S', 39),
(10, 'S', 30),
(10, 'M', 2),
(11, 'S', 102),
(11, 'M', 59),
(11, 'L', 71),
(12, 'M', 45),
(12, 'L', 45),
(13, 'S', 83),
(13, 'M', 83),
(14, 'L', 70),
(15, 'M', 79),
(15, 'L', 34),
(16, 'XS', 23),
(16, 'S', 75),
(16, 'M', 38),
(17, 'L', 20),
(18, 'S', 58),
(18, 'L', 10),
(19, 'L', 15),
(20, 'S', 39),
(20, 'K', 76),
(21, 'L', 38),
(21, 'M', 57),
(22, 'S', 37),
(22, 'M', 4),
(23, 'L', 92),
(23, 'M', 102),
(24, 'S', 73),
(24, 'M', 20),
(25, 'S', 67),
(25, 'M', 49),
(26, 'L', 40),
(26, 'M', 82),
(27, 'S', 58),
(28, 'M', 20),
(28, 'L', 10),
(29, 'M', 50),
(29, 'L', 70),
(30, 'S', 20),
(30, 'M', 24),
(31, 'M', 42),
(31, 'L', 42),
(32, 'M', 92),
(32, 'L', 33),
(32, 'XL', 34)
--tblColorSizes(colorSizeID, productColorID, size, quantity)----

GO

INSERT INTO tblOrderDetail(price, quantity, size, color, orderID, productID)
VALUES
(216000, 2, 'S', N'Trắng', 1, 1),
(216000, 1, 'M', N'Be', 1, 1),
(185000, 1, 'S', N'Xanh nhạt', 1, 4),
(185000, 1, 'M', N'Xanh nhạt', 1, 10),
(185000, 1, 'M', N'Be', 1, 10),
(185000, 1, 'M', N'Xanh nhạt', 2, 10),
(299000, 2, 'XS', N'Be', 2, 4),
(185000, 1, 'M', N'Xanh nhạt', 3, 10),
(185000, 2, 'S', N'Xanh nhạt', 4, 10),
(595000, 2,  'M', N'Đen', 5, 11),
(495000, 1,  'M', N'Be', 5, 7),
(520000, 1,  'L', N'Be', 5, 8),
(216000, 1, 'L', N'Đen', 6, 1),
(185000, 3, 'XS', N'Xanh nhạt', 6, 10),
(424000, 3, '28', N'Xanh Blue', 7, 2),
(285000, 1, 'L', N'Be', 8, 15),
(185000, 1, 'M', N'Xanh nhạt', 9, 10),
(185000, 2, 'S', N'Xanh nhạt', 10, 10),
(595000, 2,  'M', N'Đen', 11, 11),
(495000, 1,  'M', N'Be', 2, 7),
(520000, 1,  'L', N'Be', 5, 8),
(216000, 1, 'L', N'Đen', 6, 1),
(185000, 3, 'XS', N'Xanh nhạt', 6, 10),
(424000, 3, '28', N'Xanh Blue', 7, 2),
(285000, 1, 'L', N'Be', 8, 15),
(216000, 2, 'S', N'Trắng', 9, 1),
(216000, 1, 'M', N'Be', 10, 1),
(185000, 1, 'S', N'Xanh nhạt', 11, 4),
(185000, 1, 'M', N'Xanh nhạt', 11, 10),
(185000, 1, 'M', N'Be', 12, 10),
(185000, 1, 'M', N'Xanh nhạt', 12, 10),
(299000, 2, 'XS', N'Be', 13, 4),
(185000, 1, 'M', N'Xanh nhạt', 14, 10),
(185000, 2, 'S', N'Xanh nhạt', 14, 10),
(595000, 2,  'M', N'Đen', 15, 11),
(495000, 1,  'M', N'Be', 16, 7),
(520000, 1,  'L', N'Be', 17, 8),
(216000, 1, 'L', N'Đen', 18, 1),
(185000, 3, 'XS', N'Xanh nhạt',18, 10),
(424000, 3, '28', N'Xanh Blue', 19, 2),
(285000, 1, 'L', N'Be', 19, 15),
(185000, 1, 'M', N'Xanh nhạt', 20, 10),
(185000, 2, 'S', N'Xanh nhạt', 21, 10),
(595000, 2,  'M', N'Đen', 22, 11),
(495000, 1,  'M', N'Be', 23, 7),
(520000, 1,  'L', N'Be', 24, 8),
(216000, 1, 'L', N'Đen', 25, 1),
(185000, 3, 'XS', N'Xanh nhạt',26, 10),
(424000, 3, '28', N'Xanh Blue', 27, 2),
(285000, 1, 'L', N'Be', 28, 15),
(185000, 1, 'M', N'Xanh nhạt', 29, 10),
(185000, 2, 'S', N'Xanh nhạt', 30, 10),
(595000, 2,  'M', N'Đen', 31, 11),
(495000, 1,  'M', N'Be', 32, 7),
(520000, 1,  'L', N'Be', 33, 8),
(216000, 1, 'L', N'Đen', 34, 1),
(185000, 3, 'XS', N'Xanh nhạt', 35, 10),
(424000, 3, '28', N'Xanh Blue', 36, 2),
(285000, 1, 'L', N'Be', 37, 15),
(216000, 2, 'S', N'Trắng', 38, 1),
(216000, 1, 'M', N'Be', 39, 1),
(185000, 1, 'S', N'Xanh nhạt', 40, 4),
(185000, 1, 'M', N'Xanh nhạt', 41, 10),
(185000, 1, 'M', N'Be', 42, 10),
(185000, 1, 'M', N'Xanh nhạt', 43, 10),
(299000, 2, 'XS', N'Be', 43, 4),
(185000, 1, 'M', N'Xanh nhạt', 44, 10),
(185000, 2, 'S', N'Xanh nhạt', 45, 10),
(595000, 2,  'M', N'Đen', 46, 11),
(495000, 1,  'M', N'Be', 46, 7),
(520000, 1,  'L', N'Be', 47, 8),
(216000, 1, 'L', N'Đen', 48, 1),
(185000, 3, 'XS', N'Xanh nhạt',49, 10),
(424000, 3, '28', N'Xanh Blue', 50, 2),
(285000, 1, 'L', N'Be', 51, 15),
(185000, 1, 'M', N'Xanh nhạt', 52, 10),
(185000, 2, 'S', N'Xanh nhạt', 53, 10),
(595000, 2,  'M', N'Đen', 54, 11),
(495000, 1,  'M', N'Be', 55, 7),
(520000, 1,  'L', N'Be', 56, 8),
(216000, 1, 'L', N'Đen', 57, 1),
(185000, 3, 'XS', N'Xanh nhạt',58, 10),
(424000, 3, '28', N'Xanh Blue', 59, 2),
(285000, 1, 'L', N'Be', 60, 15),
(495000, 1,  'M', N'Be', 61, 7),
(520000, 1,  'L', N'Be', 62, 8),
(216000, 1, 'L', N'Đen', 63, 1),
(185000, 3, 'XS', N'Xanh nhạt',64, 10),
(424000, 3, '28', N'Xanh Blue', 65, 2),
(285000, 1, 'L', N'Be', 66, 15)
---tblOrderDetail(detailID la tu tang, price, quantity, size, color, orderID, productID)----

GO

INSERT INTO tblRating VALUES
(1, 'maitran21@gmail.com', N'Mặc hợp dáng, vải mát ôm form thích lắm luôn. Cho shop 5 sao <3', 5, '2022/05/04'),
(2, 'hanguyenanh@gmail.com', N'Áo đẹp, lần sau mua lại', 5, '2022/05/04'),
(3, 'godrick888@gmail.com', N'Mua cho con bạn thân. Nó review ok.', 4, '2022/05/04'),
(4, 'maitran21@gmail.com', N'Hàng đi kèm giấy cảm ơn của shop đáng yêu quá đi. Lần sau sẽ ủng hộ tiếp <333', 5, '2022/05/04'),
(5, 'maitran21@gmail.com', N'Không đẹp như tưởng tượng', 2, '2022/05/04'),
(6, 'monicaluv@gmail.com', N'Hôm qua đặt hôm nay có luôn. Áo đẹp không phàn nàn gì về chất lượng cả.', 5, '2022/05/04'),
(7, 'maitran21@gmail.com', N'Sản phẩm đáng mua, với giá tiền này thì không có gì để chê cả', 5, '2022/05/12'),
(8, 'hanguyenanh@gmail.com', N'Hài lòng về chất liệu và giá thành, giao hàng nhanh', 5, '2022/05/04'),
(10, 'godrick888@gmail.com', N'Vải dày, đường may đẹp, thời gian giao hàng rất nhanh', 4, '2022/05/30'),
(11, 'maitran21@gmail.com', N'Hàng đẹp, vải khá thoáng, hàng giao nhanh sẽ ủng hộ ', 5, '2022/05/18'),
(9, 'maitran21@gmail.com', N'Vải nóng, mặc chỗ nào có điều hòa thôi, ra đường thì chịu', 2, '2022/05/15'),
(20, 'haunguyen@gmail.com', N'Đường chỉ bên tay trái bị lỗi khì nó nhăn khá xấu.', 3, '2022/05/17'),
(12, 'monicaluv@gmail.com', N'Hàng cotton mặc mát. Giặt cũng không bị nhăn. Hợp cho các bạn đi làm', 5, '2022/05/04'),
(10, 'maitran21@gmail.com', N'Sản phẩm đáng mua, với giá tiền này thì không có gì để chê cả', 5, '2022/05/12'),
(11, 'hanguyenanh@gmail.com', N'Nay buồn nên cho 1 sao nha shop =))', 5, '2022/05/04'),
(13, 'godrick888@gmail.com', N'Váy khá ổn, chất vải mỏng nhưng vẫn không lộ, giao hơi lâu, mặc size S 1m47 37kg oke', 4, '2022/05/30'),
(12, 'maitran21@gmail.com', N'Sản phẩm tốt đồ đẹp, y như hình, chất lượng cao, sẽ ủng hộ shop lần sau', 5, '2022/05/18'),
(9, 'maitran21@gmail.com', N'Mua cho mẹ nhân Ngày của Mẹ. Mẹ khen con gái có mắt nhìn :D', 5, '2022/05/15'),
(8, 'haunguyen@gmail.com', N'Đồ xinh lắm. Vải đẹp. Đường may cẩn thận. K chỉ thừa.', 3, '2022/05/17')


---tblRating(id [identity], productID, userID, content, star, rateDate)----

GO


INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate)
VALUES
(1, 1, '2022-05-07 13:43'),
(2, 1, '2022-05-08 07:33'),
(3, 1, '2022-05-09 09:22'),
(4, 1, '2022-05-11 20:13'),
(5, 1, '2022-05-12 15:53'),
(1, 2, '2022-05-07 13:43'),
(2, 2, '2022-05-08 07:33'),
(3, 2, '2022-05-09 09:22'),
(4, 2, '2022-05-11 20:13'),
(1, 3, '2022-05-07 13:43'),
(2, 3, '2022-05-08 07:33'),
(3, 3, '2022-05-09 09:22'),
(1, 4, '2022-05-11 20:13'),
(1, 5, '2022-05-12 15:53'),
(2, 5, '2022-05-08 07:33'),
(3, 5, '2022-05-09 09:22'),
(1, 6, '2022-05-10 09:22'),
(2, 6, '2022-05-11 20:13'),
(1, 7, '2022-05-17 13:43'),
(1, 8, '2022-05-10 09:22'),
(1, 9, '2022-05-17 21:13'),
(2, 9, '2022-05-18 16:43')


----tblOrderStatusUpdate(ID{identity}, statusID, orderID, updateDate)----

GO

CREATE FUNCTION [dbo].[fuChuyenCoDauThanhKhongDau] (@text nvarchar(max)) 
RETURNS nvarchar(max) 
AS 
BEGIN 	
SET @text = LOWER(@text) 	
DECLARE @textLen int = LEN(@text) 	
IF @textLen > 0 	
BEGIN 		
DECLARE @index int = 1 		
DECLARE @lPos int 		
DECLARE @SIGN_CHARS nvarchar(100) = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýđð' 		
DECLARE @UNSIGN_CHARS varchar(100) = 'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyydd' WHILE @index <= @textLen 
BEGIN 			
SET @lPos = CHARINDEX(SUBSTRING(@text,@index,1),@SIGN_CHARS) 	
IF @lPos > 0 	
BEGIN 			
SET @text = STUFF(@text,@index,1,SUBSTRING(@UNSIGN_CHARS,@lPos,1)) 		
END 			
SET @index = @index + 1
 	END 
END 
RETURN @text
 END


go
CREATE VIEW orderReview AS
SELECT t2.ID, t1.orderID, orderDate, total, t1.userID, t4.fullName, t2.statusID, statusName, [dbo].[fuChuyenCoDauThanhKhongDau](fullName) as [TenKhongDau], trackingID 
FROM ((tblOrder t1 JOIN tblOrderStatusUpdate t2 ON t1.orderID = t2.orderID) JOIN tblOrderStatus t3 ON t2.statusID = t3.statusID) JOIN tblUsers t4 ON t1.userID = t4.userID;

go
CREATE VIEW currentStatusRow AS
SELECT MAX(ID) as ID
FROM tblOrderStatusUpdate
GROUP BY orderID



