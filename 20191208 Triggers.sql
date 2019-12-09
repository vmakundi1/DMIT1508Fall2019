--What is a trigger?
--it is an object that is compiled and stored in the database
--it is associated with a specific table for a specific DML statement
--for example, if we creare a trigger that is associated with INSERT operation on staff tables
--the code in the trigger will execute everytime an insert statement is executed on the staff table
--triggers are executed only in response to a specific DML statement executing on a specific table
--triggers look like stored procedures, however, they do not  accept parameters
--triggers can be used to automate an operation such as backup, archiving, logging
--enforce business rules that are too complex for a check constraint
--'enforce referential inegrity across databases, for 2 tabkes in different databases. a FK cannot
--reference a table outside the database, you must use triggers for this purpose
--a trigger never commits or begins a transaction
--trigger can rollback transactions and issue error message if operation is deemed invalid. prevents changes from being made in the database
--trigger can use the inserted and deleted tables
--if the trigger does not issue a rollback, the database management system will commit the transaction this making the operation permanent
--two tables are created and used by the server when executing the DML operation
--Deleted table: contains the before image of all rows affected by the DML operation
--Inserted: contains the after image of all rows affected by the DML transaction

--Question 1:in order to be fair to all students, a student can only belong to maximum of 3 clubs.
--create a trigger to enforce this rule

go
create trigger TR_MaxThreeClubs_Insert_Update
on Activity
for insert, update
as
-- the rowcount variable will be non zero if at least one row was changed by this trigger
if ((update(StudentID) or update(ClubID)) and @@ROWCOUNT > 0)
begin
		--if the business rule is broken
		if		(
					exists
					(
							select Activity.StudentID
							from Activity join inserted on Activity.StudentID = inserted.StudentID
							group by Activity.StudentID
							having count(*) > 3
					)
				)
		begin
				raiserror ('A student may only belong to a maximum of 3 clubs!', 16, 1)
				rollback transaction
		end
end
select * from Activity
select * from Club
insert into Activity(StudentID, ClubID)
values (199912010, 'NAITSA')
go
create trigger TR_Student_Update
on Student
for update
as
begin
		print 'Executing trigger now'
		select * from inserted
	select * from deleted
	select * from student
	rollback transaction
	select * from inserted
	select * from deleted
	select * from student
	print 'trigger complete'
end

update Student
set BalanceOwing = 50
where StudentID = 199912010