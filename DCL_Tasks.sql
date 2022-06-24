use master 
Create login ethan with password = 'WWI4eth', check_policy = off

use WideWorldImporters
create user ethan for login ethan

 ALTER Role db_datareader add Member ethan