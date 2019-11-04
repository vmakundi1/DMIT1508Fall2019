--Use the Memories Forever database for this exercise.The current solution has the script to create it if you have not competed the create tables exercise.--
--If an insert fails write a brief explanation why. Do not just quote the error message genereated by the server!--

--1. Add the following records into the ItemType Table:--
--ItemTypeID	ItemTypeDescription--
--1	Camera--
--2	Lights--
--3 	Stand--
--2	Backdrop--
--89899985225	Outfit--
--4A	Other--

Insert into itemType (ItemTypeID,ItemTypeDescription)
values (1,'Camera')

Insert into itemType (ItemTypeID,ItemTypeDescription)
values (2,'Lights')

Insert into itemType (ItemTypeID,ItemTypeDescription)
values (3,'Stand')

Insert into itemType (ItemTypeID,ItemTypeDescription)
values (2,'backdrop')
--duplicate primary key value so insert fails

Insert into itemType (ItemTypeID,ItemTypeDescription)
values (89899985225,'outfit')
--ItemTypeId is larger than the int datatype for that field

Insert into itemType (ItemTypeID,ItemTypeDescription)
values ('4A','Other')
--4A is a string and the ItemTypeID is an integer field
go



--2. Add the following records into the Item Table:--
--ItemID	ItemDescription	PricePerDay	ItemTypeID--
--	Canon G2	25	1--
--	100W tungston	18	2--
--	Super Flash	25	4--
--	Canon EOS20D	30	1--
--5	HP 630	25	1--
--	Light Holdomatic	22	3--
Insert into Item (ItemDescription,PricePerDay,ItemTypeID)
values ('Canon G2',25,1)

Insert into Item (ItemDescription,PricePerDay,ItemTypeID)
values ('100W tungston',18,2)

Insert into Item (ItemDescription,PricePerDay,ItemTypeID)
values ('Super flash',25,4)
--Insert fails because the ItemTypeId (4) does not have a matching parent value in the relationship
Insert into Item (ItemDescription,PricePerDay,ItemTypeID)
values ('Canon EOS20D',30,1)
select * from item
Insert into Item (ItemID, ItemDescription,PricePerDay,ItemTypeID)
values (5,'HP 630',25,1)
--ItemId is an identity field and as such is populated by the server not the user.

Insert into Item (ItemDescription,PricePerDay,ItemTypeID)
values( 'Holdomatic',22,3)


go
			


--3.  Add the following records into the StaffType Table:--
--StaffTypeID	StaffTypeDescription--
--1	Videographer--
--2	Photographer--
--1	Mixer--
-- 	Sales--
--3	Sales--
Insert into StaffType (StaffTypeID,StaffTypeDescription)
values (1,'Videographer')


Insert into StaffType (StaffTypeID,StaffTypeDescription)
values (2,'Photographer')


Insert into StaffType (StaffTypeID,StaffTypeDescription)
values (1,'Mixer')
--duplicate primary key value so insert fails

Insert into StaffType (StaffTypeDescription)
values ('Sales')
--Did not provide a value for the StaffTypeID field which is a not null field


Insert into StaffType (StafftypeID,StaffTypeDescription)
values (3, 'Sales')

go
	
	


--4.  Add the following records into the Staff Table:--
--StaffID	StaffFirstName	StaffLastName	Phone	Wage	HireDate	StaffTypeID--
--1	Joe	Cool	5551223212	23	Jan 1 2007	1--
--1	Joe	Cool	5551223212	23	Apr 2 2020	1--
--2	Sue	Photo	5556676612	15	Apr 2 2020	3--
--3	Jason	Pic	3332342123	23	Apr 2 2020	2--
go
Insert into Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
values (1, 'Joe','Cool','5551223212',23,'Jan 1 2007',1)
--Check constraint on the table says that the hire date must be greater than or equal to todays date

Insert into Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
values (1, 'Joe','Cool','5551223212',23,'Apr 2 2020',1)

Insert into Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
values (2, 'Susan','Photo','5556676612',15,'Apr 2 2020',3)


Insert into Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
Values (3, 'Jason','Pic','3332342123',
23,'Apr 2 2020',2)
						
select * from itemtype
select * from item
select * from stafftype
select * from staff
