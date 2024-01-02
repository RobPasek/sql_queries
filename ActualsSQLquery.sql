USE ProjectWebApp_Prod
Go

SELECT        p.ProjectName
			, r.ResourceName
			, DATEPART(year, abd.TimeByDay) AS Yr
			, DATEPART(month, abd.TimeByDay) AS Mth
			, abd.TimeByDay AS AssnWorkDate
			, abd.AssignmentWork AS [Planned Hours]
			, abd.AssignmentActualWork AS [Actual Hours]
			, abd.AssignmentActualCost AS [Actual Cost]
			, bbd.AssignmentBaselineWork AS BaselineWork
			, p.[Activity Code]
			, p.[Project Status]
			, p.[Budget Type]
			, r.ResourceIsGeneric
			, r.[CHOC Resource Type]
			, r.ResourceStandardRate
			, a.TaskUID
FROM            MSP_EpmProject_UserView AS p 
			INNER JOIN MSP_EpmAssignment_UserView AS a 
			ON p.ProjectUID = a.ProjectUID 
			INNER JOIN MSP_EpmResource_UserView AS r 
			ON a.ResourceUID = r.ResourceUID 
			INNER JOIN MSP_EpmAssignmentByDay_UserView AS abd 
			ON a.AssignmentUID = abd.AssignmentUID 
			LEFT OUTER JOIN MSP_EpmAssignmentBaselineByDay AS bbd 
			ON a.AssignmentUID = bbd.AssignmentUID 
				AND abd.TimeByDay = bbd.TimeByDay
WHERE        (p.[Project Status] = '02 In Progress') 
				AND (p.[Budget Type] = 'Capital') 
				AND (r.ResourceIsGeneric = 0) 
				AND (r.[CHOC Resource Type] = 'Exempt'
				AND r.ResourceName = 'Nancy Vu' 
				OR r.[CHOC Resource Type] = 'Hourly')
GROUP BY p.ProjectName, r.ResourceName, DATEPART(year, abd.TimeByDay), DATEPART(month, abd.TimeByDay), abd.TimeByDay, p.[Activity Code], 
                         p.[Project Status], p.[Budget Type], r.ResourceIsGeneric, r.[CHOC Resource Type], abd.AssignmentWork, abd.AssignmentActualWork, 
                         abd.AssignmentActualCost, bbd.AssignmentBaselineWork, r.ResourceStandardRate, a.TaskUID
ORDER BY r.ResourceName, p.ProjectName, Yr, Mth, AssnWorkDate, p.[Project Status]