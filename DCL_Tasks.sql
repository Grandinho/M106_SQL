use master 

--Aufgabe 1
Create login ethan with password = 'WWI4eth', check_policy = off

--Aufgabe 2
use WideWorldImporters
create user ethan for login ethan

 ALTER Role db_datareader add Member ethan

 --Aufgabe 3
 Grant UPDATE on Sales.Orderlines to ethan
 Grant UPDATE on Sales.Orders to ethan

 --Aufgabe 4
 Deny INSERT,UPDATE,DELETE on Sales.Invoices to ethan
 Deny INSERT,UPDATE,DELETE on Sales.InvoiceLines to ethan

 --Aufgabe 5
 use master

 Create login stella with password = 'WWI4ste!dddd', check_expiration = off, check_policy = on
 go
 alter server role bulkadmin add Member stella
 go
 use WideWorldImporters
 go
 create user stella for login stella
 go
 GRANT Insert on schema::Warehouse to stella

 --Aufgabe 6
 Grant alter on schema::Warehouse to stella
 Grant create table to stella