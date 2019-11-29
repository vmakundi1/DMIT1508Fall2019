--VICTOR MAKUNDI 36/37

--Question 1--
--Write a stored procedure called AddCarrier that accepts a carrier first name, last name
--and phone number. If the carrier name being added is already in the Carrier table give an
--appropriate error message. Otherwise, add the new carrier to the Carrier table and select
--the new Carrier ID. 
--mark: 2+1+1+1
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
go

--QUESTION 2--
--Write a stored procedure called UpdateZone that accepts the Zone ID, manager last
--name, manager first name, wage, and cell number. Raise an error message if that zone is 
--not in the zone table. Otherwise, update the record for that zone. 
-- mark 1+1+1+1
create Procedure UpdateZone (@ZoneID int = null, @ManagerLastName varchar(30) = null, @ManagerFirstName varchar(30) = null, @Wage smallmoney = null, @CellNumber char(10) = null)
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


go

--QUESTION 3--
--Write a stored procedure called DeleteDropSite that accepts a DropSiteID. If that drop 
--site is not in the drop site table, raise an appropriate error message. If there are routes
--with that DropSite, raise an appropriate error message. If there are no errors, delete the 
--record from the DropSite table. 			

--mark 1+1+1+1+1
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
						if exists (select * from DropSite join Route on DropSite.DropSiteID = Route.DropSiteID where Route.DropsiteID = @DropSiteID)
					

							begin
							Raiserror ('You cannot delete this dropsite', 16, 1)
						    end

						    else
							begin
								delete DropSite where DropSiteID = @DropSiteID
								if @@ERROR <> 0
										begin
										Raiserror ('Delete failed', 16, 1)
										end

							End
					End
			End
go


--QUESTION 4--
--4.	Write a stored procedure called LookUpZoneRegionCarrier that accepts a Zone ID. If the 
--Zone ID is not valid raise an appropriate error message, otherwise return all the Zone
--Manager full names (as one column), RegionNames , RouteNames, and Carriers full 
--names (as one column) that are related to that Zone
--marks 1+1+1+1
create procedure LookUpZoneRegionCarrier (@ZoneID int = null)
as
if @ZoneID is null
		begin
		raiserror ('Must provide a ZoneID', 16, 1)
		end
else
		begin
		if not exists (select ZoneID from Zone where ZoneID = @ZoneID)
				begin 
				raiserror ('ZoneID does not exist', 16, 1)
				end
		else
				begin
				select ManagerFirstName + ' ' + ManagerLastName as 'Manager Full Name', Region.Name + ' '+ Route.Name + ' ' + Carrier.FirstName + ' ' + Carrier.LastName as 'Area they Manage' from Zone
				join Region on Zone.ZoneID = Region.ZoneID
				join Route on Region.RegionID = Route.RegionID
				join Carrier on Route.CarrierID = Carrier.CarrierID
				where Zone.ZoneID = @ZoneID
				return
				end
		End

go




 


--QUESTION 5--
--write a stored procedure called NoPapers that returns the Customer First name, LastName
--and postal code of all the customers that are not currently receiving any papers. Do not use a join
--mark 2
create procedure NoPapers  --1
as
select FirstName, LastName, PC from Customer
where CustomerID not in (select CustomerID from CustomerPaper) --1
return
end

go

--QUESTION 6--
--write a stored procedure called LookUpCustomer that accepts any part of a customer's last name.
--Returns all the customer data for those customers from the customer table.

--mark 2
alter Procedure LookUpCustomer (@LastName varchar(30) = null)  --1
as
if @LastName is null
		Begin
		Raiserror ('Must provide customer last name', 16, 1)
		End
else
		Begin
		select FirstName, LastName, Address, City, Province, PC, PrePaidTip, RouteID from Customer where LastName like '%'+@LastName+'%' --1
		end
		go




--QUESTION 7--
--Write a procedure called TransferRegion that accepts a RegionID and a ZoneID. The procedure will transfer
--a particular region from one zone to another. when the region is transferred, the old zone manager wil have $1 subtracted
--from their wage and the new zone manager wull have $1.00 added to their wage. Raise an appropriate error
--message if the region transferred does not exist. Ensure all the necessary tables are updated as required

--mark 9  (didnt write commit transaction on final part)
create procedure TransferRegion (@RegionID int = null, @ZoneID int = null)

as
if @RegionID is null or @ZoneID is null
		Begin
		Raiserror ('Must provide both RegionID & ZoneID', 16, 1)
		End
Else
		Begin
			if not exists (select RegionID from Region where RegionID = @RegionID) --1
				Raiserror ('Region does not exist', 16, 1)
			else
				begin

					Declare @CurrentZoneManagerID int
					select @CurrentZoneManagerID = zoneid from Region where RegionID = @RegionID--1
					--Update the Region set zoneID=@ZoneID   where regionID=@regionID
					Begin transaction                                                        --1
					Update Region                                                         --1
					Set ZoneID = @ZoneID
					where RegionID = @RegionID
					if @@ERROR <> 0                                                     --1
							begin
								Raiserror('Transfer failed', 16, 1)
							end

					else
						begin
						---update wage
						Update Zone                            --1
						Set Wage = Wage - 1
						where ZoneID = @CurrentZoneManagerID
						if @@ERROR <> 0                        --1
								begin
									Raiserror('Update of manager to be transferred failed', 16, 1)
								end
						else
							begin
							--update wage again to where the transfer is going
							Update Zone                    --1
							Set Wage = Wage + 1           
							where ZoneID = @ZoneID
							if @@ERROR <> 0
									begin
										Raiserror('Update of manager wage failed', 16,1)
										Rollback Transaction                         --1
									end
							end

						end
							
				end
		End





go
--QUESTION 8--
--Write a stored procedure called RewardZones that will accept a number representing the
--expected number of regions each Zone should have. Think of it as a performance target 
--that each Zone Manager should meet. Update the wage by 10% for all Zone Managers 
--that have more than that number of regions.

--mark 1+3+1
create procedure RewardZones (@PerformanceTarget  int = null)    --1
as
if @PerformanceTarget is null
			begin
			raiserror ('Please enter a number', 16, 1)
			end
else
			begin
			Update Zone                --3
			Set Wage = Wage * 1.1
			where Zone.ZoneID =  (select Zone.ZoneID from Zone join Region on Zone.ZoneID = Region.ZoneID
			group by Zone.ZoneID
			having count(RegionID)>=@PerformanceTarget)
				if  @@ERROR<>0                      --1
					begin
						raiserror('update failed',16,1)
					end
				else
					begin
						print('NO ZONE MEETS THE TARGET')
					end
			end
