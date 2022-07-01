-- Aufgabe 1

USE [master]
RESTORE DATABASE [soundlib] FROM  DISK = N'C:\SQLRestore\soundlib.bak' WITH  FILE = 1,  MOVE N'soundlib' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\soundlib.mdf',  MOVE N'soundlib_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\soundlib_log.LDF',  NOUNLOAD,  STATS = 5

GO


-- Aufgabe 2

select 'Ich Mateusz Wnuk, habe am 01.02.2004 Geburtstag!' as 'About me'


-- Aufgabe 3
use soundlib
select * from Playlist
select * from Track

select * from Artist

select * from Track


-- Aufgabe 4

select * from track

select Name, Composer, 
(case
--  1 GB = 2 hoch 30 = 1073741824
when Bytes >= 1073741824 then 'sehr grosse Datei'
when Bytes >= 104857600 and Bytes < 1073741824 then 'grosse Datei'
when Bytes >= 10485760 and Bytes < 104857600 then 'mittlere Datei'
else 'kleine Datei'
end
) as 'Datei Grösse'

from Track


-- Aufgabe 5
Insert into Playlist (Name) values ('Gringo')

select * from Playlist
select * from Track
select * from PlaylistTrack

Insert into PlaylistTrack (PlaylistId,TrackId)
select 19, TrackId from Track where Track.AlbumId in (1,2,3)


-- Aufgabe 6

Select * from Artist
where left(name,1) not in ('a','e','i','o','u','A','E','I','O','U') and right(name, 2) = 'on'


-- Aufgabe 7
use master 
Create login Mateusz with password = '1234', check_policy = off

use soundlib
create user Mateusz for login Mateusz

Grant Delete on Playlisttrack to Mateusz
Grant Update on Playlist to Mateusz
Grant Insert on Customer to Mateusz
Grant select on Track to Mateusz
Grant select on PlaylistTrack to Mateusz
Grant select on Playlist to Mateusz

Deny Delete,Insert,Update,Select on Invoice to Mateusz


-- Aufgabe 8

select * from Invoice
Alter table Invoice
alter column Total add masked with (Function = 'default()');


-- Aufgabe 9

Alter Table Customer add constraint CheckEmail check(email like '%@%.%')

alter table employees add valuation char(1) check(valuation like '[A-D]') default ('B') not null

select * from Employee




-- Aufgabe 11

select * from Employee
select 
case
when MONTH(BirthDate) > MONTH(GETDATE()) or (MONTH(BirthDate) = MONTH(GETDATE()) and DAY(BirthDate) > DAY(GETDATE()))  THEN datediff(year,birthdate,getdate())-1  
else datediff(year,birthdate,getdate())
end as 'Jahrgang'
from Employee

select  AVG(datediff(year,birthdate,getdate())) as'Jahrgang durchschnitt'
from Employee




select  (MONTH(BirthDate) - MONTH(GETDATE())) from Employees

-- Aufgabe 12
select * from Invoice

Alter table Invoice add Rechnungsstatus varchar(10) check (Rechnungsstatus in ('offen','bezahlt')) default ('offen') not null

alter table employees add valuation char(1) check(valuation like '[A-D]') default ('B') not null

-- Aufgabe 13

select * from Invoice

select distinct Customer.CustomerId,Customer.Company, Customer.FirstName, Customer.Address, Customer.PostalCode, Customer.City from Customer
join Invoice on Customer.CustomerId = Invoice.CustomerId
where InvoiceDate between '20090101' and '20090630'
order by Customer.Company 


-- Aufgabe 14

select distinct LastName from Customer
order by LastName desc

-- Aufgabe 15
select * from Invoiceline
Select * from Invoice

select track.* from Track 
left join InvoiceLine on track.TrackId = InvoiceLine.TrackId
where InvoiceLine.TrackId is null



-- Aufgabe 16
select * from Album
Create index Albumtitle on Album (title)

-- Aufgabe 17
Select c.CustomerId, c.Company, count(*) as 'Anzahl Bestellungen' from customer c
join invoice i on c.CustomerId = i.CustomerId
where c.Company is not null
group by c.CustomerId, c.Company
having count(*) >= 10

select customer.CustomerId,customer.Company ,count(*) from Invoice
join Customer on Customer.CustomerId = Invoice.CustomerId
group by customer.CustomerId, Customer.Company
having count(*) >= 10


-- Aufgabe 18
create view Firmenkunden as
Select c.Company, i.InvoiceId, i.InvoiceDate, i.Total from customer c
join invoice i on c.CustomerId = i.CustomerId
where c.Company is not null

select * from Firmenkunden

-- Aufgabe 19
select * from MediaType
select Track.Name from track
join MediaType on track.MediaTypeId = MediaType.MediaTypeId
where MediaType.MediaTypeId = 3


-- Aufgabe 20

select City from Customer
except
select BillingCity from Invoice

-- Aufgabe 21

alter table Customer add Firmenkunde bit 

update Customer set Firmenkunde = 1 where customer.Company is not null
update Customer set Firmenkunde = 0 where customer.Company is null

select * from Customer


-- Aufgabe 22

select * from Artist

Insert into Artist (Name) values ('Quebonafide')


-- Aufgabe 23

select * from Track
select count(*) as ' Anzahl von Songs' from Track


-- Aufgabe 24
select * from Employee

select FirstName, LastName from Employee
where HireDate < '20040102'

-- Aufgabe 25

select * from Employee
select * from Customer

Update Employee set Title = 'Sales Support Agent' where EmployeeId = 7
Update Customer set SupportRepId = 7 where SupportRepId = 5

begin try
	Begin transaction
	Delete from Employee where EmployeeId = 5
	commit transaction
end try

begin catch
	rollback transaction
end catch

-- Aufgabe 3

select * from PlaylistTrack

select track.Composer + ' - ' + track.Name as 'Interpret - Song',count(*) as 'Vorkommen in Playlists' from PlaylistTrack
join Track on track.TrackId = PlaylistTrack.TrackId
where track.Composer + ' - ' + track.Name is not null
group by track.Composer + ' - ' + track.Name
order by count(*) desc


select track.Name + track.Composer,count(*) as 'Vorkommen in Playlists' from PlaylistTrack
join Track on track.TrackId = PlaylistTrack.TrackId
group by track.Name + track.Composer
order by count(*) desc

-- Aufgabe 10
use soundlib
go
select * from Employee
Update Employee set HireDate = DATEADD(day, 1, HireDate)






