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
select PrePaidTip
from Carrier join Route on Carrier.CarrierID = Route.CarrierID
join Customer on Route.RouteID = Customer.RouteID



--Queries, Question 1(e)--
select Description
from DeliveryType join CustomerPaper on DeliveryType.DeliveryTypeID = CustomerPaper.DeliveryTypeID
join Customer on CustomerPaper.CustomerID = Customer.CustomerID





--Queries, Question 1(f)--
select *
from Carrier
join Route on Carrier.CarrierID = Route.CarrierID
join Customer on Route.RouteID = Customer.RouteID



--Queries, Question 1(g)--
select FirstName, LastName 
from Customer
where LEFT(LastName, 1)= 'S' --'Last name starts with S'--


--Queries, Question 1(h)--
select FirstName + ' ' + LastName as 'Carriers'
from Carrier
where LEN(FirstName)=3 and RIGHT(FirstName, 2) = 'ob'


--Queries, Question 1(i)--
select FirstName + ' ' + LastName as 'Carriers', RouteID
from Carrier
join Route on Carrier.CarrierID = Route.CarrierID
where RouteID > = 0


--Queries, Question 1(j)--
select Description
from DeliveryType join CustomerPaper on DeliveryType.DeliveryTypeID = CustomerPaper.DeliveryTypeID
join Customer on CustomerPaper.CustomerID = Customer.CustomerID




--Queries, Question 1(k)--
select FirstName + ' ' + LastName as 'CustomerSummary'
from Customer join CustomerPaper on Customer.CustomerID = CustomerPaper.CustomerID
join Paper on CustomerPaper.PaperID = Paper.PaperID


--Queries, Question 1(l)--


--DML, Question 2(a)--
insert into Region (RegionID, Name, SupervisorFirstName, SupervisorLastName, ZoneID)
Values (400, 'Calmar', 'David', 'Smithers', 3)
go

--2nd part
insert into Region (RegionID, RegionName, SupervisorName, SupervisorLastName, ZoneID)
Values
go

--DML, Question 2(b)--