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
	userName	 nvarchar(50)		unique,
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
	eventID			integer			identity(10,5)	primary key,
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
	followID		integer			identity(10,5)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers,
	constraint	UC_tblFollowed	unique (eventID, userEmail)
)

create table tblLiked(
	likeID			integer			identity(10,5)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers,
	constraint	UC_tblLiked	unique (eventID, userEmail)
)

create table tblEventRegisters(
	registerID			integer			identity(10,5)	primary key,
	eventID				integer			foreign key references tblFUEvents,
	userEmail			varchar(30)		foreign key references tblUsers,
	registerDate		date			not null,
	constraint	UC_tblEventRegister unique (eventID, userEmail)
	)

create table tblFeedbacks(
	feedbackID		integer			identity(10,5)	primary key,
	registerID		integer			foreign key references tblEventRegisters,
	feedback		ntext			not null,
	vote			float			not null	check (vote >= 0)
	)

create table tblPayments(
	paymentID			integer			identity(10,5)	primary key,
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

	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trungtlhde161203@fpt.edu.vn','Trần Lê Hiếu Trung','2002-5-26',1,'0343322344',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duchtsa134114@fpt.edu.vn','Hoàng Trọng Đức','1999-10-30',1,'01217398138',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phunghnsa145238@fpt.edu.vn','Huỳnh Ngọc Phúc','2000-12-25',0,'0341312318',1,400)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhhnsa145050@fpt.edu.vn','Huỳnh Ngọc Ánh','2000-1-17',0,'0343322314',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thaocbsa131164@fpt.edu.vn','Châu Bội Thảo','1999-2-14',1,'0943221274',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('luathngsa147121@fpt.edu.vn','Hoàng Ngọc Gia Luật','2000-10-3',1,'0347382324',1,400)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('phucntse136225@fpt.edu.vn','Nguyễn Thục Phúc','1999-1-30',1,'01219447289',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thinhldse141665@fpt.edu.vn','Lý Đoàn Thịnh','2000-5-11',1,'0343322354',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duytlse140800@fpt.edu.vn','Trương Lý Duy','2000-3-29',1,'01218901720',4,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('duylcnss136201@fpt.edu.vn','Lý Ngọc Cường Duy','1999-7-27',1,'01213984992',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mydvse151451@fpt.edu.vn','Đường Vỹ My','2001-4-21',1,'02213984192',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('anhlhbse153142@fpt.edu.vn','Lý Hoàng Bá Ánh','2001-4-30',1,'09343984992',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('taintse151333@fpt.edu.vn','Nguyễn Trương Tài','2000-5-1',1,'09343484912',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('chitthse161164@fpt.edu.vn','Trương Thị Huỳnh Chi','2001-12-3',0,'02343383952',1,300)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('vyndhss151512@fpt.edu.vn','Nguyễn Đặng Huỳnh Vỹ','2001-1-28',1,'08342284292',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('truclhss159414@fpt.edu.vn','Lý Hoàng Trúc','2001-7-9',0,'05328284292',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('uyentlpse171664@fpt.edu.vn','Trương Lý Phụng Uyên','2003-11-11',0,'0528665682',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('nhinyse177341@fpt.edu.vn','Nguyễn Yến Nhi','2003-2-16',0,'0528265622',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('thanhldse171878@fpt.edu.vn','Lý Dương Thành','2003-6-11',1,'0528065692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('mynlhss172290@fpt.edu.vn','Nguyễn Lý Huyền My','2003-8-22',0,'0928115692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('trangntmss171002@fpt.edu.vn','Ngọc Trương Minh Trang','2003-9-26',0,'0528165692',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('diemtbsa170121@fpt.edu.vn','Trần Bích Diễm','2003-9-1',0,'0523015690',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('maithsa171010@fpt.edu.vn','Trương Huyền Mai','2003-12-4',0,'0521060642',1,500)
	INSERT INTO tblUsers(userEmail,userName, dateOfBirth, gender, phoneNumber, roleID, statusID) VALUES ('huongvqss1710948@fpt.edu.vn','Vương Quốc Hương','2003-3-7',1,'0328005491',1,500)

	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Bussiness Economics Club','2018-7-20','This is a club description','bec.fptuhcm@gmail.com','0728665912','duytlse140800@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Multimedia & Entertainment Club','2016-5-11','This is a club description','mec.fptuhcm@gmail.com','0528761091','thaocbsa131164@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Cóc Sài Gòn','2019-5-20','This is a club description','csg.fptuhcm@gmail.com','0728775112','thinhldse141665@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Event Club','2016-1-25','This is a club description','fev.fptuhcm@gmail.com','0931229051','duchtsa134114@fpt.edu.vn')


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
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (500,'Sắp diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (530,'Đang diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (550,'Đã diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (400,'Đã bị hủy')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (450,'Đã hết chỗ')


	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, slot, avgVote, content, ticketFee) VALUES ('I',10,10,10,300,'2021-10-5','2021/10/7 08:30:00','2021-10-7 09:10:30',100,5,'none',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, ticketFee) VALUES ('B',10,10,10,500,'2021-10-5','2021-11-12','2021-11-30',5,'none',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, ticketFee) VALUES ('C',10,10,10,300,'2021-10-5','2021-11-13','2021-11-30',5,'none',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, ticketFee) VALUES ('D',10,10,10,500,'2021-10-5','2021-11-14','2021-11-30',5,'none',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, ticketFee) VALUES ('E',10,10,10,450,'2021-10-5','2021-11-15','2021-11-30',5,'none',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, ticketFee) VALUES ('F',10,10,10,530,'2021-10-5','2021-11-12','2021-11-30',5,'none',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, ticketFee) VALUES ('G',10,10,10,500,'2021-10-5','2021-11-11','2021-11-30',5,'none',0)
	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, ticketFee) VALUES ('H',10,10,10,400,'2021-10-5','2021-11-21','2021-11-30',5,'none',0)

	SELECT * FROM tblFUEvents

	SELECT TOP 3 * FROM tblFUEvents
	WHERE statusID = 500
	ORDER BY startDate ASC

	SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY eventID ASC) AS rn, * FROM tblFUEvents) AS b
	LEFT JOIN tblCatetories on b.catetoryID = tblCatetories.catetoryID
	WHERE (rn >= (1*7-6) AND rn <= (1*7)) AND tblCatetories.catetoryID = 10 AND (statusID = 500 OR statusID = 300)
	ORDER BY startDate ASC
	 
	SELECT * FROM tblFUEvents
	WHERE startDate >= '2021-11-11' AND endDate <= '2021-11-11'
	
	SELECT eventID, startDate, endDate
	FROM tblFUEvents
	WHERE statusID != 400
	ORDER BY startDate ASC