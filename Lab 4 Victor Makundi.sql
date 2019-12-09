--VICTOR MAKUNDI (LAB 4: DMIT1508 DATABASE FUNDAMENTALS) NEWS2GO DATABASE

--QUESTION 1: Ensure that the RouteID is valid in the customer table. should an invalid RouteID-
--be entered, raise an error and do not allow the record(s) to be saved. Disable the constraint(s)
--required to test this trigger. also show the code to disable the constraints required to test this trigger

alter table Customer
nocheck constraint fk_CustomerToRoute
go

create trigger TR_ValidRouteID_Insert_Update
on Customer
for Insert, Update
as
if @@ROWCOUNT > 0
		Begin
		if update (RouteID)
				Begin
				if exists (select * from inserted where RouteID not in (select RouteID from Route))
						Begin
						Raiserror ('That is not a valid route id', 16,1)
						Rollback transaction
						end
				end
		end
return

--select * from Customer

--update Customer
--set RouteID = 500
--where CustomerID = 1
go

--QUESTION 2: Ensure the Zone Manager's wage is not increased by more than 15% at a time.
--should this be attempted, raise an error and do not allow the increase.
create Trigger TR_ZoneManagerWageIncrease_Update
On Zone
for Update
as
if update (Wage) and @@ROWCOUNT > 0
		Begin
		if exists (select * from inserted inner join deleted on inserted.ZoneID = deleted.ZoneID
		where inserted.Wage > deleted.Wage * 1.15)
				Begin
				Raiserror ('Sorry, zone manager wage cannot be increased by 15 percent', 16,1)
				Rollback transaction
				end
		End
return

go

--select * from Zone
--update Zone
--set Wage = 400
--where ZoneID = 2

--QUESTION 3: Ensure that carriers do not have more than 3 routes. Should this be attempted
--Should this be attempted, raise an error and do not save the changes

alter Trigger TR_Max3Routes_Insert_Update
on Route
for insert, update
as
if update (CarrierID) AND @@rowcount > 0
		Begin
		if exists (Select * from Route join inserted on Route.RouteID = inserted.RouteID
		group by inserted.RouteID  having count(*) > 3)
				Begin
				raiserror('No carrier can have more than 3 routes', 16,1)
				rollback transaction
				end
		end
return
go

select * from Route
update Route
set CarrierID = 3
where RouteID = 10

--QUESTION 4: Create a DeliveryTypeChanges table (not in a trigger). After an update is made where the value of the delivery-
--charge changes, add a record to the table. Show the code for the trigger and the table

Create Table DeliveryTypeChanges
(
	ChangeID int not null
	constraint PK_DeliveryTypeChanges primary key clustered,
	ChangeDateTime datetime not null,
	DeliveryTypeDescription varchar(10) not null,
	OldDeliveryCharge smallmoney not null,
	NewDeliveryCharge smallmoney not null
	
)
go
Create Trigger TR_DeliveryChargeChangesValues_Update
On DeliveryTypeChanges
for Update
as
if Update(OldDeliveryCharge) AND @@ROWCOUNT > 0
		
		Begin
		insert into DeliveryTypeChanges( ChangeID, ChangeDateTime, DeliveryTypeDescription, OldDeliveryCharge, NewDeliveryCharge)
		select inserted.ChangeID, getdate(), inserted.DeliveryTypeDescription, deleted.OldDeliveryCharge, inserted.NewDeliveryCharge 
		from inserted inner join deleted on inserted.ChangeID = deleted.ChangeID
		--where inserted.Deliverycharge <> deleted.Deliverycharge
		end
return

go

--insert into DeliveryTypeChanges (ChangeID, ChangeDateTime, DeliveryTypeDescription, OldDeliveryCharge, NewDeliveryCharge)
--values (1, '20191209', 'Truck', 5,5)
--go

--select * from DeliveryTypeChanges

--update 


--QUESTION 5: Ensure that a route is not deleted if the route has customers. Should the route have customers,
--raise an error and do not allow the delete to occur. Disable the constraint(s) required to test this trigger
--Also show the code to disable the constraints required to test ths trigger
alter table Route
nocheck constraint fk_RouteToRegion
alter table Route
nocheck constraint fk_RouteToDropSite
alter table Customer
nocheck constraint fK_CustomerToRoute
go 
create trigger TR_ValidateRouteDeletion_Delete
On Route
for delete
as
if @@ROWCOUNT > 0
		Begin
		if exists (select * from deleted inner join Customer on Deleted.RouteID = Customer.RouteID)
				Begin
				Raiserror ('Route has customers. Cannot delete', 16, 1)
				Rollback transaction
				end
		end
Return
end
go

--select * from Route
--delete Route where RouteID = 5

--select Route.RouteID, count(CustomerID) as 'number of customers'  from Customer join Route on Customer.RouteID = Route.RouteID
--group by Route.RouteID


--QUESTION 6: Minimum wage is $15/hour. if a Zone Manager's wage is reduced below $15 set it to be $15

create trigger TR_MinWageEnforce_Update
on Zone
for Insert, Update
as
if update(Wage) and @@ROWCOUNT > 0
		
		begin
				if exists (select * from inserted inner join deleted on inserted.ZoneID = deleted.ZoneID
		        where inserted.Wage < 15)
						
						update Zone
						set Wage = 15
						where wage < 15
						print ('Managers wage has been updated')
	   
				end
				  
		
return

go

select * from Zone
update zone
set Wage = 10
where ZoneID = 4