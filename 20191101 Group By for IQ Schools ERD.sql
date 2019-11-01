--group by--
--for example--
select StudentId
from Registration
group by StudentId

--when using group by, you cannot select a column that is not in the group by clause or an aggregate function. 
--having is where clause for the 'group by' that is, it filters the group by
select StudentId, AVG(Mark) as 'Average Mark'
from Registration
group by StudentID
having AVG(Mark) > 80

--returns the unique offeringcodes(note that this is also the solution for Lab2B Question 1 about Queries part c about average delivery type charge--
select OfferingCode, AVG(Mark) as 'Average Mark for this offering'
from Registration
group by OfferingCode
having AVG(Mark) < 50

--a lit of unique cities in the student table--
--THERE IS AN ERROR FOR BELOW AS A LESSON--
--****Column 'Student.StudentID' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.**--
select StudentId, City
from Student
group by City

--A list of unique cities in the student table
select City, AVG(BalanceOwing) as 'Average of money students from the city owe'
from Student
group by City
having AVG(BalanceOwing) = 0

--how many students come from each city--
select City, Count(*) as 'Number of Students'
from Student
group by City


select * from Course

select CourseHours, AVG(cOURSEcOST) as 'Average Course Cost', COUNT(*) 'NUMBER OF COURSES'
from Course
group by CourseHours