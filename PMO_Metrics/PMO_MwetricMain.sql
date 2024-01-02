use ProjectWebApp_Prod

GO

declare @fiscalyear date

SET @fiscalyear = '2015'

SELECT       dbo.fnc_FiscalYear(@fiscalyear) AS FiscalYear
			, P.ProjectUID
			, P.ProjectName
			, P.[Project Description]
			, R.Status AS RiskStatus
			, P.[Project Status Date]
			, T.TaskName
			, T.TaskStartDate
			, T.TaskFinishDate
			, T.TaskBaseline0FinishDate
			, T.TaskPercentCompleted
			, P.ProjectOwnerName
			, P.[PM Summary Score]
			, P.[Initiated by PSR]
			, P.[Go Live Date]
			, P.[CHOC EAC]
			, P.[Project Summary Comment]
			, P.[PM Summary Comment]
			, P.[Budget Status]
			, CASE 
				WHEN T.TaskFinishDate <= T.TaskBaseline0FinishDate THEN 1 
				ELSE 2 
			END AS test
FROM            MSP_EpmProject_UserView AS P 
				INNER JOIN MSP_EpmTask_UserView AS T 
				ON P.ProjectUID = T.ProjectUID 
				INNER JOIN MSP_WssRisk AS R 
				ON P.ProjectUID = R.ProjectUID
WHERE        (T.TaskIsMilestone = 1) AND (P.ProjectPercentCompleted = 100) and (P.ProjectFinishDate >= '07/01/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear))) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1)) OR
                         (P.ProjectFinishDate >= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1))