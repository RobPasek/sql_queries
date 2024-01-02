USE ProjectWebApp_Prod
GO


SELECT      DISTINCT  P.ProjectName
			, P.ProjectUID
			, T.TaskName
			, T.TaskStartDate
			, P.[CHOC EAC]
			, T.TaskFinishDate AS GoLiveDate
			, T.TaskBaseline0FinishDate
FROM            MSP_EpmProject_UserView AS P INNER JOIN
                         MSP_EpmTask_UserView AS T ON P.ProjectUID = T.ProjectUID
WHERE        (T.[Go Live Date] = 'Yes')
AND (P.ProjectName = 'CCMH Integration - Meditech Regionalization')--@Projlist)