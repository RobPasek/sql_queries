USE ProjectWebApp_Prod
GO

SELECT        P.ProjectUID
			, P.ProjectName
			, P.[Project Description]
			, P.[Project Status Date]
			, T.TaskName
			, T.TaskDeadline
			, T.TaskStartDate
			, T.TaskFinishDate
			, T.TaskBaseline0FinishDate
			, T.TaskPercentCompleted, P.ProjectOwnerName, P.[PM Summary Score], P.[Initiated by PSR], T.[Go Live Date], P.[CHOC EAC], 
                         P.[Project Summary Comment], P.[PM Summary Comment], P.[Budget Status], CASE WHEN t .TaskFinishDate <= t .TaskDeadline THEN 1 ELSE 2 END AS test, 
                         P.[Project Summary Score]
FROM            MSP_EpmProject_UserView AS P INNER JOIN
                         MSP_EpmTask_UserView AS T ON P.ProjectUID = T.ProjectUID LEFT OUTER JOIN
                         MSP_WssRisk AS R ON P.ProjectUID = R.ProjectUID
WHERE        (T.TaskIsMilestone = 1) AND (P.ProjectName <> 'Timesheet Administrative Work Items')
AND (P.ProjectName = 'ICD10 Transition')