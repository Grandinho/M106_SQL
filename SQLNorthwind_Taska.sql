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
	else (pay.salary + (DATEDIFF(MONTH,GETDATE(),emp.HireDate)*30))
end as Gehalt
from Employees Emp
join hr.payroll_accounting as Pay on emp.Title = Pay.title


-- Aufgabe 7

alter table employees add valuation char(1) check(valuation in (A-D)) default (B) not null
alter table employees drop column valuation
select * from Employees





