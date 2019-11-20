--Inner Joins With Aggregates Exercises using IQ School ERD
--1. How many staff are there in each position? Select the number and Position Description
 select Position.PositionDescription, count(*) as 'Number of Staff in this position'
 from Staff join Position on Staff.PositionID = POsition.PositionID
 group by PositionDescription

--2. Select the average mark for each course. Display the CourseName and the average mark
select CourseName, AVG(Registration.Mark) as 'Average Mark'
from Course join Offering on Course.CourseID = Offering.CourseID
join Registration on Offering.OfferingCode = Registration.OfferingCode
group by CourseName 

--3. How many payments where made for each payment type. Display the PaymentTypeDescription and the count
select PaymentType.PaymentTypeDescription, count(*) as 'Number of payments made'
from Payment join PaymentType on Payment.PaymentTypeID = PaymentType.PaymentTypeID
group by PaymentType.PaymentTypeDescription

--4. Select the average Mark for each student. Display the Student Name and their average mark
 select Student.StudentID, Student.FirstName + ' ' + Student.LastName as 'Student Name', AVG(Registration.Mark) as 'Average Mark'
 from Registration join Student on Student.StudentID = Registration.StudentID
 group by Student.StudentID, FirstName + ' ' + LastName


--5. Select the same data as question 4 but only show the student names and averages that are > 80
 select Student.StudentID, Student.FirstName + ' ' + Student.LastName as 'Student Name', AVG(Registration.Mark) as 'Average Mark'
 from Registration join Student on Student.StudentID = Registration.StudentID
 group by Student.StudentID, FirstName + ' ' + LastName
 having AVG(Registration.Mark) > 80
 
--6.what is the highest, lowest and average payment amount for each payment type Description? 
 

--7. How many students are there in each club? Show the clubName and the count
 
--8. Which clubs have 3 or more students in them? Display the Club Names.
 
