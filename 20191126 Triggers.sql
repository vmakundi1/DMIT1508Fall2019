--a TRIGGER is an object that is compiled and stored in the database. it is associated with a specific table for a specific DML statement
--'a trigger is married to a table'

--TRIGGERS EXERCISE
--In order to be fair to all students, a student can only belong to a maximum of 3 clubs. Create a trigger to enforce this rule.
--FIRST, look at the IQSCHOOL ERD
--Notice that this trigger cannot be on delete. so this trigger should be on insert or update

Create trigger TR_MaxThreeClubs_Insert_Update
on Activity
for insert, update
as 
if( (update(StudentID) or update(ClubID))and @@ROWCOUNT >0) --what is rowcount? how does is it related to trigger?
--the row count variable will be non zero if at least one row was changed by this trigger
--update studebtID asks did it update the student column
begin
	--if the business rule is broken
	if(
			exists
			(
				select Activity.StudentID
				from Activity join inserted on Activity.StudentID = inserted.StudentID
				group by Activity.StudentID
				having count(*) > 3
			)
	  )
	begin
		raiserror('A student may only belong to a maximum of 3 clubs!', 16, 1)
		rollback transaction
	end

end

go

----TO TEST THE TRIGGER ABOVE, FIRST SEE WHAT WE HAVE IN ACTIVITY
--select * from Activity
----SECOND, CHECK THE CLUBS
--select * from Club
----FINALLY DO THE CHECK!
--insert into Activity(StudentID, ClubID)
--values(199912010, 'NAITSA')
--Error messahe: A student may only belong to a maximum of 3 clubs

--Example 2:
create trigger TR_Student_Update
on Student
for update
as
begin
	print 'Executing trigger now'
	select * from inserted --inserted is a temporary table that represents records that will be updated/changed if the transaction is successful
	select * from deleted
	select * from Student
	Rollback transaction
	select * from inserted
	select * from deleted
	select * from Student
	print 'trigger complete'
	return

end

update Student
set BalanceOwing = 50
where StudentID = 199912010