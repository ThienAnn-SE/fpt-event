create database [FU-Event]
go

use [FU-Event]
go

create table tblRoles(
	roleID   integer primary key,
	roleName nvarchar(30) not null
)

create table tblUserStatuses(
	statusID			integer			primary key,
	statusDescription	nvarchar(30)	not null,
)

create table tblUsers(
	userEmail	 varchar(30)		primary key,
	userName	 nvarchar(max),
	dateOfBirth	 date,
	gender		 bit,
	phoneNumber  varchar(15)		unique,
	roleID		 integer			foreign key references tblRoles,
	statusID	 integer			foreign key references tblUserStatuses
)

create table tblLocations( 
	locationID			integer			identity(10,5)	primary key,
	locationName		nvarchar(30)	not null,
	locationCapacity	integer			not null
)

create table tblCategories(
	categoryID		integer				identity(10,5)	primary key,
	categoryName	nvarchar(30)		not null
)

create table tblClubDetails(
	clubID				integer				identity(10,5)	primary key,
	clubName			nvarchar(50)		not null	unique,
	createDate			date				not null,
	clubDescription		ntext				not null,
	clubEmail			varchar(30),
	clubPhoneNumber		varchar(15)			unique,
	userEmail			varchar(30)			foreign key references	tblUsers
	)

create table tblEventStatuses(
	statusID			integer			primary key,
	statusDescription	nvarchar(30)	not null
)
	
create table tblFUEvents(
	eventID			integer			identity(10,1)	primary key,
	eventName		nvarchar(255)	not null	unique,
	clubID			integer			foreign key references tblClubDetails,
	locationID		integer			foreign key references tblLocations,
	categoryID		integer			foreign key	references tblCategories,
	statusID		integer			foreign key references tblEventStatuses,
	createDate		date			not null,
	registerEndDate datetime		not null,
	startDate		datetime		not null,
	endDate			datetime		not null,
	slot			int				not null,
	imageURL		varchar(max),
	content			ntext			not null,
	ticketFee		int				not null
	)

create table tblFollowed(
	followID		integer			identity(10,1)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers,
	followDate		date			not null,
	constraint	UC_tblFollowed	unique (eventID, userEmail)
)

create table tblLiked(
	likeID			integer			identity(10,1)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers,
	constraint	UC_tblLiked	unique (eventID, userEmail)
)

create table tblEventRegisters(
	registerID			integer			identity(10,1)	primary key,
	eventID				integer			foreign key references tblFUEvents,
	userEmail			varchar(30)		foreign key references tblUsers,
	registerDate		date			not null,
	constraint	UC_tblEventRegister unique (eventID, userEmail)
	)

create table tblFeedbacks(
	feedbackID		integer			identity(10,1)	primary key,
	registerID		integer			foreign key references tblEventRegisters,
	feedback		ntext			not null,
	vote			float			not null	check (vote >= 0)
	)

create table tblPayments(
	paymentID			integer			identity(10,1)	primary key,
	registerID			integer			foreign key references tblEventRegisters,
	paymentDescription  nvarchar(255)	not null,
	statusDescription	varchar(30)		not null,
	paymentMethod		varchar(30)		not null,
	paymentDate			date			not null,
	paymentTotal		float			not null
	)

create table tblBanRequests(
	requestID			integer			identity(10,1)	primary key,
	clubID				integer			foreign key		references tblClubDetails,
	userEmail			varchar(30)		foreign key		references tblUsers,
	sendDate			Date			not null,
	approvalDate		Date,
	requestStatus		bit				not null
)

create table tblComments(
	commentID			integer			identity(10,1)	primary key,
	eventID				integer			foreign key		references tblFUEvents,
	userEmail			varchar(30)		foreign key		references	tblUsers,
	avatar				varchar(max)	not null,
	comment				nvarchar(100)	not null,
	postDate			Date			not null,
	visible				bit				not null
)

create table tblCommentReports(
	reportID		integer				identity(10,1)		primary key,
	commentID		integer				foreign key			references tblComments,
	userEmail		varchar(30)			foreign key		 	references tblUsers,
	sendDate		Date				not null,
	approvalDate	Date,
	reportStatus	integer				not null
)

