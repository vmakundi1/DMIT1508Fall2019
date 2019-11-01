--Queries, Question 1 (a)--
select FirstName + ' '+ LastName as 'Customer', City as 'City'
from Customer
where CustomerID = 4

--**Queries, Question 1(b)--
select FirstName + ' '+ LastName as 'Carrier'
from Carrier


--Queries, Question 1(c)--
select DeliveryTypeID, AVG(Charge) as 'Average Charge per Delivery Type'
from DeliveryType
group by DeliveryTypeID

--Queries, Question 1(d)--
--Queries, Question 1(e)--
select *
from DeliveryType

--Queries, Question 1(f)--
--Queries, Question 1(g)--
select * 
from Customer


--Queries, Question 1(h)--
--Queries, Question 1(i)--
--Queries, Question 1(j)--
--Queries, Question 1(k)--
--Queries, Question 1(l)--


--DML, Question 2(a)--
--DML, Question 2(b)--