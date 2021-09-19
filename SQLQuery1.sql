create database [FU-Event]
go

use [FU-Event]
go

create table Roles(
	roleID   integer primary key,
	roleName nvarchar(30) not null
)

create table User_Statuses(
	statusID			integer		primary key,
	statusDescription	nvarchar	not null,
)

create table Users(
	userEmail	 varchar(30)	primary key,
	userName	 nvarchar(50)	not null,
	dateOfBirth	 date			not null,
	gender		 bit			not null,
	phoneNumber  varchar(15)		not null	unique,
	roleID		 integer		not null	foreign key references Roles,
	statusID	 integer		not null	foreign key references User_Statuses
)

create table Locations(
	locationID			integer		primary key,
	locationName		nvarchar	not null,
	locationCapacity	integer		not null
)

create table Catetories(
	catetoryID		integer		primary key,
	catetoryName	nvarchar	not null
)

create table Club_Details(
	clubID				integer			primary key,
	clubName			nvarchar		not null	unique,
	createDate			date			not null,
	clubDescription		ntext			not null,
	clubEmail			varchar,
	clubPhoneNumber		varchar(15)		unique,
	userEmail			varchar(30)		foreign key references	Users
	)
	
create table Club_Members(
	clubID				integer			primary key foreign key references Club_Details,
	userEmail			varchar(30)		foreign key references Users
)

create table FU_Events(
	eventID			integer			primary key,
	eventName		nvarchar(50)	not null	unique,
	clubID			integer			not null	foreign key references Club_Details,
	locationID		integer			not null	foreign key references Locations,
	catetoryID		integer			not null	foreign key	references Catetories,
	createDate		date			not null,
	startDate		date			not null,
	endDate			date			not null,
	avgVote			float			not null,
	imageURL		varchar,
	content			ntext			not null,
	fee				bit				not null,
	totalFollowers	integer			not null	check (totalFollowers >= 0)
	)

create table EventRegisters(
	registerID		integer			primary key,
	eventID			integer			not null	foreign key references FU_Events,
	userEmail		varchar(30)		not null	foreign key references Users,
	registerDate	date			not null
	)

create table Feedbacks(
	feedbackID		integer			primary key,
	eventID			integer			foreign key references EventRegisters,
	userEmail		varchar(30)		foreign key references Users,
	feedback		ntext			not null,
	vote			float			not null	check (vote >= 0)
	)

create table Payment_Statuses(
	statusID			integer		primary key,
	statusDescription	nvarchar	
	)

create table Payments(
	paymentID		integer			primary key,
	eventID			integer			foreign key references EventRegisters,
	userEmail		varchar(30)		foreign key references Users,
	statusID		integer			foreign key references Payment_Statuses,
	paymentDate		date			not null,
	paymentDetail	text			not null
	)