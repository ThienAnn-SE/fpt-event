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
	locationID			integer			primary key,
	locationName		nvarchar(30)	not null,
	locationCapacity	integer			not null
)

create table tblCatetories(
	catetoryID		integer				primary key,
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
	startDate		date			not null,
	endDate			date			not null,
	avgVote			float			not null,
	imageURL		varchar(max),
	content			ntext			not null,
	fee				bit				not null
	)

create table tblFollowed(
	followID		integer			identity(10,5)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers
)

create table tblLiked(
	likeID			integer			identity(10,5)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers
)

create table tblEventRegisters(
	registerID		integer			identity(10,5)	primary key,
	eventID			integer			foreign key references tblFUEvents,
	userEmail		varchar(30)		foreign key references tblUsers,
	registerDate	date			not null
	)

create table tblFeedbacks(
	feedbackID		integer			identity(10,5)	primary key,
	eventID			integer			foreign key references tblEventRegisters,
	feedback		ntext			not null,
	vote			float			not null	check (vote >= 0)
	)

create table tblPayments(
	paymentID			integer			identity(10,5)	primary key,
	eventID				integer			foreign key references tblEventRegisters,
	userEmail			varchar(30)		foreign key references tblUsers,
	statusDescription	varchar(30)		not null,
	paymentDate			date			not null,
	paymentDetail		text			not null
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

	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Bussiness Economics Club','2018-7-20','This is a club description','bec.club.contact@gmail.com','0728665912','duytlse140800@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Multimedia & Entertainment Club','2016-5-11','This is a club description','mec.club.contact@gmail.com','0528761091','thaocbsa131164@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('Information Assurance Club','2019-5-20','This is a club description','iac.club.contact@gmail.com','0728775112','thinhldse141665@fpt.edu.vn')
	INSERT INTO tblClubDetails(clubName, createDate, clubDescription, clubEmail, clubPhoneNumber, userEmail) VALUES ('FPT Event Club','2016-1-25','This is a club description','fev.club.contact@gmail.com','0931229051','duchtsa134114@fpt.edu.vn')


	INSERT INTO tblLocations(locationID,locationName,locationCapacity) VALUES (10,'Semina', 40)
	INSERT INTO tblLocations(locationID,locationName,locationCapacity) VALUES (15,'Hall A', 250)
	INSERT INTO tblLocations(locationID,locationName,locationCapacity) VALUES (20,'Hall B', 150)
	INSERT INTO tblLocations(locationID,locationName,locationCapacity) VALUES (25,'Floor 3_Library',100)

	INSERT INTO tblCatetories(catetoryName) VALUES ('Seminar')
	INSERT INTO tblCatetories(catetoryName) VALUES ('Entertainment Event')
	INSERT INTO tblCatetories(catetoryName) VALUES ('Learning Event')

	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (300,'Vừa khởi tạo')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (500,'Sắp diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (530,'Đang diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (550,'Đã diễn ra')
	INSERT INTO tblEventStatuses(statusID,statusDescription ) VALUES (400,'Đã bị hủy')


	INSERT INTO tblFUEvents (eventName, clubID, locationID, catetoryID, statusID, createDate, startDate, endDate, avgVote, content, fee) VALUES ('A',5,5,5,5,'9-10-2021','10-10-2021','11-11-2021',5,'none',1)