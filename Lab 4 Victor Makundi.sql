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
alter Trigger TR_ZoneManagerWageIncrease_Update
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

create Trigger TR_Max3Routes_Insert_Update
on Route
for insert, update
as
if update (RouteID) AND @@rowcount > 0
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

--QUESTION 4: Create a DeliveryTypeChanges table (not in a trigger). After an update is made where the value of the delivery-
--charge changes, add a record to the table. Show the code for the trigger and the table


--QUESTION 5: Ensure that a route is not deleted if the route has customers. Should the route have customers,
--raise an error and do not allow the delete to occur. Disable the constraint(s) required to test this trigger
--Also show the code to disable the constraints required to test ths trigger

--QUESTION 6: Minimum wage is $15/hour. if a Zone Manager's wage is reduced below $15 set it to be $15
