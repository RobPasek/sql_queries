USE ProjectWebApp_Prod
GO

SELECT       p.projectspi
			,p.projectcpi
			, P.ProjectUID
			, P.ProjectName
			--, ISNULL(P.Program, 'Not Selected') AS Program
			, P.ProjectOwnerName
			, CASE 
				WHEN P.[Project Status] = '01 Scheduled' THEN 'Scheduled' 
				WHEN P.[Project Status] = '02 In Progress' THEN 'In Progress' 
				WHEN P.[Project Status] = '03 Completed' THEN 'Completed' 
				WHEN P.[Project Status] = '04 On Hold' THEN 'On Hold' 
				WHEN P.[Project Status] = '05 Cancelled' THEN 'Cancelled' 
				WHEN P.[Project Status] = '06 Evaluation' THEN 'Evaluation' 
				WHEN P.[Project Status] is Null  THEN 'Not Selected' 
			  ELSE P.[Project Status] 
			  END AS [Project Status]
			  /*, P.ProjectStartDate
			  , P.ProjectFinishDate
			  , P.ProjectPercentCompleted
			  , ISNULL(P.[Organization and Alignment], 'Not Selected')AS [Organization and Alignment]
			  , ISNULL(P.[Overall Health], 'Not Selected') AS [Overall Health]
			  , P.[Project Description]
			  , T .TaskFinishDate
			  , P.[Budget Status]
			  , P.ProjectDescription
			  --, IP.PrioritySum
			  --, RP.RiskSum
			  , T .TaskBaseline0FinishDate
			  , P.[project status date]
			  , p.[project comment]
			  --, MVList1.BusinessOwnerValues*/
FROM            (SELECT TaskName
						, TaskStartDate
						, TaskFinishDate
						, [Go Live Date]
						, ProjectUID
						, TA.TaskBaseline0FinishDate
                  FROM MSP_EpmTask_UserView AS TA
                  WHERE ([Go Live Date] = 'Yes')) AS T 
				  RIGHT OUTER JOIN MSP_EpmProject_UserView AS P 
				  ON T .ProjectUID = P.ProjectUID 
				 INNER JOIN (SELECT MSP_EpmProject_UserView.ProjectUID
									, ISNULL(STUFF((SELECT ', ' + MemberValue
                              FROM [MSPLT_BusinessOwnerLT_UserView] 
							  INNER JOIN [MSPCFPRJ_Business Owner_AssociationView] 
							  ON [MSPLT_BusinessOwnerLT_UserView].LookupMemberUID = [MSPCFPRJ_Business Owner_AssociationView].LookupMemberUID
                              WHERE [MSPCFPRJ_Business Owner_AssociationView].EntityUID = MSP_EpmProject_UserView.ProjectUID FOR XML PATH('')
							  , TYPE ).value('.', 'varchar(max)'), 1, 2, ''), '') AS BusinessOwnerValues
                              FROM            MSP_EpmProject_UserView
                              GROUP BY ProjectUID) MVList1 ON P.ProjectUID = MVList1.ProjectUID 
							  LEFT JOIN (SELECT        I.ProjectUID	
												, SUM(IIF(I.Priority = '01 Critical'
												, 1000, IIF(I.Priority = '02 High', 1, 0))) AS [PrioritySum]
                               FROM            MSP_WssIssue I
                               GROUP BY i.ProjectUID) AS IP ON IP.ProjectUID = P.ProjectUID LEFT JOIN
                             (SELECT        R.ProjectUID, SUM(IIF(R.Exposure > 7.5, 1000, IIF(R.Exposure > 5 AND R.Exposure < 7.5, 1, 0))) AS [RiskSum]
                               FROM            MSP_WssRisk R
                               GROUP BY R.ProjectUID) AS RP ON RP.ProjectUID = P.ProjectUID