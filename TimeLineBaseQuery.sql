use ProjectWebApp_Prod
GO

declare @fiscalyear date

SET @fiscalyear = '2015'

SELECT DISTINCT GETDATE() AS Expr1
				, dbo.fnc_FiscalYear(@fiscalyear) AS FiscalYear
				, P.ProjectName
				, [pStatus] = CASE 
					--WHEN P.[Project Status] = ('02 In Progress') AND P.[Project Stage] IN (('03 Execute'),('00 Evaluate'),('01 Initiate'),('02 Plan')) THEN 'InProgress'
					WHEN T.[Go Live Date] = 'Yes' AND T.TaskFinishDate > T.TaskBaseline0FinishDate AND P.[Project Status] = ('02 In Progress') AND P.[Project Stage] NOT IN (('00 Evaluate'),('01 Initiate'),('02 Plan')) Then 'Behind'
					WHEN P.[Project Status] = ('02 In Progress') AND P.[Project Stage] = ('04 Close') THEN 'Closing'
					WHEN P.[Project Status] = ('06 Evaluation') THEN 'Evaluation'
					WHEN P.[Project Status] = ('05 Cancelled') THEN 'Cancelled'
					WHEN P.[Project Status] = ('01 Scheduled') THEN 'Scheduled'
					WHEN P.[Project Status] = ('03 Completed') THEN 'Completed'
					WHEN P.[Project Status] = ('04 On Hold') THEN 'OnHold'
					WHEN P.[Project Status] = ('02 In Progress') AND P.[Project Stage] IN (('03 Execute'),('00 Evaluate'),('01 Initiate'),('02 Plan')) THEN 'InProgress'
					--else 'InProgress' --'Behind'
				END
				, P.[Project Status]
				, P.[Project Stage]
				, P.ProjectStartDate
				, P.ProjectFinishDate
				, EPT.EnterpriseProjectTypeName
				, P.ProjectOwnerName
				, T.TaskName
				, T.TaskFinishDate
				, T.TaskBaseline0FinishDate
				, T.[Go Live Date]
				, P.ProjectOwnerResourceUID
				, P.Program
				, ISNULL(P.[Organization and Alignment], 'z_NA') AS [Organization and Alignment]

FROM            (SELECT ProjectUID
						, TaskName
						, [Go Live Date]
						, TaskFinishDate
						, TaskBaseline0FinishDate
                  FROM MSP_EpmTask_UserView
                  WHERE ([Go Live Date] = 'Yes')) AS T 
				  RIGHT OUTER JOIN MSP_EpmProject_UserView AS P 
				  ON T.ProjectUID = P.ProjectUID 
				  INNER JOIN MSP_EpmEnterpriseProjectType AS EPT 
				  ON EPT.EnterpriseProjectTypeUID = P.EnterpriseProjectTypeUID

WHERE (P.ProjectFinishDate >= '07/01/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear))) 
AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) 
OR (P.ProjectFinishDate >= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) 
AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1))