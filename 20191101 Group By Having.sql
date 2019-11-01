select *
from Course
where MaxStudents > 3

select CourseHours, AVG(CourseCost) as 'Average Course Cost', COUNT(*) as 'Number of courses'
from Course
where MaxStudents > 3
group by CourseHours
having AVG(CourseCost)/CourseHours < 8

--NB the best way to write queries in sequential format. **we store data in a database but we are looking to gain value from that data
--note the sequence below--
--select--
--from--
--where--
--group by--
--having--

--we want to know students from province--
select Province
from Student
group by Province

--lets say we want to know amounts owed by students owing certain amount born on certain period--
select *
from Student
where BirthDate > '1969-01-01'

--lets say we want to know how much on average the storents owe with currency--
select province, FORMAT(AVG(BalanceOwing), 'C', 'en-us') as 'Average Balance Owing'
from Student
group by Province

--more filtering of data above--
select province, FORMAT(AVG(BalanceOwing), 'C', 'en-us') as 'Average Balance Owing'
from Student
where BirthDate > '1969-01-01'
group by Province
having Province != 'AB'