Use CommunityAssist

--create partition function
Create Partition Function Fx_Grantdate (dateTime)
As range left 
For values ('20130731', '20130831', '20141231')
go

--Create partition Schema
create partition scheme sch_GrantDate
As Partition fx_GrantDate
to (GrantAugust2013, GrantSeptember2013, Grant2014, GrantOverflow)



 CREATE TABLE [dbo].[ServiceGrant](
	[GrantKey] [int] IDENTITY(1,1) NOT NULL,
	[GrantAmount] [money] NULL,
	[GrantDate] [datetime] NULL,
	[PersonKey] [int] NULL,
	[ServiceKey] [int] NULL,
	[EmployeeKey] [int] NULL,
	[GrantReviewDate] [date] NULL,
	[GrantApprovalStatus] [nvarchar](10) NULL,
	[GrantNeedExplanation] [nvarchar](max) NULL,
	[GrantAllocation] [money] NULL
	)
	on sch_GrantDate(GrantDate)

	Insert into ServiceGrant(GrantAmount, GrantDate, PersonKey, SErviceKey, EmployeeKey, GrantReviewDate,   GrantApprovalStatus, GrantNeedExplanation, GrantAllocation)


	Select GrantAmount, GrantDate, PersonKey, SErviceKey, EmployeeKey, GrantReviewDate,   GrantApprovalStatus, GrantNeedExplanation, GrantAllocation
	From CommunityAssist.dbo.ServiceGrant

	Select*From ServiceGrant

	Select*From ServiceGrant
	where $partition.Fx_GrantDate(GrantDate)=2

====================================================================================



if exists
 (SELECT name from sys.Databases where Name='PartitionTest')
Begin
Drop Database PartitionTest
End

Create database PartitionTest
go
Alter database PartitionTest
Add FileGroup GrantAugust2013;
Go
Alter Database PartitionTest
Add file 
(
 name ='GrantAugust2013',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\GrantAugust2013.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup GrantAugust2013


Alter database PartitionTest
Add FileGroup GrantSeptember2013;
Go
Alter Database PartitionTest
Add file 
(
 name ='GrantSeptember2013',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\GrantSeptember2013.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup GrantSeptember2013

 
Alter database PartitionTest
Add FileGroup Grant2014;
Go
Alter Database PartitionTest
Add file 
(
 name ='Grant2014',
 FileName='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Grant2014.ndf',
 Size=5MB,
 MaxSize=200MB,
 FileGrowth=5mb
 )
 to filegroup Grant2014

 use PartitionTest
--create partition function
Create Partition Function Fx_Grantdate (dateTime)
As range left 
For values ('20130731', '20130831', '20141231')
go

--Create partition Schema
create partition scheme sch_GrantDate
As Partition fx_GrantDate
to (GrantAugust2013, GrantSeptember2013, Grant2014, GrantOverflow)



 CREATE TABLE [dbo].[ServiceGrant](
	[GrantKey] [int] IDENTITY(1,1) NOT NULL,
	[GrantAmount] [money] NULL,
	[GrantDate] [datetime] NULL,
	[PersonKey] [int] NULL,
	[ServiceKey] [int] NULL,
	[EmployeeKey] [int] NULL,
	[GrantReviewDate] [date] NULL,
	[GrantApprovalStatus] [nvarchar](10) NULL,
	[GrantNeedExplanation] [nvarchar](max) NULL,
	[GrantAllocation] [money] NULL
	)
	on sch_GrantDate(GrantDate)

	Insert into ServiceGrant(GrantAmount, GrantDate, PersonKey, SErviceKey, EmployeeKey, GrantReviewDate,   GrantApprovalStatus, GrantNeedExplanation, GrantAllocation)


	Select GrantAmount, GrantDate, PersonKey, SErviceKey, EmployeeKey, GrantReviewDate,   GrantApprovalStatus, GrantNeedExplanation, GrantAllocation
	From CommunityAssist.dbo.ServiceGrant

	Select*From ServiceGrant

	Select*From ServiceGrant
	where $partition.Fx_GrantDate(GrantDate)=2





