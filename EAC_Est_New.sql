use ProjectWebApp_Prod
go

SELECT    P.ProjectName    
			, P.ProjectUID 
			, P.[Project Description]
			, P.[CHOC EAC]
			, T.TaskFinishDate AS GoLiveDate
			, T.[Go Live Date] AS GL
			, P.[Budget Status]
			
FROM            MSP_EpmProject_UserView AS P 
INNER JOIN MSP_EpmTask_UserView AS T 
	ON P.ProjectUID = T.ProjectUID 
LEFT OUTER JOIN MSP_WssRisk AS R 
ON P.ProjectUID = R.ProjectUID
WHERE (T.[Go Live Date]='Yes')
--GROUP BY P.ProjectUID,T.[Go Live Date] , P.[Project Description], P.ProjectName, P.[CHOC EAC], T.TaskFinishDate, P.[Budget Status]