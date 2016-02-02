 use master
 if exists
 (SELECT name from sys.Databases where Name='PartitionTest2')
Begin
Drop Database PartitionTest2
End

Create database PartitionTest2
go

Go
Alter Database PartitionTest2
Add filegroup Year2012
go
Alter Database PartitionTest2
Add file
(
 name ='Year2012',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Year2012.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup Year2012


Alter database PartitionTest2
Add FileGroup Year2013;
Go
Alter Database PartitionTest2
Add file 
(
 name ='Year2013',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Year2013.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup Year2013

 
Alter database PartitionTest2
Add FileGroup Year2014;
Go
Alter Database PartitionTest2
Add file 
(
 name ='Year2014',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Year2014.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup Year2014

 Alter database PartitionTest2
Add FileGroup Year2015;
Go

Alter Database PartitionTest2
Add file 
(
 name ='Year2015',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Year2015.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup Year2015
 Go

 Alter database PartitionTest2
 Add FileGroup Year2011
Go

Alter Database PartitionTest2
Add file 
(
 name ='Year2011',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Year2011.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup Year2011
 Go

 use PartitionTest2
--create partition function
Create Partition Function Fx_BusRouteShiftAssignmentDate (date)
As range left 
For values (
'20121231', 
'20131231', 
'20141231', 
'20151231'
)
go

--Create partition Schema
create partition scheme sch_BusRouteShiftAssignmentDate
As Partition fx_BusRouteShiftAssignmentDate
to (Year2011,Year2012, Year2013, Year2014,Year2015)



 CREATE TABLE [dbo].[BusScheduleAssignment](
	[BusScheduleAssignmentKey] [int]  NOT NULL,
	[BusDriverShiftKey] [int] NULL,
	[EmployeeKey] [int] NULL,
	[BusRouteKey] [int] NULL,
	[BusScheduleAssignmentDate] [date] NOT NULL,
	[BusKey] [int] NULL)

	on sch_BusRouteShiftAssignmentDate(BusScheduleAssignmentDate)

	Insert into BusScheduleAssignment(BusScheduleAssignmentKey, BusDriverShiftKey, EmployeeKey, BusRouteKey, BusScheduleAssignmentDate, BusKey)


	Select BusScheduleAssignmentKey,BusDriverShiftKey, EmployeeKey, BusRouteKey, BusScheduleAssignmentDate, BusKey
	From MetroAlt.dbo.BusScheduleAssignment


--partition queries
	Select*From BusScheduleAssignment

--2012
	Select*From BusScheduleAssignment
	where $partition.fx_BusRouteShiftAssignmentDate(BusScheduleAssignmentDate)=1

--2013
	Select*From BusScheduleAssignment
    where $partition.fx_BusRouteShiftAssignmentDate(BusScheduleAssignmentDate)=2

--2014
	Select*From BusScheduleAssignment
    where $partition.fx_BusRouteShiftAssignmentDate(BusScheduleAssignmentDate)=3

--2015
	Select*From BusScheduleAssignment
   where $partition.fx_BusRouteShiftAssignmentDate(BusScheduleAssignmentDate)=4

--etc.



 
