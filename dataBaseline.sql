use ProjectWebApp_Prod
go

SELECT TaskUID, TimeByDay, sum(assignmentcost) as assignmentcost
, SUM(AssignmentBaseline0Work) AS AssignmentBaseline0Work
, SUM(AssignmentBaseline1Work) AS AssignmentBaseline1Work
, SUM(AssignmentBaseline2Work) AS AssignmentBaseline2Work
, SUM(AssignmentBaseline3Work) AS AssignmentBaseline3Work
, SUM(AssignmentBaseline4Work) AS AssignmentBaseline4Work
, SUM(AssignmentBaseline5Work) AS AssignmentBaseline5Work
, SUM(AssignmentBaseline6Work) AS AssignmentBaseline6Work
, SUM(AssignmentBaseline7Work) AS AssignmentBaseline7Work
, SUM(AssignmentBaseline8Work) AS AssignmentBaseline8Work
, SUM(AssignmentBaseline9Work) AS AssignmentBaseline9Work
, SUM(AssignmentBaseline10Work) AS AssignmentBaseline10Work
FROM MSP_EpmAssignmentByDay_UserView
/*WHERE AssignmentBaseline1Work= 0 
		OR AssignmentBaseline2Work= 0
		OR AssignmentBaseline3Work= 0
		OR AssignmentBaseline4Work= 0
		OR AssignmentBaseline5Work= 0
		OR AssignmentBaseline6Work= 0
		OR AssignmentBaseline7Work= 0
		OR AssignmentBaseline8Work= 0
		OR AssignmentBaseline9Work= 0
		OR AssignmentBaseline10Work= 0	*/

group by TaskUID, TimeByDay

SELECT *
FROM MSP_EpmAssignmentByDay_UserView