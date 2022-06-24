Use WideWorldImporters
select * from Application.People where PersonID = 1500

--Aufgabe 1.1
Insert Into Application.People (PersonID, FullName, PreferredName, IsPermittedToLogon, LogonName, IsExternalLogonProvider, HashedPassword, IsSystemUser, IsEmployee, IsSalesperson, UserPreferences, PhoneNumber, FaxNumber,	 EmailAddress, Photo, CustomFields, LastEditedBy) 
values (1500, 
'Maria Harzog', 
'Maria', 
0, 
'No Logon',
0,
NULL,
0,
0,
0,
Null,
'+41 44 124 34 45',
Null,
'maria@spielhandelsag.ch',
Null,
Null,
1);

-- Aufgabe 1.2
Insert Into Application.People (PersonID, FullName, PreferredName, IsPermittedToLogon, LogonName, IsExternalLogonProvider, HashedPassword, IsSystemUser, IsEmployee, IsSalesperson, UserPreferences, PhoneNumber, FaxNumber,	 EmailAddress, Photo, CustomFields, LastEditedBy) 
values 
(1501, 'Elene Harzog', 'Maria', 0, 'No Logon',0,NULL,0,0,0,Null,'+41 44 124 34 45',Null,'elene@spielhandelsag.ch',Null,Null,1),
(1502, 'Ted Bernet', 'Ted', 0, 'No Logon',0,NULL,0,0,0,Null,'+41 43 164 34 32',Null,'ted@spielhandelsag.ch',Null,Null,1),
(1503, 'Franz Müller', 'Franz', 0, 'No Logon',0,NULL,0,0,0,Null,'+41 47 132 34 65',Null,'franz@spielhandelsag.ch',Null,Null,1)
;

-- Aufgabe 1.2 B
select * from Sales.Customers

insert into Sales.Customers (CustomerID, CustomerName, BillToCustomerID, CustomerCategoryID, BuyingGroupID, PrimaryContactPersonID, AlternateContactPersonID, DeliveryMethodID, DeliveryCityID, PostalCityID, CreditLimit, AccountOpenedDate, StandardDiscountPercentage, IsStatementSent, IsOnCreditHold, PaymentDays, PhoneNumber, FaxNumber, DeliveryRun, RunPosition, WebsiteURL, DeliveryAddressLine1, DeliveryAddressLine2, DeliveryPostalCode, DeliveryLocation, PostalAddressLine1, PostalAddressLine2, PostalPostalCode, LastEditedBy)
values(1062, 'SpielHandels AG', 1043, 7, Null, 1500, 1501, 3, 7113, 7113, 3500, getdate(), 0, 0, 0, 7, '322', '321', Null, Null, 'http://www.tailspintoys.com/AmandaPark', 'dsa', 'dsa', 321, Null, 'dsa', 'dsadsa', 321, 1);

-- Aufgabe 2.1
Update Application.People set FullName = 'Ted Meier' where PersonID = 1502;

-- Aufgabe 3.1	
Select * from Application.People where FullName = 'Franz Müller'
Delete from Application.People where PersonID = (select PersonID from Application.People where FullName = 'Franz Müller')

-- Aufgabe 5.1

SELECT *
INTO DeliveryMethodsNew
FROM Application.DeliveryMethods;

SELECT *
INTO DeliveryMethodsUpdate
FROM DeliveryMethodsNew;

select * from DeliveryMethodsUpdate
insert into DeliveryMethodsUpdate (DeliveryMethodID, DeliveryMethodName, LastEditedBy, ValidFrom, ValidTo) values 
(11, 'Velokurier', 1,  GETDATE(), '23:59:59.9999999'),
(12, 'Beaming', 1,  GETDATE(), '23:59:59.9999999');


Update DeliveryMethodsUpdate set DeliveryMethodName = 'DHL', ValidFrom = GETDATE() where DeliveryMethodID = 1;

select * from DeliveryMethodsUpdate
select * from DeliveryMethodsNew

Merge DeliveryMethodsNew as target
using DeliveryMethodsUpdate as Source
on  (target.DeliveryMethodID =  source.DeliveryMethodID)
when matched
then update set target.DeliveryMethodName = source.DeliveryMethodName, target.lasteditedby = source.lasteditedby, target.validto = source.validto, target.validfrom = source.validfrom
when not matched by target
then insert (DeliveryMethodID, DeliveryMethodName, LastEditedBy, Validfrom, Validto) values (source.DeliveryMethodID, source.DeliveryMethodName, source.LastEditedBy, source.Validfrom, source.Validto)
when not matched by source
then delete;

select * from DeliveryMethodsUpdate
select * from DeliveryMethodsNew

select   LastEditedBy ,count(LastEditedBy) from DeliveryMethodsNew
group by LastEditedBy