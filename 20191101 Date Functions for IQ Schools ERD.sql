--imagine we want to see staff hired in October--
select FirstName, LastName, DATENAME (MM, DateHired) as 'Date Hired'
from Staff
where DATENAME (MM, DateHired) = 'October'

--imagine we want to see staff hired between 1990 and 1999
select FirstName, LastName, DATENAME(YY, DateHired) as 'Date Hired'
from Staff
where DATEPART (YY, DateHired) between 1990 and 1999

select DATEADD(DD, 97, GETDATE())

select DATEDIFF(DD, GETDATE(),'2021-08-12')

--QUESTION, SELECT THE STAFF NAMES AND the month they were hired--
--we are looking to check date staff were hired, note we put a column for 'month hired--
select FirstName, LastName, DATENAME (mm, DateHired) as 'Month Hired'
from Staff

--QUESTION, how many days did 'tess Agonor' work for the school--
--there needs a calculation, a difference between between two days of hire & fire, thus DATEDIFF--
select FirstName, LastName, DATEDIFF(DD, DateHired, DateReleased) as 'Days in organization'
from Staff
where FirstName = 'Tess' and Lastname = 'Aganor'

--QUESTION 3 ABOUT STUDENTS BORN in december. select the names of all the students born in december--
select FirstName, LastName, BirthDate
from Student
where DATENAME(MM, BirthDate) = 'December'

--Question 4, select the last 3 characters of all the courses--
--note that this is a string question so use string functions--
select RIGHT (CourseId, 3)
from Course

--question 5, select the characters in the position description from characters 8 to 13 for PosotionID 5--
--look at the ERD to see what would properly apply--
select SUBSTRING(PositionDescription, 8, 6)
from Position
where PositionID = 5

