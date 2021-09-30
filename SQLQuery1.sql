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
	clubID				integer				primary key,
	clubName			nvarchar(30)		not null	unique,
	createDate			date				not null,
	clubDescription		ntext				not null,
	clubEmail			varchar(30),
	clubPhoneNumber		varchar(15)			unique,
	userEmail			varchar(30)			foreign key references	tblUsers
	)

create table tblEventStatuses(
	statusID			integer			primary key,
	statusDescriptin	nvarchar(30)	not null
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