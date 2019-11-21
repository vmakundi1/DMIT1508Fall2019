---a join is used to compare and combine & return specific rows of data from 2 or more tables iin a database

--Inner join finds and returns matching data from tables
--outer join finds and returns matching + some dissimilar data

--INNER JOIN focuses on commonality. there must be at leat some matching data btn the two or more tables
--upon finding the data, INNER combines and returns the info into 1 new table
--you have 2 tables: product prices and product quantities
--common info is product name ONLY
--thus, that is the logical column to join the tables 'on'
--Table 1: Prices
--PRODUCT Potatoes PRICE $3
--PRODUCT Avocados PRICE $4
--PRODUCT Onions PRICE $5
--Table 2: Quantities
--PRODUCT Potatoes QUANTITY 45
--PRODUCT Tomatoes QUANTITY 5
--PRODUCT Broccoli QUANTITY 6

--select prices.*, Quantities.Quantity
--from Prices INNER JOIN Quantities
--on Prices.Product = Quantities.Product

--Query result:
--Table:
--PRODUCT Potatoes PRICE $3 QUANTITY 45

--OUTER JOIN: returns inner join PLUS other rows for which no corresponding match is found in the other table
--we have 3 types;
--LEFT OUTER JOIN or LEFT JOIN: will return all data from INNER JOIN + all the shared data but only corresponding data
--from above example, our table would look like below
--Table after left Join
--PRODUCT Potatoes PRICE $3 QUANTITY 45
--PRODUCT Avocados PRICE $4 QUANTITY NULL
--PRODUCT Onions   PRICE $5 QUANTITY NULL

--How does the formula look like?
--select Prices.*, Quantities.Quantity
--from Prices LEFT OUTER JOIN Quantities
--ON Prices.Product = Quantities.Product

--https://www.diffen.com/difference/Inner_Join_vs_Outer_Join

--EXERCISE USING IQSCHOOL

--Question 1: Select all position descriptions and the staff ID;s that are in those positions
select Position.PositionDescription, Staff.StaffID
from Position left outer join staff on Position.PositionID = Staff.PositionID

--Question 2: Select the Position Description and the count of how many staff are in those positions. Return the count for ALL positions.
select Position.PositionDescription, COUNT(StaffID) as 'Number of staff per position'
from Position left outer join Staff on Position.PositionID = Staff.PositionID
group by Position.POsitionID, Position.PositionDescription

--Question 3: Select the average mark of ALL the students. Show the student names and averages
select FirstName + ' ' + LastName as 'Student Name', AVG(Mark) as 'Average Mark'
from Student left outer join Registration on Student.StudentID = Registration.StudentID
group by Student.FirstName + ' ' + Student.LastName

--Question 4: Select the highest and lowest mark for each student
select FirstName + ' ' + LastName as 'Student name', MAX(Mark) as 'Highest Mark', MIN(Mark) as 'Lowest mark'
from Student left outer join Registration on Student.StudentID = Registration.StudentID
group by Student.FirstName + ' ' + Student.LastName 

--Question 5: How many students are in each club? Display club name and count?
select Club.ClubName, COUNT(Activity.ClubID) as'Number of students in the club'
from Club join Activity on Club.ClubID = Activity.ClubID
group by Club.ClubID, Club.ClubName