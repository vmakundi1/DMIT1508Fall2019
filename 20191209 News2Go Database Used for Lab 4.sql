/******IMPORTANT NOTE!****
IF YOU RUN THIS SCRIPT MORE THAN ONCE YOU MUST DROP AND RECREATE YOUR TABLES BEFORE RUNNING
IT AGAIN IN ORDER TO RESET THE IDENTITY PROPERTIES. ONCE ROWS HAVE BEEN ENTERED IN THE TABLES THROUGH THESE INSERT STATEMENTS YOU 
CANNOT RUN THIS SCRIPT AGAIN WITHOUT DROPPING YOUR TABLES FIRST.
*/

create database News2Go
go

Drop Table CustomerPaper
Drop Table Paper
Drop Table DeliveryType
Drop Table Customer
Drop Table Route
Drop Table Region
Drop Table DropSite
Drop Table Carrier
Drop Table Zone


Create Table Carrier 
(
	CarrierID int identity (1,1) not null
	Constraint PK_Carrier primary key clustered,		
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Phone char(10) not null
	Constraint ck_Phone check (Phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

Create Table DropSite
(
	DropSiteId int not null
	Constraint PK_DropSite primary key clustered,
	Name varchar(50) not null,
	Address varchar(30) not null,
	City varchar(30) not null
)

Create Table Zone
(
	ZoneID int identity (1,1) not null
	Constraint PK_Zone primary key clustered,
	Name varchar(50) not null,
	ManagerFirstName varchar(30) not null,
	ManagerLastName varchar(30) not null,
	CellNumber char(10) not null
	Constraint ck_CellNumber check (CellNumber like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') ,
	Wage smallmoney not null
)

Create Table Region
(
	RegionID int not null
	Constraint PK_Region primary key clustered,
	Name varchar(50) not null,
	SupervisorFirstName varchar(30) not null,
	SupervisorLastName varchar(30) not null,
	ZoneID int not null
	constraint fk_RegionToZone references Zone(ZoneID)
)

Create Table Route 
(
	RouteID int not null
	Constraint PK_Route primary key clustered,
	Name varchar(50) not null,
	RegionID int not null
	Constraint FK_RouteToRegion
	references Region (RegionID),
	DropSiteID int not null
	Constraint FK_RouteToDropSite
	references DropSite (DropSiteID),
	CarrierId int not null
	Constraint FK_RouteToCarrier
	references Carrier (CarrierId)
)

Create Table Customer
(
	CustomerID int not null
	Constraint PK_Customer primary key clustered,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Address varchar(50) not null,
	City varchar(30) not null,
	Province char(2) not null
	Constraint ck_CustomerProvince check (Province Like '[A-Z][A-Z]')
	Constraint DF_CustomerProvince Default 'AB',
	PC char(7) not null
	Constraint CK_CustomerPostalCode 
	Check (PC Like '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'),
	PrePaidTip smallmoney not null
	Constraint ck_prepaidtip check (PrepaidTip >=0)
	Constraint DF_PrepaidTip Default 0,
	RouteID int not null
	Constraint FK_CustomerToRoute
	references Route(RouteID)
)



Create Table DeliveryType 
(
	DeliveryTypeID smallint not null
	Constraint PK_DelieverType primary key clustered,
	Description varchar(10) not null,
	Charge smallmoney not null
)

Create Table Paper
(
	PaperId smallint identity (1,1) not null
	Constraint PK_Paper primary key clustered, 
	Description varchar(30) not null
)

Create Table CustomerPaper 
(
	CustomerID int not null
	Constraint FK_CustomerPaperToCustomer
	references Customer (CustomerId),
	PaperID smallint not null
	Constraint FK_CustomerPaperToPaper
	references Paper (PaperId),
	DeliveryTypeID smallint not null
	Constraint FK_CustomerPaperToDeliveryType
	references DeliveryType (DeliveryTypeId),
	Constraint	PK_CustomerPaper_CustomerID_PaperID primary key clustered
	(CustomerID, PaperID)
)
go
--Alter Table

Alter Table Carrier
	Add Active char(1) null
	Constraint CK_Active
	Check (Active like 'Y' or Active like 'N')
	
Alter Table Carrier
Add
	EmailAddress varchar(50) null

--Create indexes for all foregin keys

Create nonclustered index IX_Route_CarrierID
	on Route(CarrierID)

Create nonclustered index IX_Route_DropSiteID
	on Route(DropSiteID)

Create nonclustered index IX_Route_RegionID
	on Route(RegionID)

Create nonclustered index IX_CustomerPaper_CustomerID
	on CustomerPaper(CustomerID)

Create nonclustered index IX_CustomerPaper_PaperID
	on CustomerPaper(PaperID)

Create nonclustered index IX_CustomerPaper_DeliveryTypeID
	on CustomerPaper(DeliveryTypeID)

Create nonclustered index IX_Customer_RouteID
	on Customer(RouteID)
	
Create nonclustered index IX_Region_ZoneID
	on Region(ZoneID)








go

--Paper Table
Insert into paper(Description)
Values
('Journal'),
('Sun'),
('National Post'),
('Globe and Mail')

--Carrier Table
Insert into carrier(FirstName,LastName,Phone)
values('Bub','Slug','5551245454'),
('Betty','Rubble','5558372716'),
('Luke','Skywalker','5558881212'),
('Princess','Leia','5558881212'),
('Bob','Barker','5558881212'),
('Rob','Tomlinson','5558881212')


--Zone Table
Insert into Zone(Name,ManagerFirstName, ManagerLastName, CellNumber,wage)
Values
('North-East','Homer', 'Simpson','5551222544',20),
('South-East','Marge', 'Simpson','8787772918',22),
('Central','Lisa', 'Simpson','8889727272',28),
('North-West','Bart', 'Simpson','8887371777',26)

--Region Table
Insert into Region (RegionID, Name, SupervisorFirstName,SupervisorLastName, ZoneID)
values 
(100,'Edmonton','Joni','Jones',1),
(200,'Sherwood Park','John','Jacobs',2),
(300,'St. Albert','Heather','Hollack',4)


--Drop Site Table
Insert into DropSite(DropSiteID, Name, Address,City)
Values
(10, 'Sherwood Park Mall','12232 Sherwood Drive','Sherwood Park'),
(20, 'West Edmonton Mall','11213 170 Street','Edmonton'),
(30, 'DownTown Library','10333 103 Street','Edmonton')

--Route Table
Insert into Route (RouteID, Name, RegionID, DropSiteID,Carrierid)
values
(1,'Riverbend',100,20,1),
(5,'Mills Haven',200,20,1),
(10,'North St.Albert',300,10,3),
(20,'Millwoods',100,20,2)

--customer table
Insert into Customer (CustomerID,FirstName, LastName, Address, City, Province, PC, PrePaidTip, RouteID)
Values(1,'Jone', 'Simpson', '13312 121 street','Edmonton','AB','T3J 1J2',90,1),
(2,'Lisa', 'Jones', '16512 122 street','Edmonton','AB','T3J 1J2',55,20),
(3,'George', 'Forman', '63271 44 Avenue','St. Albert','AB','T1J 4J6',20,10),
(4,'Rob', 'smilie', '13312 121 street','Sherwood Park','AB','T3J 1J2',10,5),
(5,'Cyndi', 'Lauper', '13312 121 street','Sherwood Park','AB','T3J 1J2',10,5),
(6,'Bob', 'Marley', '13312 121 street','Edmonton','AB','T3J 1J2',95,1),
(7,'Elvis', 'Presely', '13312 121 street','Edmonton','AB','T3J 1J2',15,1),
(8,'Eric', 'Clapton', '13312 121 street','Sherwood Park','AB','T3J 1J2',75,5),
(9,'Dennis', 'Johnson', '13312 121 street','St. Albert','AB','T3J 1J2',45,10),
(10,'James', 'Douglas', '13312 121 street','Edmonton','AB','T3J 1J2',20,20),
(11,'Jay', 'Leno', '13312 121 street','Edmonton','AB','T3J 1J2',1,1),
(12,'Ethan', 'Little', '13312 121 street','Edmonton','AB','T3J 1J2',5,1),
(13,'Nathan', 'Tyler', '13312 121 street','Sherwood Park','AB','T3J 1J2',0,5),
(14,'Susan', 'McDonald', '13312 121 street','St. Albert','AB','T3J 1J2',0,10),
(15,'Betty', 'Carlson', '13312 121 street','Edmonton','AB','T3J 1J2',0,20)


--DeliveryType Table
Insert into DeliveryType (DeliveryTypeID, Description, Charge)
values
(1,'Daily',7.00),
(2,'FriSatSun',2.50),
(3,'Saturday',1.50),
(4,'Sunday',1.50)


--CustomerPaper Table
Insert into CustomerPaper (CustomerID,PaperID, DeliveryTypeID)
values(1,1,2),
(1,2,4),
(2,1,1),
(3,1,1),
(1,4,1),
(4,1,2),
(5,1,2),
(6,1,2),
(7,3,2),
(8,1,2),
(9,3,2),
(10,1,1),
(11,1,1),
(12,1,1),
(13,1,1),
(14,1,1),
(15,1,1),
(10,2,1),
(13,2,1),
(11,3,1),
(10,4,1)

Select * from Paper
Select * from carrier
Select * from zone
Select * from region
Select * from dropsite
Select * from route
Select * from customer
Select * from deliverytype
Select * from customerPaper
