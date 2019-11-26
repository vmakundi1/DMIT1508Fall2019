--STORED PROCEDURES TRANSACTIONS
--Question 1: Create a stored procedure called ‘RegisterStudentTransaction’ that accepts StudentID and 
--offering code as parameters. If the number of students in that course and semester are not 
--greater than the Max Students for that course, add a record to the Registration table and 
--add the cost of the course to the students balance. If the registration would cause the 
--course in that semester to have greater than MaxStudents for that course raise an error

create procedure RegisterStudentTransaction (@StudentID int = null, @OfferingCode int = null)
as
if @StudentID is null or @OfferingCode is null
		begin
		raiserror ('You must provide a student ID and offering code', 16, 1)
		end