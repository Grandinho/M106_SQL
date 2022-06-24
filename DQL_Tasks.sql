use WideWorldImporters

-- Select
Select * from Sales.Customers
Select Sales.Customers.CustomerName, sales.Customers.DeliveryAddressLine1 from sales.Customers

SELECT CustomerName, PhoneNumber as 'Telefonnummer'
FROM Sales.Customers;

Select CountryName + ' ' + '(' + IsoAlpha3Code +')' as 'Land' from Application.Countries
order by CountryName desc

Select  distinct Continent  from Application.Countries 

SELECT TOP 3 * FROM Sales.Orders ORDER BY OrderDate ASC;

-- Where

SELECT CountryID, FormalName, SubRegion FROM Application.Countries
Where CountryName = 'Switzerland';


SELECT * FROM Application.People where FullName not like 'a%'

SELECT * FROM Application.People
WHERE FullName LIKE '[^a]%';

Select * from sales.Orders where OrderDate BETWEEN '2016-01-01' and '2016-01-31'
Order By OrderDate DESC

-- Cases

SELECT OrderID, Quantity,
(case
when Sales.OrderLines.Quantity > 10 then 'Bestellmenge ist grösser 10'
when Sales.OrderLines.Quantity = 10 then 'Bestellmenge ist 10'
else 'Bestellmenge ist kleiner als 10'
end) as 'Quantity Text'
FROM Sales.OrderLines;


-- Unterabfragen

Select * from Warehouse.StockItems where UnitPrice > (select AVG(unitprice) from Warehouse.StockItems)


Select c.CustomerID, c.CustomerName, O.OrderDate, o.Order_Amount from Sales.Customers c
join (select CustomerID, Orderdate, Count(*) as 'Order_Amount' from sales.Orders group by CustomerID, OrderDate 
Having count(*) > 4) as o on o.CustomerID = c.CustomerID


select CustomerID, OrderDate, Count(*) as 'Order_Amount' from sales.Orders 
group by CustomerID, OrderDate
having  count(*) > 4


select   c.CustomerID, c.CustomerName, O.CustomerID, O.OrderDate from Sales.Customers c
join sales.Orders o on c.CustomerID = o.CustomerID
order by c.CustomerID asc

select  c.CustomerID, c.CustomerName, O.CustomerID, O.OrderDate from sales.Orders o
left outer join Sales.Customers c on c.CustomerID = o.CustomerID
order by c.CustomerID asc

Select FullName from Application.People
Intersect
Select CustomerName From Sales.Customers

Select CustomerName from Sales.Customers
Except
Select FullName from Application.People

SELECT FullName, Photo FROM Application.People
UNION
SELECT StockItemName, Photo FROM Warehouse.StockItems;


-- DQL All Tasks

-- 1. Select

-- 1.1
select * from sales.Customers c


-- 1.2
Select FullName from Application.People

-- 1.3
Select DeliveryMethodName from Application.DeliveryMethods

-- 1.4
Select CustomerID, CustomerName, PostalAddressLine1 + ', ' + PostalAddressLine2 + ', ' + PostalPostalCode as 'Adress' from Sales.Customers 

-- 2. Where

-- 2.1

Select * from Application.People
Where IsEmployee = 1

-- 2.2

Select * from Application.People
Where IsEmployee = 1 and IsSalesperson = 1

-- 2.3

Select * from Application.Cities
where LatestRecordedPopulation > 10000

-- 2.4

Select * from Application.Cities
where CityName like 'Ab%'

-- 3. Join

-- 3.1

Select c.CustomerID, o.OrderID from sales.Customers c
join sales.Orders o on c.CustomerID = o.CustomerID

-- 3.2

Select c.CustomerID, o.OrderID from sales.Customers c
left join sales.Orders o on c.CustomerID = o.CustomerID
where o.CustomerID is Null
 
 -- Teacher's solution
Select CustomerID from sales.Customers
EXCEPT
Select CustomerID from sales.orders

-- 3.3

select 
c1.CustomerName,  
c2.DeliveryAddressLine1+' '+c2.DeliveryAddressLine2+' '+c2.DeliveryPostalCode+' '
+ c2.PostalAddressLine1 +' '+ c2.PostalAddressLine2 AS ADRESSE from sales.Customers c1
join sales.Customers c2 on c1.CustomerID = c2.CustomerID







select * from sales.Customers


SELECT  CustomerID ,CustomerName, DeliveryAddressLine1+' '+DeliveryAddressLine2+' '+DeliveryPostalCode+' '
+PostalAddressLine1+' '+PostalAddressLine2 AS ADRESSE FROM Sales.customers
WHERE CustomerID IN (SELECT Distinct BillToCustomerID FROM Sales.customers)



