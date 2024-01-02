use ProjectWebApp_Prod
GO

SELECT     --DISTINCT
			p.ProjectName
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
				INNER JOIN (SELECT DISTINCT TaskUID
											, ProjectUID
											, ResourceUID
											, AssignmentUID
											 FROM MSP_EpmAssignment_UserView) AS a 
				ON p.ProjectUID = a.ProjectUID 
				INNER JOIN (SELECT ResourceUID
								, ResourceName
								, ResourceIsGeneric
								, [CHOC Resource Type]
								, ResourceStandardRate 
						FROM MSP_EpmResource_UserView) AS r 
				ON a.ResourceUID = r.ResourceUID 
				Left OUTER JOIN (SELECT * FROM MSP_EpmAssignmentByDay_UserView) AS abd 
				ON a.AssignmentUID = abd.AssignmentUID 
				LEFT OUTER JOIN (SELECT distinct TimeByDay, AssignmentUID, AssignmentBaselineWork FROM MSP_EpmAssignmentBaselineByDay) AS bbd 
				ON a.AssignmentUID = bbd.AssignmentUID 
				AND abd.TimeByDay = bbd.TimeByDay
WHERE        (r.[CHOC Resource Type] = 'Exempt' 
						OR r.[CHOC Resource Type] = 'Hourly')
						/****************exclude from cut and paste ***************/
						/*AND p.ProjectName = 'Case Management'
						and abd.TimeByDay >= '2015-01-18'
						and r.ResourceName = 'Anissa McIntyre'*/