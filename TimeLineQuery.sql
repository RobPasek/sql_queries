USE [ProjectWebApp_Prod]
GO

declare @fiscalyear as date
set @fiscalyear = '2015'

SELECT GETDATE() AS Expr1
				, dbo.fnc_FiscalYear(@fiscalyear) AS FiscalYear
				, P.ProjectUID
				, P.ProjectName
				, [pStatus] = CASE 
					WHEN EnterpriseProjectTypeName = 'Evaluation' THEN 'Proposal' 
					WHEN EnterpriseProjectTypeName <> 'Evaluation'AND P.ProjectFinishDate > isNull(p.ProjectBaseline0FinishDate, '2012-01-01') AND P.[Project Status] IN (('02 In Progress')/*,('04 Close'),('00 Evaluate')*/) AND P.[Project Status] not IN ('00 Evaluate') AND P.[Project Stage]  not in ('04 Close') Then 'Behind'
					WHEN P.[Project Status] = ('02 In Progress') AND P.[Project Stage] = ('04 Close') THEN 'Closing'
					WHEN P.[Project Status] = ('06 Evaluation') /*AND P.[Project Stage] not in ('00 Evaluate','01 Initiate') or P.[Project Stage] = '00 Evaluate'*/ THEN 'Proposal'
					WHEN P.[Project Status] = ('05 Cancelled') THEN 'Cancelled'
					WHEN P.[Project Status] = ('01 Scheduled') THEN 'Scheduled'
					WHEN P.[Project Status] = ('03 Completed') THEN 'Completed'
					WHEN P.[Project Status] = ('04 On Hold') AND P.[Project Stage] in ('00 Evaluate','01 Initiate') THEN 'OnHold'
					WHEN P.[Project Status] = ('02 In Progress') AND P.[Project Stage] IN (('03 Execute'),('00 Evaluate'),('01 Initiate'),('02 Plan')) THEN 'InProgress'
				END
				, P.[Project Status]
				, P.[Project Stage]
				, P.ProjectStartDate
				, P.ProjectFinishDate
				, p.ProjectBaseline0FinishDate
				, p.ProjectActualFinishDate
				, EPT.EnterpriseProjectTypeName
				, P.ProjectOwnerName
				, P.[Go Live Date]
				, P.ProjectOwnerResourceUID
				, P.Program
				, ISNULL(P.[Organization and Alignment], 'z_NA') AS [Organization and Alignment]

FROM			(SELECT ProjectUID ,ProjectName,[Project Status],[Project Stage],ProjectStartDate,ProjectFinishDate, [Go Live Date], ProjectOwnerResourceUID
						, program, ProjectOwnerName, [Organization and Alignment], EnterpriseProjectTypeUID, ProjectActualFinishDate, ProjectBaseline0FinishDate
				 FROM MSP_EpmProject_UserView) as p             
	
				  INNER JOIN MSP_EpmEnterpriseProjectType AS EPT 
				  ON EPT.EnterpriseProjectTypeUID = P.EnterpriseProjectTypeUID
				  WHERE (P.ProjectFinishDate >= '07/01/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear))) 
					AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) 
					OR (P.ProjectFinishDate >= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) 
					AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1))
					
ORDER BY [pStatus]







