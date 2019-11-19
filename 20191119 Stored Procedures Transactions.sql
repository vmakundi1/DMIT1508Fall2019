--using the IQSchool database
--"when you begin a transaction, you can either commit or roll it back"
--Transaction Exercise
--1.	Create a stored procedure called ‘RegisterStudentTransaction’ that accepts StudentID and offering code as parameters. (A)
--If the number of students in that course and semester (OFFERING) are not greater than the Max Students for that course, (B)
--add a record to the Registration table and add the cost of the course to the students balance. 
--(C)If the registration would cause the course in that semester to have greater than MaxStudents for that course raise an error.
--NB, STATEMENT ADD A RECORD AND ADD A COST IMPLIES INSERT AND UPDATE
--NOTE IN THIS QUESTION WE ASSUME VALIDATION IS OK!! HAHAHAHA


--create procedure RegisterStudentTransaction(@StudentID int = null, @OfferingCode int = null)
--as
--if(@StudentID is null or @OfferingCode is null)
--    raiserror ('You must provide a StudentID and an Offering Code', 16, 1)
--else
--begin

--end

--ABOVE IS (A)

--NEST, BY LOOKING ERD, WE MIGHT NEED TO KNOW MAX NUMBER OF STUDENTS IN A COURSE

create procedure RegisterStudentTransaction(@StudentID int = null, @OfferingCode int = null)
as
if(@StudentID is null or @OfferingCode is null)
    raiserror ('You must provide a StudentID and an Offering Code', 16, 1)
else
begin
    declare @MaxStudents int-- we declare a variable
	select @MaxStudents = Course.MaxStudents --we stored how many students are allowed to be in the course
	from Offering join Course on Offering.CourseID = Course.CourseID

	declare @StudentCount int--now we answering the question (C)
	select @StudentCount = count(*)
	from Registration
	where OfferingCode = @OfferingCode --not offering code could be any thats passed in 
	if (@StudentCount >= @MaxStudents)
	    raiserror ('Course already at maximum capacity', 16, 1)
	else
	begin
	    -- We need to successfully execute 2 DML statements, beging transaction
		begin transaction
		insert into Registration (StudentID, OfferingCode)
		values (@StudentID, @OfferingCode)
		if(@@ERROR <> 0)  --MEANS IS NOT EQUAL TO
		begin
			raiserror('Registration insert failed', 16, 1) --16 is the priority level 1 to 15 is normal warning (informational errors)
			rollback transaction
		end
		else
		begin
		--going to the ERD, we notice that we need to update our balance owing (which is in customer table) and we need to link with course cost in the course table far away!!
			 declare @CourseCost decimal 
			 select @CourseCost = CourseCost from Course where CourseID = (select CourseID from Offering where OfferingCode = @OfferingCode)
			 update Student
			 set BalanceOwing = BalanceOwing + @CourseCost --##not final solution if showing this
			 where StudentID = @StudentID
			 if(@@ERROR != 0)
			 begin
				 raiserror('Updating Student balance failed!', 16, 1)
				 rollback transaction
			end
			else
			   commit transaction
		end
	end
end

select Course.MaxStudents
from Offering join Course on Offering.CourseID = Course.CourseID
where Offering.OfferingCode = 1001








--2.	Create a procedure called ‘StudentPaymentTransaction’  that accepts Student ID and paymentamount as parameters. Add the payment to the payment table and adjust the students balance owing to reflect the payment.

--3.	Create a stored procedure called ‘WithdrawStudentTransaction’ that accepts a StudentID and offeringcode as parameters. Withdraw the student by updating their Withdrawn value to ‘Y’ and subtract ½ of the cost of the course from their balance. If the result would be a negative balance set it to 0.

--4.	Create a stored procedure called ‘DisappearingStudent’ that accepts a studentID as a parameter and deletes all records pertaining to that student. It should look like that student was never in IQSchool! 

--5.	Create a stored procedure that will accept a year and will archive all registration records from that year (startdate is that year) from the registration table to an archiveregistration table. Copy all the appropriate records from the registration table to the archiveregistration table and delete them from the registration table. The archiveregistration table will have the same definition as the registration table but will not have any constraints.



