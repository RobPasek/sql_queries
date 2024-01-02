SELECT        P.ProjectName
			, P.ProjectUID
			, M.TaskName
			, M.TaskStartDate
			, M.TaskFinishDate
			, M.TaskDeadline
			, M.[Major Milestone]
			, M.TaskIsMilestone
			, M.[Status Notes]
			, M.TaskPercentCompleted
FROM            MSP_EpmProject_UserView AS P 
			INNER JOIN MSP_EpmTask_UserView AS M 
			ON P.ProjectUID = M.ProjectUID
WHERE        (M.TaskIsMilestone = 1)
		--AND (M.TaskStartDate <= GETDATE() - 1) 
		--AND (M.TaskFinishDate >= GETDATE() - 1) 
		--AND (M.TaskFinishDate <= GETDATE() + 90) 
		AND (M.TaskPercentCompleted <= 100) 
		AND (M.[Major Milestone] = 'Yes') 
		OR  (M.TaskIsMilestone = 1) 
		--AND (M.TaskStartDate <= GETDATE() + 90) 
		AND (M.TaskPercentCompleted <= 100) 
		AND (M.[Major Milestone] = 'Yes')