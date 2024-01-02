use ProjectWebApp_Prod
go

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
						 INNER JOIN (SELECT * FROM MSP_EpmAssignmentByDay_UserView
						 /*WHERE AssignmentBaseline1Work= 0 
								OR AssignmentBaseline2Work= 0
								OR AssignmentBaseline3Work= 0
								OR AssignmentBaseline4Work= 0
								OR AssignmentBaseline5Work= 0
								OR AssignmentBaseline6Work= 0
								OR AssignmentBaseline7Work= 0
								OR AssignmentBaseline8Work= 0
								OR AssignmentBaseline9Work= 0
								OR AssignmentBaseline10Work= 0*/ ) AS abd 
						 ON a.AssignmentUID = abd.AssignmentUID 
						 LEFT OUTER JOIN MSP_EpmAssignmentBaselineByDay AS bbd 
						 ON a.AssignmentUID = bbd.AssignmentUID 
						 AND abd.TimeByDay = bbd.TimeByDay
WHERE        (r.ResourceIsGeneric = 0) 
			AND (r.[CHOC Resource Type] = 'Exempt'
			OR r.[CHOC Resource Type] = 'Hourly')
			and a.TaskUID = '93A0F8DD-A1A8-E311-B2FD-005056A15999'
ORDER BY p.ProjectName