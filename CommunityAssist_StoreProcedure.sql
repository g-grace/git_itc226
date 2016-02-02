use CommunityAssist 
Select 
PersonFirstName, 
PersonLastName,
Street, 
City,
Zip,
ContactInfo,
GrantDate,
GrantAmount,
gr.GrantReviewDate,
GrantApprovalStatus,
GrantAllocation,
GrantReviewNote
From Person p
inner Join personAddress pa
on p.PersonKey=pa.PersonKey
inner join PersonContact pc
on p.PersonKey=pc.PersonKey
inner Join ServiceGrant sg
on p.PersonKey=sg.PersonKey
inner join GrantReview gr
on sg.GrantKey=gr.GrantKey
Where GrantApprovalStatus='denied'
or GrantApprovalStatus='Reduced'


Create index ix_Approval on ServiceGrant(GrantApprovalStatus)


use CommunityAssist 
Select 
PersonFirstName, 
PersonLastName,
Street, 
City,
Zip,
ContactInfo,
GrantDate,
GrantAmount,
gr.GrantReviewDate,
GrantApprovalStatus,
GrantAllocation,
GrantReviewNote
From Person p
inner Join personAddress pa
on p.PersonKey=pa.PersonKey
inner join PersonContact pc
on p.PersonKey=pc.PersonKey
inner Join ServiceGrant sg with (nolock, index (ix_Approval))
on p.PersonKey=sg.PersonKey
inner join GrantReview gr
on sg.GrantKey=gr.GrantKey
Where GrantApprovalStatus='denied'
or GrantApprovalStatus='Reduced'


Create Proc usp_TextProcedure
As
Select 
PersonFirstName, 
PersonLastName,
Street, 
City,
Zip,
ContactInfo,
GrantDate,
GrantAmount,
gr.GrantReviewDate,
GrantApprovalStatus,
GrantAllocation,
GrantReviewNote
From Person p
inner Join personAddress pa
on p.PersonKey=pa.PersonKey
inner join PersonContact pc
on p.PersonKey=pc.PersonKey
inner Join ServiceGrant sg with (nolock, index (ix_Approval))
on p.PersonKey=sg.PersonKey
inner join GrantReview gr
on sg.GrantKey=gr.GrantKey
Where GrantApprovalStatus='denied'
or GrantApprovalStatus='Reduced'

exec usp_TextProcedure




 
 
 
 
 
 
 
 
 








