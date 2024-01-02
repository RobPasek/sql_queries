Use ProjectWebApp_Prod
GO

Select
	 P.ProjectUID
	,ISNULL(P.[Overall Health], 'Not Selected') As [Overall Health]
	,ISNULL(P.[Project Status], 'Not Selected') As [Project Status]
	,ISNULL(p.[Project Stage], 'Not Selected') as [Project Stage]
	, [pStatus] = CASE 
		WHEN P.ProjectFinishDate > P.ProjectBaseline0FinishDate AND P.[Project Status] = ('02 In Progress') AND P.[Project Stage] NOT IN (('00 Evaluate'),('01 Initiate'),('02 Plan')) Then 'Behind'
		WHEN P.[Project Status] = ('02 In Progress') AND P.[Project Stage] = ('04 Close') THEN 'Closing'
		WHEN P.[Project Status] = ('06 Evaluation') THEN 'Evaluation'
		WHEN P.[Project Status] = ('05 Cancelled') THEN 'Cancelled'
		WHEN P.[Project Status] = ('01 Scheduled') THEN 'Scheduled'
		WHEN P.[Project Status] = ('03 Completed') THEN 'Completed'
		WHEN P.[Project Status] = ('04 On Hold') THEN 'OnHold'
		WHEN P.[Project Status] = ('02 In Progress') AND P.[Project Stage] IN (('03 Execute'),('00 Evaluate'),('01 Initiate'),('02 Plan')) THEN 'InProgress'
	END 
	,P.ProjectName
	,P.[Project Description]
	,ISNULL(P.[Project Category], 'Not Selected') As [Project Category]
	,ISNULL(P.ProjectOwnerName, 'Not Selected') AS ProjectOwnerName
	,P.ProjectStartDate
	,P.[project status date]
	,P.ProjectFinishDate
	,P.ProjectPercentCompleted
	,P.[project comment]
	,P.[Go Live Date]	
	,MVList.ProjectImpactValues
	,MVList1.BusinessOwnerValues
	, P.ProjectFinishDate
	,ISNULL(P.[Organization and Alignment], 'Not Selected') As [Organization and Alignment]
From (SELECT ProjectUID
		, ProjectName
		,[Project Description]
		,ISNULL([Project Category], 'Not Selected') As [Project Category]
		,ISNULL(ProjectOwnerName, 'Not Selected') AS ProjectOwnerName,ProjectStartDate
		, [Organization and Alignment]
		, [Project Status]
		, [Go Live Date]
		,[Project Stage]
		,[Overall Health]
		,ProjectBaseline0FinishDate
		,[project status date]
		,ProjectFinishDate
		,ProjectPercentCompleted
		,[project comment]	
	FROM  MSP_EpmProject_UserView) AS P
INNER JOIN
   (SELECT   MSP_EpmProject_UserView.ProjectUID 
            ,ISNULL(STUFF((SELECT ', '+ MemberValue 
    FROM [MSPLT_ProjectImpactLT_UserView] 
    INNER JOIN [MSPCFPRJ_Project Impact_AssociationView] 
	ON [MSPLT_ProjectImpactLT_UserView].LookupMemberUID = [MSPCFPRJ_Project Impact_AssociationView].LookupMemberUID
    WHERE [MSPCFPRJ_Project Impact_AssociationView].EntityUID = 
    MSP_EpmProject_UserView.ProjectUID 
    FOR XML PATH(''), TYPE
    ).value('.','varchar(max)')
    ,1,2, ''),'')AS ProjectImpactValues
FROM    MSP_EpmProject_UserView 
GROUP BY ProjectUID ) MVList
ON P.ProjectUID = MVList.ProjectUID 
INNER JOIN 
(SELECT   MSP_EpmProject_UserView.ProjectUID 
            ,ISNULL(STUFF((SELECT ', '+ MemberValue 
    FROM [MSPLT_BusinessOwnerLT_UserView] 
    INNER JOIN  [MSPCFPRJ_Business Owner_AssociationView]
	ON [MSPLT_BusinessOwnerLT_UserView].LookupMemberUID = [MSPCFPRJ_Business Owner_AssociationView].LookupMemberUID
    WHERE [MSPCFPRJ_Business Owner_AssociationView].EntityUID = 
    MSP_EpmProject_UserView.ProjectUID 
    FOR XML PATH(''), TYPE
    ).value('.','varchar(max)')
    ,1,2, ''),'')AS BusinessOwnerValues
FROM    MSP_EpmProject_UserView
GROUP BY ProjectUID ) AS MVList1
ON P.ProjectUID = MVList1.ProjectUID
/**/
Where P.ProjectName <> 'Timesheet Administrative Work Items'
order by P.ProjectName 