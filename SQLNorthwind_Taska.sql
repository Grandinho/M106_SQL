/*
M106 SQL
Projektarbeit Northwind
Aufgaben: 2-25
Von: Mateusz Wnuk
*/

-- Aufgabe 2

BACKUP DATABASE [Northwind] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\NorthwindBackup.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


-- Aufgabe 3
use master
go
Drop database Northwind

USE [master]
RESTORE DATABASE [Northwind] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\NorthwindBackup.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5

GO

-- Aufgabe 4

exec sp_columns Products


--Aufgabe 5
use Northwind
go
create schema hr

Create Table hr.payroll_accounting (
title varchar(100),
salary int
);

Insert into hr.payroll_accounting values 
('Inside Sales Coordinator', 80000),
('Vice President, Sales', 100000),
('Sales Representative', 80000),
('Sales Manager ', 90000);

--Aufgabe 6


create view lohnuebersicht as 
select emp.FirstName, emp.LastName, 
case
	when YEAR(Emp.hiredate) <= 1993 then pay.salary + (DATEDIFF(MONTH,emp.HireDate,GETDATE())*30)+ 1000
	else (pay.salary + (DATEDIFF(MONTH,emp.HireDate,GETDATE())*30))
end as Gehalt
from Employees Emp
join hr.payroll_accounting as Pay on emp.Title = Pay.title

select * from lohnuebersicht

select DATEDIFF(MONTH,HireDate,GETDATE()) as test from Employees
select * from hr.payroll_accounting

-- Aufgabe 7
use Northwind
alter table employees add valuation char(1) check(valuation like '[A-D]') default ('B') not null

Update Employees set Valuation = 'A' where EmployeeID = 1

Update Employees set Valuation = 'C' where FirstName = 'Robert' and LastName = 'King'



-- Aufgabe 8
 -- First drop all constraints which have dependendcies on valuation
exec sp_rename  'Employees.valuation', 'rating'

alter table employees add constraint CheckRating check (rating like '[A-D]')

-- Aufgabe 9

exec sp_rename 'hr.salaries', 'salaries';
-- Aufgabe 10

Select * into Products_Backup from Products

-- Aufgabe 11

Begin Transaction DeleteAllFromProducts_Backup

Delete from Products_Backup

Rollback Transaction

-- Aufgabe 12
Truncate table Products_Backup

select * from Products_Backup

-- Aufgabe 13

Drop table Products_Backup

-- Aufgabe 14

Select * into Products_New from Products

select * from Products

Update Products_New set ProductName = 'test' where ProductID = 1

select * from Products_New

merge Products as target
using Products_New as source
on  (target.ProductID = source.ProductId)
when matched
then update set target.ProductName = source.ProductName
when not matched by target
then insert (Productname) values (source.Productname)
when not matched by source
then delete;

select * from Products

-- Aufgabe 15

use master
Create login test with password = '12345', check_policy = off, check_expiration = off

use Northwind
create user test for login test

Alter role db_datareader add Member test

execute as login = 'test';
select * from Products
update Products set ProductName = 'da' where ProductID = 1

-- Benutzer test hat zugriff auf select aber kein Zugriff auf Insert,Delete,Update

-- Aufgabe 16

use Northwind
Grant Update on Products to test
execute as login = 'test'
update Products set ProductName = 'test2' where ProductID = 1


-- Aufgabe 17

exec sp_droprolemember db_datareader, test
revoke Update on products to test

Alter schema hr transfer employees

Grant select,insert,Update,delete on schema::hr to test



-- Aufgabe 18

Alter table hr.salaries
alter column salary add masked with (Function = 'default()');

CREATE USER XY WITHOUT LOGIN;

ALTER ROLE db_datareader ADD MEMBER XY;

EXECUTE AS USER ='XY';
GO
SELECT * FROM HR.salaries
REVERT;


-- Aufgabe 19
select * from Orders
select * from [Order Details]


select sum((Quantity*UnitPrice) * (1 - discount)) as 'Gesamtumsatz 1997' from [Order Details]
join Orders on Orders.OrderId = [Order Details].OrderID
where Year(Orders.OrderDate) = 1997


-- Aufgabe 20

select Customers.CompanyName, sum(UnitPrice*Quantity) as 'Gesamtbestellsumme' from Customers
join Orders on Customers.CustomerID = orders.CustomerID
join [Order Details] on Orders.OrderID = [Order Details].OrderID
group by Customers.CompanyName


-- Aufgabe 21

select Suppliers.SupplierID,CompanyName, COUNT(*) as 'Anzahl von Produkte' from Suppliers
join Products on  Suppliers.SupplierID = Products.SupplierID
group by Suppliers.SupplierID, CompanyName
having count(*) > 4


-- Aufgabe 22

select top 1 EmployeeID, FirstName, LastName, HireDate from hr.employees
order by HireDate desc

-- Aufgabe 23

select  lower(SUBSTRING(LastName,1,3) + SUBSTRING(FirstName,1,3)) as 'Username' from hr.Employees

-- Aufgabe 24
select * from hr.Employees
select ((Year(HireDate)+MONTH(HireDate)+DAY(HireDate))* EmployeeID) as 'Personalnummer' from hr.Employees

-- Aufgabe 25
-- Test 
Select * from hr.Employees

select EmployeeID, FirstName, LastName,  datediff(year,birthdate,getdate())  as 'Alter' from hr.Employees

-- richtige
select EmployeeID, FirstName, LastName, 
case
when MONTH(BirthDate) > MONTH(GETDATE()) or (MONTH(BirthDate) = MONTH(GETDATE()) and DAY(BirthDate) > DAY(GETDATE()))  THEN datediff(year,birthdate,getdate())-1  
else datediff(year,birthdate,getdate())
end as 'Alter'
from hr.Employees

select  (MONTH(BirthDate) - MONTH(GETDATE())) from hr.Employees

-- Aufgabe 26

-- With Index


-- Estimated I/O Cost 0,003125
select ProductName from Products


-- Without Index

-- Estimated I/O Cost 0,003125
drop index ProductsName on Products
select ProductName from Products
-- Eigentlich es soll schneller mit Index sein aber in dieses fall mit und ohne Index es ist gleich schnell und braucht genau viel I/O

Create index ProductsName on products (productname)