--November 1st 2019 lesson about Unions--
Select distinct FirstName, LastName
From Student
Where studentId in (select StudentId from Registration)
--interset (students are bth in a club and a course
--union (students are in either a club or a course
--except students who are in a course but not in a club
Select distinct FirstName, LastName
From Student
Where StudentId in (select StudentId from Activity)

--alternative solution with union/intersect
Select distinct FirstName, LastName
From Student
Where studentId in (select StudentId from Registration)
--"or" is the same result as UNION
--"and" is the same result as intersect
--""and studentId not in" is the same result as ECEPT
and StudentId in (select StudentId from Activity)


--how to get names of people (staff and students) who have a birthdate or hire date in August
select FirstName, LastName
from Student
where DATEPART(MM, BirthDate) = 8
union
select FirstName, LastName
from Staff
where DATEPART(MM, BirthDate) = 8

--a view is a window into the database, just what soeone may need to see with restrictions/permissions--
--1st create view as, then run the query--
--rule of views, they need to be first in a batch, symbolized by go below--

go
drop view student_club_contest_view;
go
create view student_club_contest_view
as
select Student.StudentID as 'ID', Student.FirstName 'FNAME', Student.LastName 'LNAME', Club.ClubName 'CNAME'
from Student join Activity on Student.StudentID = Activity.StudentID 
join Club on Activity.ClubId = Club.ClubId
go
select* from student_club_contest_view
