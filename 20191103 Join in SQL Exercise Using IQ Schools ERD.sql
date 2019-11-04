--1.	Select Student full names and the course ID's they are registered in.--
select FirstName + ' ' + LastName 'Student Name', CourseID
from Student join registration ON Student.StudentID = registration.StudentID
join offering ON registration.OfferingCode = offering.OfferingCode

--2.	Select the Staff full names and the Course ID’s they teach--
select FirstName + ' ' + LastName 'Staff Name', CourseID
from Staff join Offering ON Staff.StaffID = Offering.StaffID

--3.	Select all the Club ID's and the Student full names that are in them--
select ClubID, FirstName + ' ' + LastName as 'Student Name'
from Activity join Student ON Student.StudentID = Activity.StudentID

--4.	Select the Student full name, courseID's and marks for studentID 199899200.--
select FirstName + ' ' + LastName as 'Student name', CourseID, mark
from Student join Registration ON Student.StudentID = Registration.StudentID
join Offering ON Registration.OfferingCode = Offering.OfferingCode
where Student.StudentID = 199899200

--5.	Select the Student full name, course names and marks for studentID 199899200.--
select FirstName + ' ' + LastName as 'Student name', CourseID, mark from Student
join Registration on Student.StudentID = Registration.StudentID
join Offering on Registration.OfferingCode = Offering.OfferingCode
where Student.StudentID = 199899200

--6.	Select the CourseID, CourseNames, and the Semesters they have been taught in--
select Course.CourseID, CourseName, SemesterCode from Course
join Offering on Course.CourseID = Offering.CourseID

--7.	What Staff Full Names have taught Networking 1?--
select FirstName + ' ' + LastName as 'Staff name' from staff
join Offering on Staff.StaffID = Offering.StaffID
join Course on Course.CourseID = Offering.CourseID
where CourseName = 'Networking 1'

--8.	What is the course list for student ID 199912010 in semestercode A100. Select the Students Full Name and the CourseNames.--
select FirstName + ' ' + LastName as 'Student name', CourseName from Student
join Registration on Student.StudentID = Registration.StudentID
join Offering on Registration.OfferingCode = Offering.OfferingCode
join Course on Course.CourseID = Offering.CourseID
where Student.StudentID = 199912010 and SemesterCode = 'A100'

--9. What are the Student Names, courseID's that have Marks >80?--
select FirstName + ' ' + LastName as 'Student name', CourseID, Mark from Student
join Registration ON Student.StudentID = Registration.StudentID
join Offering on Offering.OfferingCode = Registration.OfferingCode
where Mark > 80
