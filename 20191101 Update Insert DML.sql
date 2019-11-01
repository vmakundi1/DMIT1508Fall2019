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