create table tblVisitorCounters(
	counterID				integer				identity(1,1)		primary key,
	logDate					Date				not null,
	visitorNumber			integer					not null
)

	INSERT INTO tblRoles(roleID, roleName) VALUES (1,'Student')
	INSERT INTO tblRoles(roleID, roleName) VALUES (2,'Lecture')
	INSERT INTO tblRoles(roleID, roleName) VALUES (3,'Mentor')
	INSERT INTO tblRoles(roleID, roleName) VALUES (4,'Club leader')
	INSERT INTO tblRoles(roleID, roleName) VALUES (5,'Department leader')
	INSERT INTO tblRoles(roleID, roleName) VALUES (10,'Admin')

	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (300,'Vừa khởi tạo')
	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (500,'Đã cập nhật')
	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (400,'Không hoạt động')
	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (450,'Hạn chế')

	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trungtlhde161203@fpt.edu.vn',N'Trần Lê Hiếu Trung','2002-5-26',1,'0343322344',4,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duchtsa134114@fpt.edu.vn',N'Hoàng Trọng Đức','1999-10-30',1,'01217398138',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phunghnsa145238@fpt.edu.vn',N'Huỳnh Ngọc Phúc','2000-12-25',0,'0341312318',1,400)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhhnsa145050@fpt.edu.vn',N'Huỳnh Ngọc Ánh','2000-1-17',0,'0343322314',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thaocbsa131164@fpt.edu.vn',N'Châu Bội Thảo','1999-2-14',1,'0943221274',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('luathngsa147121@fpt.edu.vn',N'Hoàng Ngọc Gia Luật','2000-10-3',1,'0347382324',1,400)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phucntse136225@fpt.edu.vn',N'Nguyễn Thục Phúc','1999-1-30',1,'01219447289',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thinhldse141665@fpt.edu.vn',N'Lý Đoàn Thịnh','2000-5-11',1,'0343322354',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duytlse140800@fpt.edu.vn',N'Trương Lý Duy','2000-3-29',1,'01218901720',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duylcnss136201@fpt.edu.vn',N'Lý Ngọc Cường Duy','1999-7-27',1,'01213984992',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mydvse151451@fpt.edu.vn',N'Đường Vỹ My','2001-4-21',1,'02213984192',4,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhlhbse153142@fpt.edu.vn',N'Lý Hoàng Bá Ánh','2001-4-30',1,'09343984992',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('taintse151333@fpt.edu.vn',N'Nguyễn Trương Tài','2000-5-1',1,'09343484912',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('chitthse161164@fpt.edu.vn',N'Trương Thị Huỳnh Chi','2001-12-3',0,'02343383952',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('vyndhss151512@fpt.edu.vn',N'Nguyễn Đặng Huỳnh Vỹ','2001-1-28',1,'08342284292',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('truclhss159414@fpt.edu.vn',N'Lý Hoàng Trúc','2001-7-9',0,'05328284292',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('uyentlpse171664@fpt.edu.vn',N'Trương Lý Phụng Uyên','2003-11-11',0,'0528665682',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhinyse177341@fpt.edu.vn',N'Nguyễn Yến Nhi','2003-2-16',0,'0528265622',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thanhldse171878@fpt.edu.vn',N'Lý Dương Thành','2003-6-11',1,'0528065692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mynlhss172290@fpt.edu.vn',N'Nguyễn Lý Huyền My','2003-8-22',0,'0928115692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trangntmss171002@fpt.edu.vn',N'Ngọc Trương Minh Trang','2003-9-26',0,'0528165692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('diemtbsa170121@fpt.edu.vn',N'Trần Bích Diễm','2003-9-1',0,'0523015690',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('maithsa171010@fpt.edu.vn',N'Trương Huyền Mai','2003-12-4',0,'0521060642',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huongvqss1710948@fpt.edu.vn',N'Vương Quốc Hương','2003-3-7',1,'0328005491',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huylmse141317@fpt.edu.vn',N'Lý Mạnh Huy','2000-11-7',1,'0328125491',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('conglktse140432@fpt.edu.vn',N'Lê Khuyên Thế Công','2000-3-18',1,'0228015492',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tritqse149416@fpt.edu.vn',N'Trịnh Quyền Trí','1999-5-21',1,'0528010493',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thiemdkse146054@fpt.edu.vn',N'Doãn Khương Thiêm','2000-1-27',1,'0728085471',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhultqse141903@fpt.edu.vn',N'Lâm Thị Quốc Như','2000-12-24',0,'0328080481',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhnhnse141030@fpt.edu.vn',N'Nguyễn Hoàng Ngọc Anh','1999-4-6',0,'0128075991',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhiptse151227@fpt.edu.vn',N'Phương Thị Nhi','2001-3-7',0,'0628061431',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trinmse151551@fpt.edu.vn',N'Ngọc Mạnh Trí','2000-6-12',1,'0828505411',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('ducntse130717@fpt.edu.vn',N'Nguyễn Trường Đức','1999-8-10',1,'0828302461',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('danhdcse144643@fpt.edu.vn',N'Đoàn Cương Danh','2000-12-21',1,'0628105491',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('synnvse161245@fpt.edu.vn',N'Ngô Ngọc Vinh Sĩ','2002-10-1',1,'0428105491',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huynqse164356@fpt.edu.vn',N'Nguyễn Quốc Huy','2002-12-21',1,'0278101191',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huynsnse169382@fpt.edu.vn',N'Ngô Sỹ Nguyên Huy','2002-11-1',1,'0428705192',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('bodtse166315@fpt.edu.vn',N'Đỗ Thục Bố','2002-9-12',1,'0527105894',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('dangptmse162404@fpt.edu.vn',N'Phạm Trương Mạnh Đăng','2001-8-4',1,'0628015895',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duynhkse167489@fpt.edu.vn',N'Ngô Huỳnh Khang Duy','2002-7-16',1,'0238108796',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phungnlse160214@fpt.edu.vn',N'Nguyễn Lương Phụng','2002-2-26',0,'0148785692',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tunhse166531@fpt.edu.vn',N'Ngô Huỳnh Tú','2002-7-17',0,'0476105497',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('quangntse161546@fpt.edu.vn',N'Đoàn Chương Danh','2002-4-1',1,'0624105397',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thangbvse161511@fpt.edu.vn',N'Bùi Vương Thắng','2001-11-8',1,'0242105591',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('lamnpds144176@fpt.edu.vn',N'Ngô Phương Lâm','2000-1-7',0,'0242115591',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('bichtdnss141165@fpt.edu.vn',N'Trương Đặng Như Bích','2000-2-20',0,'0252105596',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khanhhnss154319@fpt.edu.vn',N'Hương Ngọc khánh','1999-6-8',0,'0106105698',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huongctss154362@fpt.edu.vn',N'Chương Thị Hương','2001-10-27',0,'0512705797',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('ngocdhss153363@fpt.edu.vn',N'Đặng Hương Ngọc','2001-4-16',0,'0102180895',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('ngoclthss153362@fpt.edu.vn',N'Lý Thương Huỳnh Ngọc','2001-9-12',0,'0262195294',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phucnqhss159378@fpt.edu.vn',N'Ngô Quang Huỳnh Phúc','2001-12-27',1,'0150109492',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tienlttss151220@fpt.edu.vn',N'Loan Thủy Thị Tiên','2001-1-26',0,'0232151194',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khadnss150193@fpt.edu.vn',N'Đặng Ngọc Kha','2001-2-6',1,'0142405592',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khapss158602@fpt.edu.vn',N'Phương Khương Kha','2001-1-18',1,'0212105094',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anltse151328@fpt.edu.vn',N'Lê Thiên Ân','2001-5-9',1,'0528661694',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('quantvse151344@fpt.edu.vn',N'Trương Vũ Quân','2001-9-9',1,'0312505093',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khanhnqse151055@fpt.edu.vn',N'Ngô Quang Khánh','2001-10-9',1,'0419805192',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mythse150906@fpt.edu.vn',N'Trương Huyền My','2001-1-4',0,'0517145049',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhivnse151940@fpt.edu.vn',N'Vương Ngọc Nhi','2001-2-22',0,'0615150595',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tiendxse151112@fpt.edu.vn',N'Đường Xương Tiến','2001-10-30',1,'0713105197',1,500)

	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Bussiness Economics Club','2018-7-20','Stop Wishing - Start Doing','bec.fptuhcm@gmail.com','0728665912','duytlse140800@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Multimedia & Entertainment Club','2016-5-11','Share your imagination','mec.fptuhcm@gmail.com','0528761091','thaocbsa131164@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Cóc Sài Gòn','2019-5-20','Follow your passion','csg.fptuhcm@gmail.com','0728775112','thinhldse141665@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Event Club','2016-1-25','The way we went','fev.fptuhcm@gmail.com','0931229051','duchtsa134114@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Basketball Club','2016-1-11','Ballers with a ball','fbc.fptuhcm@gmail.com','0212105094','khapss158602@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('SkillCetera','2016-1-25','Be brave - Be yourself','tedxfptu.fptuhcm@gmail.com','0252105596','bichtdnss141165@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Hardware Network FPTU','2016-1-25','Hardware but soft soul','hnf.fptuhcm@gmail.com','02213984192','mydvse151451@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Chess Club','2016-1-25','Keep clam to become champions','fcc.fptuhcm@gmail.com','0148785692','phungnlse160214@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Beat King Club','2016-1-25','Sing your way','fbk.fptuhcm@gmail.com','0628105491','danhdcse144643@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Vovinam Club','2016-1-25',N'Nơi gắn kết niềm đam mê','fvc.fptuhcm@gmail.com','0628015895','dangptmse162404@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Traditional Instrument','2016-1-25','Old but not faded','fti.fptuhcm@gmail.com','0128075991','anhnhnse141030@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FCode','2016-1-25','F-code - Code the Dream','fcode.fptuhcm@gmail.com','09343484912','taintse151333@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('SiTi Group','2016-1-25','Keep loving by sharing','sitigroup.fptuhcm@gmail.com','0528265622','nhinyse177341@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Football Club','2016-1-25','No fail no success','ffc.fptuhcm@gmail.com','0528010493','tritqse149416@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FStyle Hip-hop Club','2016-1-25','Never stop trying','fstylefptu.fptuhcm@gmail.com','0476105497','tunhse166531@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('F# LIVE MUSIC CLUB','2016-1-25','Be Your Self, Show Your Style','fsharp.fptuhcm@gmail.com','05328284292','truclhss159414@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Volleyball Club','2016-1-25','Do not stop trying until success','fvb.fptuhcm@gmail.com','0228015492','conglktse140432@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Japan Style Club','2016-1-25','Japan passion in your soul','jsc.fptuhcm@gmail.com','0521060642','maithsa171010@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Information Assurance','2016-1-25','Keep your secret secret','fia.fptuhcm@gmail.com','0343322344','trungtlhde161203@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Public Speaking','2016-1-25','Tell us your dream','fps.fptuhcm@gmail.com','0232151194','tienlttss151220@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Art and Culture','2016-1-25','Dream it possible','fac.fptuhcm@gmail.com','0528665682','uyentlpse171664@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Unity Dance Crew','2016-1-25','Show off your passion','udcsg.fpt@gmail.com','0102180895','ngocdhss153363@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Board Games','2016-1-25','For the best Generation','fbghcm.fpuhcm@gmail.com','0242115591','lamnpds144176@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Developer Student Club','2016-1-25','Develop program - Develop yourself','dsc.fptu.hcmc@gmail.com','0528661694','anltse151328@fpt.edu.vn')

	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Semina', 40)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Hall A', 250)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Hall B', 150)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Floor 3_Library',100)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Floor 1_Semi outdoor',50)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Floor 2_Semi outdoor',40)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Floor 3_Semi outdoor',40)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Floor 4_Semi outdoor',30)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('Trong Dong Lobby',50)
	INSERT INTO tblLocations(locationName,locationCapacity) VALUES ('School yard',400)

	INSERT INTO tblCategories(categoryName) VALUES ('Seminar')
	INSERT INTO tblCategories(categoryName) VALUES ('Entertainment Event')
	INSERT INTO tblCategories(categoryName) VALUES ('Learning Event')
	
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (300,'Not-start')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (400,'Cancel')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (500,'Starting')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (550,'On-going')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (570,'Close')

	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',20,15,10,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',25,15,15,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',30,10,20,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',35,20,10,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',40,30,20,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)

	INSERT INTO tblFUEvents (eventName, clubID, locationID, categoryID, statusID, createDate,registerEndDate, startDate, endDate, slot, content, ticketFee) VALUES ('FPTU Quiz Competition',125,55,15,570,'2021-10-14','2021-10-25','2021/10/27 07:30:00','2021-10-28 12:10:30',100,'content',0)

	select * from tblLocations

	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (20, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (30, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (70, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (40, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (25, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (55, 'anltse151328@fpt.edu.vn', '2021-10-6')

	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10, 'huongvqss1710948@fpt.edu.vn','2021-10-29')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10, 'chitthse161164@fpt.edu.vn','2021-10-30')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10, 'duylcnss136201@fpt.edu.vn','2021-10-28')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10, 'thaocbsa131164@fpt.edu.vn','2021-10-29')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10, 'nhinyse177341@fpt.edu.vn','2021-10-28')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10, 'trungtlhde161203@fpt.edu.vn','2021-10-29')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10, 'thanhldse171878@fpt.edu.vn','2021-10-30')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10,'quangntse161546@fpt.edu.vn','2021-10-29')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10,'thangbvse161511@fpt.edu.vn','2021-10-30')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10,'lamnpds144176@fpt.edu.vn','2021-10-28')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10,'bichtdnss141165@fpt.edu.vn','2021-10-28')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (10,'khanhhnss154319@fpt.edu.vn','2021-10-29')
	
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12, 'huongvqss1710948@fpt.edu.vn','2021-10-29')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12, 'chitthse161164@fpt.edu.vn','2021-10-30')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12, 'duylcnss136201@fpt.edu.vn','2021-10-28')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12, 'thaocbsa131164@fpt.edu.vn','2021-10-29')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12, 'nhinyse177341@fpt.edu.vn','2021-10-28')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12, 'trungtlhde161203@fpt.edu.vn','2021-10-29')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12, 'thanhldse171878@fpt.edu.vn','2021-10-30')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'bodtse166315@fpt.edu.vn','2021-11-14')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'dangptmse162404@fpt.edu.vn','2021-11-13')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'duynhkse167489@fpt.edu.vn','2021-11-12')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'phungnlse160214@fpt.edu.vn','2021-11-14')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'tunhse166531@fpt.edu.vn','2021-11-11')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'quangntse161546@fpt.edu.vn','2021-11-10')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'thangbvse161511@fpt.edu.vn','2021-11-14')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'lamnpds144176@fpt.edu.vn','2021-11-5')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'bichtdnss141165@fpt.edu.vn','2021-11-6')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (12,'khanhhnss154319@fpt.edu.vn','2021-11-7')

	
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13, 'huongvqss1710948@fpt.edu.vn','2021-11-12')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13, 'chitthse161164@fpt.edu.vn','2021-10-30')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13, 'duylcnss136201@fpt.edu.vn','2021-11-13')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13, 'thaocbsa131164@fpt.edu.vn','2021-11-12')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13, 'nhinyse177341@fpt.edu.vn','2021-10-28')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13, 'trungtlhde161203@fpt.edu.vn','2021-11-11')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13, 'thanhldse171878@fpt.edu.vn','2021-11-10')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'dangptmse162404@fpt.edu.vn','2021-11-5')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'duynhkse167489@fpt.edu.vn','2021-11-4')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'phungnlse160214@fpt.edu.vn','2021-11-4')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'tunhse166531@fpt.edu.vn','2021-11-3')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'quangntse161546@fpt.edu.vn','2021-11-1')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'thangbvse161511@fpt.edu.vn','2021-11-2')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'lamnpds144176@fpt.edu.vn','2021-11-5')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'bichtdnss141165@fpt.edu.vn','2021-11-6')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (13,'khanhhnss154319@fpt.edu.vn','2021-11-7')

	
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14, 'huongvqss1710948@fpt.edu.vn','2021-11-7')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14, 'chitthse161164@fpt.edu.vn','2021-11-8')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14, 'duylcnss136201@fpt.edu.vn','2021-11-9')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14, 'thaocbsa131164@fpt.edu.vn','2021-11-9')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14, 'nhinyse177341@fpt.edu.vn','2021-11-8')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14, 'trungtlhde161203@fpt.edu.vn','2021-11-11')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14, 'thanhldse171878@fpt.edu.vn','2021-11-13')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'bodtse166315@fpt.edu.vn','2021-11-14')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'dangptmse162404@fpt.edu.vn','2021-11-13')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'duynhkse167489@fpt.edu.vn','2021-11-12')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'phungnlse160214@fpt.edu.vn','2021-11-14')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'tunhse166531@fpt.edu.vn','2021-11-11')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'quangntse161546@fpt.edu.vn','2021-11-10')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'thangbvse161511@fpt.edu.vn','2021-11-14')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'lamnpds144176@fpt.edu.vn','2021-11-5')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'bichtdnss141165@fpt.edu.vn','2021-11-6')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (14,'khanhhnss154319@fpt.edu.vn','2021-11-7')

	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19, 'huongvqss1710948@fpt.edu.vn','2021-10-18')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19, 'chitthse161164@fpt.edu.vn','2021-10-18')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19, 'duylcnss136201@fpt.edu.vn','2021-10-19')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19, 'thaocbsa131164@fpt.edu.vn','2021-10-19')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19, 'nhinyse177341@fpt.edu.vn','2021-10-18')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19, 'trungtlhde161203@fpt.edu.vn','2021-10-20')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19, 'thanhldse171878@fpt.edu.vn','2021-10-25')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'bodtse166315@fpt.edu.vn','2021-10-26')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'dangptmse162404@fpt.edu.vn','2021-10-25')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'duynhkse167489@fpt.edu.vn','2021-10-23')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'phungnlse160214@fpt.edu.vn','2021-10-24')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'tunhse166531@fpt.edu.vn','2021-10-26')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'quangntse161546@fpt.edu.vn','2021-10-25')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'thangbvse161511@fpt.edu.vn','2021-10-22')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'lamnpds144176@fpt.edu.vn','2021-10-25')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'bichtdnss141165@fpt.edu.vn','2021-10-26')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (19,'khanhhnss154319@fpt.edu.vn','2021-10-27')

	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19, 'huongvqss1710948@fpt.edu.vn','2021-10-19')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19, 'chitthse161164@fpt.edu.vn','2021-10-21')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19, 'duylcnss136201@fpt.edu.vn','2021-10-17')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19, 'thaocbsa131164@fpt.edu.vn','2021-10-19')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19, 'nhinyse177341@fpt.edu.vn','2021-10-18')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19, 'trungtlhde161203@fpt.edu.vn','2021-10-20')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19, 'thanhldse171878@fpt.edu.vn','2021-10-20')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'bodtse166315@fpt.edu.vn','2021-10-26')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'dangptmse162404@fpt.edu.vn','2021-10-22')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'duynhkse167489@fpt.edu.vn','2021-10-23')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'phungnlse160214@fpt.edu.vn','2021-10-24')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'tunhse166531@fpt.edu.vn','2021-10-23')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'quangntse161546@fpt.edu.vn','2021-10-21')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'thangbvse161511@fpt.edu.vn','2021-10-22')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'lamnpds144176@fpt.edu.vn','2021-10-20')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'bichtdnss141165@fpt.edu.vn','2021-10-26')
	INSERT INTO tblFollowed(eventID,userEmail,followDate) VALUES (19,'khanhhnss154319@fpt.edu.vn','2021-10-27')


	select fb.feedback , fb.vote, er.userEmail 
	from tblFeedbacks as fb
	left join tblEventRegisters as er on fb.registerID = er.registerID
	where er.userEmail = 'baonngse150655@fpt.edu.vn'

	SELECT count(fb.feedbackID) as num
                         FROM tblFeedbacks AS fb
                        LEFT JOIN tblEventRegisters AS er ON er.registerID = fb.registerID
                         WHERE fb.registerID IN (SELECT registerID
                        FROM tblEventRegisters
                        WHERE eventID = 14)

	select * from tblUsers where roleID =1
	select * from tblEventRegisters  as er
	left join tblFUEvents as e on er.eventID = e.eventID
	where er.userEmail = 'baonngse150655@fpt.edu.vn'
	select * from tblFeedbacks 


	select * from tblBanRequests
	update tblCommentReports set userEmail = 'khanhhnss154319@fpt.edu.vn' where reportID = 12
	select count(reportID) as num
	from tblCommentReports
	where reportStatus = 300

	SELECT count(rp.reportID)
                          FROM tblCommentReports AS rp
                         LEFT JOIN tblComments AS c ON rp.commentID = c.commentID
						 WHERE c.userEmail = 'thanhntse151308@fpt.edu.vn' AND rp.reportStatus = 500


	select * from tblFeedbacks
	where registerID in (select registerID
						from tblEventRegisters
						where eventID = 15)

	select * from tblFollowed
	update tblFollowed set eventID =15 where followID = 36

	select s.statusID, COUNT(u.userEmail)
	from tblUserStatuses as s
	left join tblUsers as u
	on s.statusID = u.statusID
	group by s.statusID
	order by s.statusID

	select eventID, COUNT(userEmail) from tblComments
	WHERE eventID = 18 and visible = 1 
	GROUP BY eventID
	drop table tblLocations

	update tblUsers set roleID = 4 where userEmail = 'anltse151328@fpt.edu.vn'
	delete from tblLocations 

	update tblFUEvents set eventName = 'FPTU DEBATE TOURNAMENT' where eventID = 10
	update tblFUEvents set eventName = 'FPTU COVER CONTEST' where eventID = 12

	select * from tblUsers where  userEmail = 'baonngse150655@fpt.edu.vn'
	SELECT * FROM tblEventRegisters 
	delete from tblEventRegisters

	SELECT * FROM tblFUEvents 
	WHERE statusID in (300 , 500, 550) and startDate >= getdate()
	ORDER BY startDate ASC
	SELECT * FROM tblFUEvents 

	WHERE statusID in (300 , 450, 500)

	SELECT * FROM tblFUEvents
	WHERE statusID NOT IN (400,570)
	AND locationID = 145
	AND (startDate between '2021-11-1' AND '2021-11-26' OR endDate between '2021-11-1' AND '2021-11-26')


	SELECT TOP 3 * FROM tblFUEvents
	WHERE statusID = 500
	ORDER BY startDate ASC


	SELECT * FROM tblFUEvents
	WHERE eventID in (	SELECT eventID
						FROM tblEventRegisters
						WHERE userEmail = 'anltse151328@fpt.edu.vn'
	)

	select * from tblUsers

	SELECT eventID FROM tblEventRegisters
	WHERE eventID in (SELECT eventID FROM tblFUEvents
						WHERE startDate 

	SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY eventID ASC) AS rn, * FROM tblFUEvents) AS b
	WHERE (rn >= (1*7-6) AND rn <= (1*7)) 
	AND statusID not in (570,400)
	
	SELECT eventID
	FROM tblFollowed

	SELECT eventID, count(userEmail) as number
	FROM tblEventRegisters
	WHERE eventID in (20,75)
	GROUP BY eventID

	 
	SELECT * FROM tblFUEvents
	where clubID = 10
	order by startDate
	offset (1-1)*5 rows fetch next 5 rows only

	Update tblFUEvents set statusID = 570 where endDate > GETDATE()
	
	SELECT eventID, startDate, endDate
	FROM tblFUEvents
	WHERE statusID not in (400,570)
	ORDER BY startDate ASC

	select * from tblFUEvents
	WHERE eventName like '%a%'


	declare @date date = getdate() - 2
	SELECT count(visitorNumber) as registerNum
	FROM tblVisitorCounters
	WHERE logDate = @date
	GROUP BY logDate

	select logDate, count(visitorNumber)
	from tblVisitorCounters
	Group by logDate