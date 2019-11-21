--VICTOR MAKUNDI LAB 3, DMIT1508 DATABASE FUNDAMENTALS
--1--
Create Procedure AddCarrier (@FirstName varchar(30) = null, @LastName varchar(30) = null, @Phone char(10) = null)
as
if @FirstName is null or @LastName is null
       Begin
			Raiserror ('Must provide First Name and Last Name', 16, 1)
	   End
else
		Begin
			if exists  (select FirstName, LastName
						from Carrier 
						where FirstName = @FirstName or LastName = @LastName)
						Begin
							Raiserror ('That carrier already exists', 16, 1)
						End
		End
Return