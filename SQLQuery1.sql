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
	userName	 nvarchar(50),
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

create table tblCatetories(
	catetoryID		integer				identity(10,5)	primary key,
	catetoryName	nvarchar(30)		not null
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
	eventName		nvarchar(50)	not null	unique,
	clubID			integer			foreign key references tblClubDetails,
	locationID		integer			foreign key references tblLocations,
	catetoryID		integer			foreign key	references tblCatetories,
	statusID		integer			foreign key references tblEventStatuses,
	createDate		date			not null,
	startDate		datetime		not null,
	endDate			datetime		not null,
	slot			int				not null,
	avgVote			float			not null,
	imageURL		varchar(max),
	content			ntext			not null,
	ticketFee		int				not null
	)

create table tblFollowed(
	followID		integer			identity(10,1)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers,
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
	statusDescription	varchar(30)		not null,
	paymentDate			date			not null,
	paymentTotal		int				not null
	)

	INSERT INTO tblRoles(roleID, roleName) VALUES (1,'Student')
	INSERT INTO tblRoles(roleID, roleName) VALUES (2,'Lecture')
	INSERT INTO tblRoles(roleID, roleName) VALUES (3,'Mentor')
	INSERT INTO tblRoles(roleID, roleName) VALUES (4,'Club leader')
	INSERT INTO tblRoles(roleID, roleName) VALUES (5,'Department leader')

	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (300,'Vừa khởi tạo')
	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (500,'Đã cập nhật')
	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (400,'Không hoạt động')
	INSERT INTO tblUserStatuses(statusID, statusDescription) VALUES (450,'Hạn chế')

	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trungtlhde161203@fpt.edu.vn','Trần Lê Hiếu Trung','2002-5-26',1,'0343322344',4,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duchtsa134114@fpt.edu.vn','Hoàng Trọng Đức','1999-10-30',1,'01217398138',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phunghnsa145238@fpt.edu.vn','Huỳnh Ngọc Phúc','2000-12-25',0,'0341312318',1,400)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhhnsa145050@fpt.edu.vn','Huỳnh Ngọc Ánh','2000-1-17',0,'0343322314',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thaocbsa131164@fpt.edu.vn','Châu Bội Thảo','1999-2-14',1,'0943221274',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('luathngsa147121@fpt.edu.vn','Hoàng Ngọc Gia Luật','2000-10-3',1,'0347382324',1,400)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phucntse136225@fpt.edu.vn','Nguyễn Thục Phúc','1999-1-30',1,'01219447289',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thinhldse141665@fpt.edu.vn','Lý Đoàn Thịnh','2000-5-11',1,'0343322354',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duytlse140800@fpt.edu.vn','Trương Lý Duy','2000-3-29',1,'01218901720',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duylcnss136201@fpt.edu.vn','Lý Ngọc Cường Duy','1999-7-27',1,'01213984992',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mydvse151451@fpt.edu.vn','Đường Vỹ My','2001-4-21',1,'02213984192',4,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhlhbse153142@fpt.edu.vn','Lý Hoàng Bá Ánh','2001-4-30',1,'09343984992',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('taintse151333@fpt.edu.vn','Nguyễn Trương Tài','2000-5-1',1,'09343484912',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('chitthse161164@fpt.edu.vn','Trương Thị Huỳnh Chi','2001-12-3',0,'02343383952',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('vyndhss151512@fpt.edu.vn','Nguyễn Đặng Huỳnh Vỹ','2001-1-28',1,'08342284292',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('truclhss159414@fpt.edu.vn','Lý Hoàng Trúc','2001-7-9',0,'05328284292',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('uyentlpse171664@fpt.edu.vn','Trương Lý Phụng Uyên','2003-11-11',0,'0528665682',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhinyse177341@fpt.edu.vn','Nguyễn Yến Nhi','2003-2-16',0,'0528265622',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thanhldse171878@fpt.edu.vn','Lý Dương Thành','2003-6-11',1,'0528065692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mynlhss172290@fpt.edu.vn','Nguyễn Lý Huyền My','2003-8-22',0,'0928115692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trangntmss171002@fpt.edu.vn','Ngọc Trương Minh Trang','2003-9-26',0,'0528165692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('diemtbsa170121@fpt.edu.vn','Trần Bích Diễm','2003-9-1',0,'0523015690',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('maithsa171010@fpt.edu.vn','Trương Huyền Mai','2003-12-4',0,'0521060642',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huongvqss1710948@fpt.edu.vn','Vương Quốc Hương','2003-3-7',1,'0328005491',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huylmse141317@fpt.edu.vn','Lý Mạnh Huy','2000-11-7',1,'0328125491',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('conglktse140432@fpt.edu.vn','Lê Khuyên Thế Công','2000-3-18',1,'0228015492',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tritqse149416@fpt.edu.vn','Trịnh Quyền Trí','1999-5-21',1,'0528010493',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thiemdkse146054@fpt.edu.vn','Doãn Khương Thiêm','2000-1-27',1,'0728085471',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhultqse141903@fpt.edu.vn','Lâm Thị Quốc Như','2000-12-24',0,'0328080481',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhnhnse141030@fpt.edu.vn','Nguyễn Hoàng Ngọc Anh','1999-4-6',0,'0128075991',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhiptse151227@fpt.edu.vn','Phương Thị Nhi','2001-3-7',0,'0628061431',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trinmse151551@fpt.edu.vn','Ngọc Mạnh Trí','2000-6-12',1,'0828505411',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('ducntse130717@fpt.edu.vn','Nguyễn Trường Đức','1999-8-10',1,'0828302461',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('danhdcse144643@fpt.edu.vn','Đoàn Cương Danh','2000-12-21',1,'0628105491',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('synnvse161245@fpt.edu.vn','Ngô Ngọc Vinh Sĩ','2002-10-1',1,'0428105491',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huynqse164356@fpt.edu.vn','Nguyễn Quốc Huy','2002-12-21',1,'0278101191',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huynsnse169382@fpt.edu.vn','Ngô Sỹ Nguyên Huy','2002-11-1',1,'0428705192',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('bodtse166315@fpt.edu.vn','Đỗ Thục Bố','2002-9-12',1,'0527105894',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('dangptmse162404@fpt.edu.vn','Phạm Trương Mạnh Đăng','2001-8-4',1,'0628015895',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duynhkse167489@fpt.edu.vn','Ngô Huỳnh Khang Duy','2002-7-16',1,'0238108796',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phungnlse160214@fpt.edu.vn','Nguyễn Lương Phụng','2002-2-26',0,'0148785692',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tunhse166531@fpt.edu.vn','Ngô Huỳnh Tú','2002-7-17',0,'0476105497',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('quangntse161546@fpt.edu.vn','Đoàn Chương Danh','2002-4-1',1,'0624105397',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thangbvse161511@fpt.edu.vn','Bùi Vương Thắng','2001-11-8',1,'0242105591',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('lamnpds144176@fpt.edu.vn','Ngô Phương Lâm','2000-1-7',0,'0242115591',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('bichtdnss141165@fpt.edu.vn','Trương Đặng Như Bích','2000-2-20',0,'0252105596',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khanhhnss154319@fpt.edu.vn','Hương Ngọc khánh','1999-6-8',0,'0106105698',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huongctss154362@fpt.edu.vn','Chương Thị Hương','2001-10-27',0,'0512705797',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('ngocdhss153363@fpt.edu.vn','Đặng Hương Ngọc','2001-4-16',0,'0102180895',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('ngoclthss153362@fpt.edu.vn','Lý Thương Huỳnh Ngọc','2001-9-12',0,'0262195294',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phucnqhss159378@fpt.edu.vn','Ngô Quang Huỳnh Phúc','2001-12-27',1,'0150109492',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tienlttss151220@fpt.edu.vn','Loan Thủy Thị Tiên','2001-1-26',0,'0232151194',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khadnss150193@fpt.edu.vn','Đặng Ngọc Kha','2001-2-6',1,'0142405592',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khapss158602@fpt.edu.vn','Phương Khương Kha','2001-1-18',1,'0212105094',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anltse151328@fpt.edu.vn','Lê Thiên Ân','2001-5-9',1,'0528661694',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('quantvse151344@fpt.edu.vn','Trương Vũ Quân','2001-9-9',1,'0312505093',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('khanhnqse151055@fpt.edu.vn','Ngô Quang Khánh','2001-10-9',1,'0419805192',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mythse150906@fpt.edu.vn','Trương Huyền My','2001-1-4',0,'0517145049',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhivnse151940@fpt.edu.vn','Vương Ngọc Nhi','2001-2-22',0,'0615150595',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('tiendxse151112@fpt.edu.vn','Đường Xương Tiến','2001-10-30',1,'0713105197',1,500)

	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Bussiness Economics Club','2018-7-20','This is a club description','bec.fptuhcm@gmail.com','0728665912','duytlse140800@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Multimedia & Entertainment Club','2016-5-11','This is a club description','mec.fptuhcm@gmail.com','0528761091','thaocbsa131164@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Cóc Sài Gòn','2019-5-20','This is a club description','csg.fptuhcm@gmail.com','0728775112','thinhldse141665@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Event Club','2016-1-25','This is a club description','fev.fptuhcm@gmail.com','0931229051','duchtsa134114@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Basketball Club','2016-1-11','This is a club description','fbc.fptuhcm@gmail.com','0212105094','khapss158602@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('SkillCetera','2016-1-25','This is a club description','tedxfptu.fptuhcm@gmail.com','0252105596','bichtdnss141165@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Hardware Network FPTU','2016-1-25','This is a club description','hnf.fptuhcm@gmail.com','02213984192','mydvse151451@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Chess Club','2016-1-25','This is a club description','fcc.fptuhcm@gmail.com','0148785692','phungnlse160214@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Beat King Club','2016-1-25','This is a club description','fbk.fptuhcm@gmail.com','0628105491','danhdcse144643@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Vovinam Club','2016-1-25','This is a club description','fvc.fptuhcm@gmail.com','0628015895','dangptmse162404@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Traditional Instrument','2016-1-25','This is a club description','fti.fptuhcm@gmail.com','0128075991','anhnhnse141030@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FCode','2016-1-25','This is a club description','fcode.fptuhcm@gmail.com','09343484912','taintse151333@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('SiTi Group','2016-1-25','This is a club description','sitigroup.fptuhcm@gmail.com','0528265622','nhinyse177341@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Football Club','2016-1-25','This is a club description','ffc.fptuhcm@gmail.com','0528010493','tritqse149416@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FStyle Hip-hop Club','2016-1-25','This is a club description','fstylefptu.fptuhcm@gmail.com','0476105497','tunhse166531@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('F# LIVE MUSIC CLUB','2016-1-25','This is a club description','fsharp.fptuhcm@gmail.com','05328284292','truclhss159414@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Volleyball Club','2016-1-25','This is a club description','fvb.fptuhcm@gmail.com','0228015492','conglktse140432@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Japan Style Club','2016-1-25','This is a club description','jsc.fptuhcm@gmail.com','0521060642','maithsa171010@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Information Assurance','2016-1-25','This is a club description','fia.fptuhcm@gmail.com','0343322344','trungtlhde161203@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPTU Public Speaking','2016-1-25','This is a club description','fps.fptuhcm@gmail.com','0232151194','tienlttss151220@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Art and Culture','2016-1-25','This is a club description','fac.fptuhcm@gmail.com','0528665682','uyentlpse171664@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Unity Dance Crew','2016-1-25','This is a club description','udcsg.fpt@gmail.com','0102180895','ngocdhss153363@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Board Games','2016-1-25','This is a club description','fbghcm.fpuhcm@gmail.com','0242115591','lamnpds144176@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Developer Student Club','2016-1-25','This is a club description','dsc.fptu.hcmc@gmail.com','0528661694','anltse151328@fpt.edu.vn')

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

	INSERT INTO tblCatetories(catetoryName) VALUES ('Seminar')
	INSERT INTO tblCatetories(catetoryName) VALUES ('Entertainment Event')
	INSERT INTO tblCatetories(catetoryName) VALUES ('Learning Event')
	
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (300,'Vừa khởi tạo')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (400,'Đã bị hủy')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (500,'Sắp diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (530,'Đã hết chỗ')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (550,'Đang diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (570,'Đã diễn ra')


	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',10,10,20,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',20,15,10,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',25,15,15,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',30,10,20,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',35,20,10,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',40,30,20,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('title',45,25,15,300,'2021-10-14','2021/10/17 07:30:00','2021-10-21 12:10:30',100,5,'content',0)



	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (20, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (30, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (70, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (40, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (25, 'anltse151328@fpt.edu.vn', '2021-10-6')
	INSERT INTO tblEventRegisters(eventID, userEmail, registerDate) VALUES (55, 'anltse151328@fpt.edu.vn', '2021-10-6')

	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (25, 'huongvqss1710948@fpt.edu.vn','2021-10-06')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (25, 'chitthse161164@fpt.edu.vn','2021-10-06')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (25, 'duylcnss136201@fpt.edu.vn','2021-10-06')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (25, 'thaocbsa131164@fpt.edu.vn','2021-10-06')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (25, 'nhinyse177341@fpt.edu.vn','2021-10-06')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (25, 'trungtlhde161203@fpt.edu.vn','2021-10-06')
	INSERT INTO tblEventRegisters(eventID,userEmail,registerDate) VALUES (25, 'thanhldse171878@fpt.edu.vn','2021-10-06')

	update tblUsers set roleID = 4 where userEmail = 'anltse151328@fpt.edu.vn'
	delete from tblUsers where userEmail = 'baonngse150655@fpt.edu.vn'

	select * from tblClubDetails


	SELECT * FROM tblEventRegisters 
<<<<<<< HEAD
	SELECT TOP 4 * FROM tblFUEvents 
	WHERE statusID in (300 , 500, 550) and startDate >= getdate()
	ORDER BY startDate ASC
=======
	SELECT * FROM tblFUEvents 

	WHERE statusID in (300 , 450, 500)
>>>>>>> c3dcc5738746670197bcd220f9275a0f58dfa654

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