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