select *, c2.* from sales.Customers c1
join sales.Customers c2 on c1.BillToCustomerID = c2.BillToCustomerID

select  C1.CustomerID,  C1.CustomerName, DeliveryAddressLine1 from sales.Customers C1

select * from sales.Customers 
where CustomerID != BillToCustomerID

SELECT DISTINCT BillToCustomerID FROM Sales.customers


-- 4. Cases

-- 4.1
select * from Application.People
Select p.FullName, p.PhoneNumber, p.FaxNumber,
(case
when p.IsSalesperson = 1 then 'Verkäufer'
when p.IsEmployee = 1 then 'Mitarbeiter'
when p.IsEmployee = 0 and p.IsSalesperson = 0 then 'Kunde'
end) as 'Rolle'
from Application.People p
where p.PhoneNumber is not Null or p.FaxNumber is not null


-- 5. Gruppierungen

-- 5.1

select * from sales.OrderLines


select top 10 OrderID, sum(Quantity*UnitPrice) as 'Amount' from sales.OrderLines 
group by OrderID
order by Amount desc

-- 5.2

select top 10 ol.OrderID, sum(Quantity*UnitPrice) as 'Amount', c.CustomerName from sales.OrderLines as ol
join sales.Orders as o on ol.OrderID = o.OrderID
join sales.Customers as c on o.CustomerID = c.CustomerID
group by ol.OrderID, c.CustomerName
order by Amount desc

select * from sales.orders

select top 10 ol.OrderID, c.CustomerID, c.CustomerName , sum(Quantity*UnitPrice) as 'Amount' from sales.OrderLines ol
join sales.Orders o on o.OrderID = ol.OrderID
join sales.Customers c on o.CustomerID = c.CustomerID
group by ol.OrderID, c.CustomerID, c.CustomerName
order by Amount desc

	

select * from sales.Orders
where OrderID = 30269


select * from sales.Orders
where OrderID = 17103

select * from sales.Customers
where CustomerID = 834

select * from sales.Customers
where CustomerID = 86

-- Teacher's solution
SELECT c.CustomerName FROM Sales.Customers c
Join Sales.Orders o ON c.CustomerID=o.CustomerID 
JOIN 
(SELECT TOP (10) ol.OrderID, SUM(ol.Quantity*ol.UnitPrice) AS 'TOTAL' FROM Sales.OrderLines ol
GROUP BY ol.OrderID
ORDER BY TOTAL DESC) u ON o.OrderID = u.OrderID 

select * from sales.Customers
where CustomerName = 'Tailspin Toys (Medicine Lodge, KS)'

select * from sales.Orders
where CustomerID = 4


-- 5.3 
select top 10 c.CustomerName , sum(Quantity*UnitPrice) as 'Amount' from sales.Customers c
join sales.Orders o on c.CustomerID = o.CustomerID
join sales.OrderLines ol on o.OrderID = ol.OrderID
group by  c.CustomerName
order by Amount desc

-- 5.4
select c.CountryName, COUNT(*) as 'Provinzanzahl' from Application.StateProvinces as st
join Application.Countries as c on st.CountryID = c.CountryID
group by c.CountryName


-- 5.6

select OrderID, count(*) as 'Artikel anzahl' from sales.OrderLines
group by OrderID
having count(*) >= 5


-- 6. Union

-- 6.1

select CustomerCategoryID, CustomerCategoryName from sales.CustomerCategories
where CustomerCategoryID in (select distinct CustomerCategoryID from sales.Customers)

select distinct s1.CustomerCategoryID, CustomerCategoryName from sales.CustomerCategories s1
join sales.Customers on s1.CustomerCategoryID = sales.Customers.CustomerCategoryID

SELECT CustomerCategoryID,CustomerCategoryName FROM Sales.CustomerCategories
WHERE CustomerCategoryID IN(SELECT DISTINCT CustomerCategoryID FROM Sales.Customers)


-- Views

Create view CaliforniaCities as
select CityID, CityName, st.StateProvinceCode, st.StateProvinceName from Application.Cities as c
join Application.StateProvinces as st on c.StateProvinceID = st.StateProvinceID
where st.StateProvinceName = 'California'

select CityID, CityName, st.StateProvinceCode, st.StateProvinceName from Application.Cities as c
join (select StateProvinceID, StateProvinceCode, StateProvinceName from Application.StateProvinces
where StateProvinceName = 'California'
) st on st.StateProvinceID = c.StateProvinceID

select * from CaliforniaCities where CityName = 'Los Angeles'

Drop view CaliforniaCities