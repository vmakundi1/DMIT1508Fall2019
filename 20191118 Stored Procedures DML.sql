--Stored Procedures – DML exercise--
--For this exercise you will need a local copy of the IQSchool database. --
--1.	Create a stored procedure called ‘AddClub’ to add a new club record.--
--this stored procedure will add/'insert' a club into the database
--lets say we have a 'Harry Potter' club
--**check for nulls

create procedure AddClub(@ClubID varchar(10) = null, @ClubName varchar (50) = null)
as
if(@ClubID is null or @ClubName is null)
  raiserror ('You must provide a ClubID and a ClubName', 16, 1);
else
begin
   if(exists(select ClubID from Club where ClubName = @ClubName))
       raiserror('The club name you provided already exists in the club table', 16,1);
   else
   begin
       insert into Club(ClubID, ClubName)
	   values(@ClubID, @ClubName)
	   if(@@ERROR !=0)   --note we are checking a business role i.e there is no club with same name as above and here its if everything blows up
	       raiserror('Insert failed!', 16, 1)

   end
end

execute AddClub 100, 'Harry Potter Club'

--2.	Create a stored procedure called ‘DeleteClub’ to delete a club record.

--3.	Create a stored procedure called ‘Updateclub’ to update a club record. Do not update the primary key!


--4.	Create a stored procedure called ‘ClubMaintenance’. It will accept parameters for both ClubID and ClubName as well as a parameter to indicate if it is an insert, update or delete. This parameter will be ‘I’, ‘U’ or ‘D’.  insert, update, or delete a record accordingly. Focus on making your code as efficient and maintainable as possible.

--5.	 Create a stored procedure called ‘RegisterStudent’ that accepts StudentID and OfferingCode as parameters. If the number of students in that Offering are not greater than the Max Students for that course, add a record to the Registration table and add the cost of the course to the students balance. If the registration would cause the Offering to have greater than the MaxStudents   raise an error. 

--6.	Create a procedure called ‘StudentPayment’ that accepts Student ID, paymentamount, and paymentTypeID as parameters. Add the payment to the payment table and adjust the students balance owing to reflect the payment. 

--7.	Create a stored procedure caller ‘FireStaff’ that will accept a StaffID as a parameter. Fire the staff member by updating the record for that staff and entering todays date as the DateReleased. 

--8.	Create a stored procedure called ‘WithdrawStudent’ that accepts a StudentID, and OfferingCode as parameters. Withdraw the student by updating their Withdrawn value to ‘Y’ and subtract ½ of the cost of the course from their balance. If the result would be a negative balance set it to 0.

--write a stored procedure to update a staff member last name

create procedure ChangeStaffLastName (@StaffID smallint = null, @LastName varchar(35) = null)
as
if(@StaffID is null or @LastName is null)
    raiserror ('Must supply a staff ID and Last name', 16, 1)
else
begin
    if(not exists(select StaffID from Staff where StaffID = @StaffID)
	    raiserror('Staff member does not exist! try again', 16, 1)
	else
	begin
	    update Staff
		set LastName = @LastName
		where StaffID = @StaffID
		if(@@ERROR != 0)
		    raiserror('Error updating staff Last Name', 16,1)
	end
end
select * from Staff
exec ChangeStaffLastName 287, 'Jones'

--this procedure deletes a staff member

create procedure DeleteStaff(@StaffID smallint = null)
as
if(@StaffID is null)
   raiserror('Must provide a Staff IF', 16, 1)
else
begin
    --Does the staff member even exist?
	if(not exists(select StaffID from Staff where StaffID = @StaffID))
	   raiserror('Staff member does not exist', 16, 1)
	else
end