use ProjectWebApp_Prod
GO

SELECT        P.ProjectName
			, P.ProjectUID
			, M.TaskName
			, M.TaskStartDate
			, M.TaskFinishDate
			, M.TaskActualFinishDate
			, M.TaskDeadline
			, M.[Major Milestone]
			, M.TaskIsMilestone
			, M.[Status Notes]
			, M.TaskPercentCompleted
FROM        (select ProjectName, ProjectUID   FROM MSP_EpmProject_UserView) AS P 
			INNER JOIN(select ProjectUID, TaskName, TaskStartDate, TaskFinishDate
						, TaskActualFinishDate, TaskDeadline, [Major Milestone]
						, TaskIsMilestone, [Status Notes], TaskPercentCompleted 
						from 			MSP_EpmTask_UserView 
						where TaskIsActive = 1) AS M 
			ON P.ProjectUID = M.ProjectUID
WHERE   P.ProjectName = 'ICD10 Transition'
		AND (M.TaskIsMilestone = 1)
		AND (M.TaskPercentCompleted <= 100) 
		AND (M.[Major Milestone] = 'Yes') 
		OR  (M.TaskIsMilestone = 1) 
		AND (M.TaskPercentCompleted <= 100) 
		AND (M.[Major Milestone] = 'Yes')
		
		
		GO