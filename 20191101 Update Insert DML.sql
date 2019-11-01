--Now into data manipulation (dml)--
insert into Student(StudentId, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
values (222, 'Zi', 'Yun', 'M', '10701 - 81 street', 'Calgary', 'AB', 'T6W7D1', '2000-05-22', 0)

--imagine a student has moved to a new address--
select * from student

update Student
set StreetAddress = '8998 - 81 Street', City = 'Edmonton'
where StudentID = 198933540

--LETS SAY WE WANT TO REDUCE BALANCE OWING FOR aLBERTA STUDENTS BY 10%--
update Student
set BalanceOwing = BalanceOwing * 0.9
where Province = 'AB'

--delete which means remove the records from student--
--delete from Student (we can use this to delete all details of students) but for certain records only, you have to add where--
--delete from Student
--where BalanceOwing > 500
--note that this query did not work because there were other records dependent on that record. so you may have to go table by table to delete the records in each table
--we found its dependent on 3 other tables

--delete from Activity
--where StudentId in (select StudentId from Student where BalanceOwing > 500)

--delete from Registration
--where StudentId in (select StudentId from Student where BalanceOwing > 500)

--delete from Payment
--where StudentId in (select StudentId from Student where BalanceOwing > 500)

--delete from Student
--where BalanceOwing > 500