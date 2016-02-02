CREATE DATABASE ROLE
Select * From Person
inner Join Employee
on Person.PersonKey=Employee.PersonKey

Create Schema CustomerSchema
Create view EmployeeSchema.TestView
As
Select* From Employee

Create view EmployeeSchema.Customers
As 
Select PersonLastName,
PersonFirstName,
PersonUserName
From Person p
inner Join Service sg
on p.Pesonkey = sg.PersonKey

HUMAN RESOURCES ROLE
Select * 
From Person p
Inner Join Employee e
on p.PersonKey =e.PersonKey

-- User ==> Login Level.... Login ==> Server Level
Create Login TinaMoon with
password= 'password'

-- Create SCHEMA
Create schema EmployeeSchema

-- Create USER/LOGIN
Create user TinaMoon for Login TinaMoon

--Create ROLE
Create role HumanResourcesRole

Grant select, insert, update on Employee to HumanResourcesRole 

Grant Select, insert, update on Person to HumanResourcesRole

Grant select, insert, update on PersonAddress to HumanResourcesRole

Grant select, insert, update on PersonContact to HumanResourcesRole

Grant exec on usp_newDonation to HumanResourcesRole

Grant Select on Schema::EmployeeSchema to HumanResourcesRole

--Add User to the Role
exec sp_addrolemember
'HumanResourcesRole', 'TinaMoon'

 



