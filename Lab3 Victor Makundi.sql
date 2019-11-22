--VICTOR MAKUNDI LAB 3, DMIT1508 DATABASE FUNDAMENTALS
--Question 1--

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

--Question 2--

Create Procedure UpdateZone (@ZoneID int = null, @Name varchar(50) = null, @ManagerFirstName varchar(30) = null, @ManagerLastName varchar(30) = null, @CellNumber char(10) = 10, @Wage smallmoney = null)
as
if @ZoneID is null or @ManagerFirstName is null or @ManagerLastName is null or @CellNumber is null or @Wage is null
	Begin
	Raiserror ('Must provide Zone ID, Manager first name, manager last name, cell number and wage', 16, 1)
	End
else
	Begin
		if not exists (select ZoneID from Zone where ZoneID = @ZoneID)
				Begin
				Raiserror ('That zone does not exist', 16, 1)
				end
		else
				Begin
				Update Zone
				set ManagerFirstName = @ManagerFirstName, ManagerLastName = @ManagerLastName, Wage=@Wage, CellNumber=@CellNumber
				where ZoneID = @ZoneID
				if @@ERROR <> 0
						Begin
						Raiserror ('Update failed!', 16, 1)
						End
				End
	End



--Question 3--
--Write a stored procedure called DeleteDropSite that accepts a DropSiteID. If that drop 
--site is not in the drop site table, raise an appropriate error message. If there are routes
--with that DropSite, raise an appropriate error message. If there are no errors, delete the 
--record from the DropSite table. 			

Create Procedure DeleteDropSite (@DropSiteID int = null)
as
if @DropSiteID is null
			Begin
			Raiserror ('Must provide a DropsiteID', 16, 1)
			End
else
			Begin
			If not exists (select DropSiteID from DropSite where DropSiteID = @DropSiteID)
					Begin
					Raiserror ('That drop site does not exist', 16, 1)
					End
			else
					Begin
					Declare @RouteCount int
					select DropSite.DropSiteID, count(RouteID) as 'number of routes' from DropSite join Route on DropSite.DropSiteID = Route.DropSiteID group by DropSite.DropSiteID
					End
			End


--Question 4--
--write a stored procedure called LookUpZoneRegionCarrier that accepts a ZoneID. 
--if the ZoneID is nt valid, raise an appropriate error message, otherwise return all the
--zone Manager full names (as one column), RegionNames, RouteNames and Carriers full names
--(as one column) that are related to that zone

--Question 5--
--write a stored procedure called NoPapers that returns the Customer First name, LastName
--and postal code of all the customers that are not currently receiving any papers. Do not use a join

create procedure NoPapers 
as
select FirstName, LastName, PC from Customer where
end




--Question 6--
--write a stored procedure called LookUpCustomer that accepts any part of a customer's last name.
--Returns all the customer data for those customers from the customer table.

Create Procedure LookUpCustomer (@LastName varchar(30) = null)
as
if @LastName is null
		Begin
		Raiserror ('Must provide customer last name', 16, 1)
		End
else
		Begin
		select FirstName, LastName, Address, City, Province, PC, PrePaidTip, RouteID from Customer
		return
		end
		go


--Question 7--
--Write a procedure called TransferRegion that accepts a RegionID and a ZoneID. The procedure will transfer
--a particular region from one zone to another. when the region is transferred, the old zone manager wil have $1 subtracted
--from their wage and the new zone manager wull have $1.00 added to their wage. Raise an appropriate error
--message if the region transferred does not exist. Ensure all the necessary tables are updated as required

create procedure TransferRegion (@RegionID int = null, ZoneID int = null)
as
if @RegionID is null or @ZoneID is null
		Begin
		Raiserror ('Must provide both RegionID & ZoneID', 16, 1)
		End
else
		Begin
		if not exists (select * from 


					


