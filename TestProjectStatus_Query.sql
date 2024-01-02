use ProjectWebApp_Prod
go
declare @fiscalyear date

set @fiscalyear = cast(getdate() as date)

SELECT DISTINCT 
                         GETDATE() AS Expr1
						 , p.ProjectUID 
						 , dbo.fnc_FiscalYear(@fiscalyear) AS FiscalYear
						 ,P.ProjectName 
						 , isnull(P.[Project Status], 'NA') as [Project Status]
						 , P.[Project Stage] 
						 , pStatus = case
							
							when ([Project Status] = '06 Evaluation' AND [Project Stage]= '01 Initiate' ) then 'Evaluate'
							when ([Project Status] = '06 Evaluation' AND [Project Stage]='00 Evaluate' ) then 'Evaluate'
							when ([Project Status] = '06 Evaluation' AND [Project Stage]='02 Plan' ) then 'Evaluate'
							when ([Project Status] = '06 Evaluation' AND [Project Stage]='03 Execute' ) then 'Evaluate'
							when ([Project Status] = '02 In Progress' AND [Project Stage]='01 Initiate') THEN 'In Progress'
							when ([Project Status] = '02 In Progress' AND [Project Stage]='00 Evaluate') THEN 'In Progress'
							when ([Project Status] = '02 In Progress' AND [Project Stage]= '02 Plan') THEN 'In Progress'
							when ([Project Status] = '02 In Progress' AND [Project Stage]= '03 Execute') THEN 'In Progress'
							when ([Project Status] = '02 In Progress' AND [Project Stage]='04 Close') Then 'Closing'
							when ([Project Status] = '03 Completed') Then 'Completed'
							when ([Project Status] = '04 On Hold') Then 'On Hold'
							when ([Project Status] = '01 Scheduled') Then 'Scheduled'
							when ([Project Status] = '05 Cancelled') Then 'Cancelled'
							else 'No Status'
							end
						 , P.ProjectStartDate 
						 , P.ProjectFinishDate 
						 , EPT.EnterpriseProjectTypeName
						 , P.ProjectOwnerName 
						 , T.TaskName
						 , T.TaskFinishDate
						 , T.TaskBaseline0FinishDate
						 , T.[Go Live Date] as [Go Live Date]
						 , P.ProjectOwnerResourceUID as [ProjectOwnerResourceUID]
						 , P.Program
						 , ISNULL(P.[Organization and Alignment], 'z_NA') AS [Organization and Alignment]
FROM            (SELECT        ProjectUID, TaskName, [Go Live Date], TaskFinishDate, TaskBaseline0FinishDate
                          FROM            MSP_EpmTask_UserView
                          WHERE        ([Go Live Date] = 'Yes')) AS T RIGHT OUTER JOIN
                         MSP_EpmProject_UserView AS P ON T.ProjectUID = P.ProjectUID INNER JOIN
                         MSP_EpmEnterpriseProjectType AS EPT ON EPT.EnterpriseProjectTypeUID = P.EnterpriseProjectTypeUID
WHERE        (P.ProjectFinishDate >= '07/01/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear))) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1)) OR
                         (P.ProjectFinishDate >= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1))
						 ORDER BY /*P.ProjectName, P.[Project Status],P.[Project Stage]*/ pStatus
