USE ProjectWebApp_Prod
GO


SELECT     p.ProjectName
			, r.ResourceName
			, DATEPART(year, abd.TimeByDay) AS Yr
			, DATEPART(month, abd.TimeByDay) AS Mth
			, abd.TimeByDay AS AssnWorkDate
			, abd.AssignmentWork AS [Planned Hours]
			, abd.AssignmentActualWork AS [Actual Hours]
			, abd.AssignmentActualCost AS [Actual Cost]
			, ISNULL(bbd.AssignmentBaselineWork, 0) AS BaselineWork
			, p.[Activity Code]
			, p.[Project Status]
			, p.[Budget Type]
			, r.ResourceIsGeneric
			, r.[CHOC Resource Type]
			, r.ResourceStandardRate
			, a.TaskUID
FROM            MSP_EpmProject_UserView AS p 
				inner JOIN (SELECT DISTINCT TaskUID
											, ProjectUID
											, ResourceUID
											, AssignmentUID FROM MSP_EpmAssignment_UserView) AS a 
				ON p.ProjectUID = a.ProjectUID 
				inner JOIN (SELECT ResourceUID
								, ResourceName
								, ResourceIsGeneric
								, [CHOC Resource Type]
								, ResourceStandardRate 
						FROM MSP_EpmResource_UserView) AS r 
				ON a.ResourceUID = r.ResourceUID 
				inner JOIN MSP_EpmAssignmentByDay_UserView AS abd 
				ON a.AssignmentUID = abd.AssignmentUID 
				LEFT OUTER JOIN MSP_EpmAssignmentBaselineByDay AS bbd 
				ON a.AssignmentUID = bbd.AssignmentUID 
				AND abd.TimeByDay = bbd.TimeByDay
WHERE        (r.[CHOC Resource Type] = 'Exempt' 
						OR r.[CHOC Resource Type] = 'Hourly')
						AND r.ResourceName = 'Buffy Schnurbusch'
						AND p.ProjectName = 'EHR FY15 Deployment'
						--AND p.[Project Status] = '02 In Progress'
						AND DATEPART(year, abd.TimeByDay) = 2014
						AND DATEPART(month, abd.TimeByDay) >=10
						AND abd.TimeByDay between '2014-10-26 00:00:00.000' AND '2014-11-08 00:00:00.000'
						
ORDER BY /*r.ResourceName, p.ProjectName, Yr, Mth,*/ AssnWorkDate--, p.[Project Status]