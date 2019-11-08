select*
from Registration

--add a "comments" column
alter table Registration
add Comments varchar(500) null


select*
from Staff
order by DateHired asc

--we can change the above by for example, order by 'lastname' and make it descending as below--

select *
from Staff
order by LastName desc

drop table Employee
create table Employee
(
   Employee int not null primary key,
   FirstName varchar (50)
       constraint CK_No_L_FirstName check(FirstName not like 'L%'),
   LastName varchar(50)
)

--lets say we didnt want the first name to equal the last name--
--try to double check this below, its giving you errors--
drop table Employee
create table Employee
(
   Employee int not null primary key,
   FirstName varchar (50)
       constraint CK_No_L_FirstName check(FirstName not like 'L%'),
   LastName varchar(50),
   constraint CK_FirstName_Not_Equal_LastName check(FirstName != LastName)
)
--run the above, then add the below
insert into Employee(EmployeeId, FirstName, LastName)
values(1,'Conrad','Conrad');
