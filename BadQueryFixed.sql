use ProjectWebApp_Prod
GO


SELECT    distinct P.ProjectName    
			, P.ProjectUID 
			, P.[Project Description]
			, P.[CHOC EAC]
			,/* MAX*/(T.TaskFinishDate) AS GoLiveDate
			, P.[Budget Status]
			
FROM            MSP_EpmProject_UserView AS P 
INNER JOIN MSP_EpmTask_UserView AS T 
	ON P.ProjectUID = T.ProjectUID 
LEFT OUTER JOIN MSP_WssRisk AS R 
ON P.ProjectUID = R.ProjectUID
WHERE (P.ProjectName = 'ICD10 Transition')--@Projlist)
/*Group BY P.ProjectName    
			, P.ProjectUID 
			, P.[Project Description]
			, P.[CHOC EAC]
			--, MAX(T.TaskFinishDate) AS GoLiveDate
			, P.[Budget Status]*/