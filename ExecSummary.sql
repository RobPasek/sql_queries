USE ProjectWebApp_Prod
GO

SELECT        P.ProjectName
			, P.ProjectOwnerName
			, P.ProjectStartDate
			, P.ProjectFinishDate
			, P.ProjectModifiedDate
			, P.[CHOC EAC]
			, P.[CHOC Variance]
			, P.ProjectUID
			, P.ProjectBaseline0StartDate
			, P.ProjectBaseline0FinishDate
			, P.ProjectBaseline0Duration
			, P.ProjectBaseline0Work
			, P.[Budget Performance]
			, CASE 
				WHEN P.[Project Status] = '01 Scheduled' THEN 'Scheduled' 
				WHEN P.[Project Status] = '02 In Progress' THEN 'In Progress' 
				WHEN P.[Project Status] = '03 Completed' THEN 'Completed' 
				WHEN P.[Project Status] = '04 On Hold' THEN 'On Hold' 
				WHEN P.[Project Status] = '05 Cancelled' THEN 'Cancelled' 
				WHEN P.[Project Status] = '06 Evaluation' THEN 'Evaluation' 
				ELSE P.[Project Status] 
			END AS [Project Status]
			, P.[Project Stage]
			, P.[Total Budget]
			, P.Actuals
			, T .[Go Live Date]
			, T .TaskBaseline0FinishDate
			, T .TaskFinishDate
			, T.TaskActualFinishDate
			, P.[Project Comment]
			, ISNULL(IP.PrioritySum, 999) AS PrioritySum
FROM            (SELECT        TaskName, TaskStartDate, TaskFinishDate, [Go Live Date], ProjectUID, TaskBaseline0FinishDate, TaskActualFinishDate
                          FROM            MSP_EpmTask_UserView AS TA
                          WHERE        ([Go Live Date] = 'Yes')) AS T RIGHT OUTER JOIN
                         MSP_EpmProject_UserView AS P ON T .ProjectUID = P.ProjectUID LEFT JOIN
                             (SELECT        I.ProjectUID, SUM(IIF(I.Priority = '(0) Critical', 1000, IIF(I.Priority = '(2) High', 1, 0))) AS [PrioritySum]
                               FROM            MSP_WssIssue I
                               GROUP BY i.ProjectUID) AS IP ON IP.ProjectUID = P.ProjectUID