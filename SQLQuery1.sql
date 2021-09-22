create database [FU-Event]
go

use [FU-Event]
go

create table tblRoles(
	roleID   integer primary key,
	roleName nvarchar(30) not null
)

create table tblUserStatuses(
	statusID			integer		primary key,
	statusDescription	nvarchar	not null,
)

create table tblUsers(
	userEmail	 varchar(30)	primary key,
	userName	 nvarchar(50)	not null,
	dateOfBirth	 date			not null,
	gender		 bit			not null,
	phoneNumber  varchar(15)		not null	unique,
	roleID		 integer		not null	foreign key references tblRoles,
	statusID	 integer		not null	foreign key references tblUserStatuses
)

create table tblLocations(
	locationID			integer		primary key,
	locationName		nvarchar	not null,
	locationCapacity	integer		not null
)

create table tblCatetories(
	catetoryID		integer		primary key,
	catetoryName	nvarchar	not null
)

create table tblClubDetails(
	clubID				integer			primary key,
	clubName			nvarchar		not null	unique,
	createDate			date			not null,
	clubDescription		ntext			not null,
	clubEmail			varchar,
	clubPhoneNumber		varchar(15)		unique,
	userEmail			varchar(30)		foreign key references	tblUsers
	)
	
create table tblFUEvents(
	eventID			integer			primary key,
	eventName		nvarchar(50)	not null	unique,
	clubID			integer			not null	foreign key references tblClubDetails,
	locationID		integer			not null	foreign key references tblLocations,
	catetoryID		integer			not null	foreign key	references tblCatetories,
	createDate		date			not null,
	startDate		date			not null,
	endDate			date			not null,
	avgVote			float			not null,
	imageURL		varchar,
	content			ntext			not null,
	fee				bit				not null,
	totalFollowers	integer			not null	check (totalFollowers >= 0)
	)

create table tblEventRegisters(
	registerID		integer			primary key,
	eventID			integer			not null	foreign key references tblFUEvents,
	userEmail		varchar(30)		not null	foreign key references tblUsers,
	registerDate	date			not null
	)

create table tblFeedbacks(
	feedbackID		integer			primary key,
	eventID			integer			foreign key references tblEventRegisters,
	userEmail		varchar(30)		foreign key references tblUsers,
	feedback		ntext			not null,
	vote			float			not null	check (vote >= 0)
	)

create table tblPaymentStatuses(
	statusID			integer		primary key,
	statusDescription	nvarchar	
	)

create table tblPayments(
	paymentID		integer			primary key,
	eventID			integer			foreign key references tblEventRegisters,
	userEmail		varchar(30)		foreign key references tblUsers,
	statusID		integer			foreign key references tblPaymentStatuses,
	paymentDate		date			not null,
	paymentDetail	text			not null
	)