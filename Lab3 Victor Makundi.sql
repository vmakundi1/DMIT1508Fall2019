--VICTOR MAKUNDI LAB 3, DMIT1508 DATABASE FUNDAMENTALS
--1--

create Procedure AddCarrier (@FirstName varchar(30) = null, @LastName varchar(30) = null, @Phone char(10) = null)
as
If @FirstName is null or @LastName is null
	Begin
	RaisError ('Must provide First and Last Name',16,1)
	end
else 
    Begin 
	    if exists (select FirstName, LastName from Carrier
		           where FirstName = @FirstName AND LastName = @LastName)
				   Begin
						Raiserror ('That carrier already exists', 16, 1)
				   end
		else
			Begin
				Insert into Carrier (FirstName,LastName, Phone)
				values (@FirstName,@LastName, @Phone)
				end
			If @@ERROR <>0
				Begin
				RaisError ('insert failed!',16,1)
				end
			else
				Begin
				select @@IDENTITY
				End
end

exec AddCarrier

--2--



