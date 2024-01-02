USE ProjectWebApp_Prod
GO

SELECT DISTINCT P.ProjectName
		--, p.ProjectUID
		, P.[Activity Code]
		, P.[Project Status]
		, P.[Budget Type]
		, r.ResourceName
		, zed.TimeByDay AS AssnWorkDate
		, abd.AssignmentWork AS [Planned Hours]
		, abd.AssignmentActualWork AS [Actual Hours]
		, abd.AssignmentActualCost AS [Actual Cost]
		--, bbd.AssignmentBaselineWork AS BaselineWork
		, a.ProjectUID
		, a.TaskUID
				
FROM MSP_EpmProject_UserView AS P
LEFT JOIN MSP_EpmAssignment_UserView AS a
ON p.ProjectUID = a.ProjectUID
LEFT join MSP_EpmAssignment_UserView as abd--MSP_EpmAssignmentByDay_UserView as abd
ON a.AssignmentUID = abd.AssignmentUID
LEFT JOIN (SELECT * FROM MSP_EpmAssignmentByDay_UserView 
WHERE AssignmentBaseline1Work= 0 
		OR AssignmentBaseline2Work= 0
		OR AssignmentBaseline3Work= 0
		OR AssignmentBaseline4Work= 0
		OR AssignmentBaseline5Work= 0
		OR AssignmentBaseline6Work= 0
		OR AssignmentBaseline7Work= 0
		OR AssignmentBaseline8Work= 0
		OR AssignmentBaseline9Work= 0
		OR AssignmentBaseline10Work= 0 ) as zed
on a.AssignmentUID = zed.AssignmentUID
INNER JOIN MSP_EpmResource_UserView as r
ON a.ResourceUID = r.ResourceUID


WHERE (r.[CHOC Resource Type] = 'Exempt' OR r.[CHOC Resource Type] = 'Hourly')