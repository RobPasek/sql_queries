use ProjectWebApp_Prod
GO

SELECT count(ProjectName) AS[Number of New Projects]
		,[Number of New Projects Initiated by PSR] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate >= '2014-07-01'
				AND ProjectFinishDate <= '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Initiated by PSR] = 'Yes')
		,[Number of New Planned Projects] = (SELECT count( ProjectName)
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate >= '2014-07-01'
				AND ProjectFinishDate <= '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Planned Project] = 'Yes')
		,[Number of New Projects with Operating Budget Type] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate >= '2014-07-01'
				AND ProjectFinishDate <= '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Budget Type] = 'Operating')
		,[Number of New Projects with Capital Budget Type] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate >= '2014-07-01'
				AND ProjectFinishDate <= '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Budget Type] = 'Capital')
from  MSP_EpmProject_UserView
WHERE ProjectStartDate >= '2014-07-01'
	AND ProjectFinishDate <= '2015-07-01'
	AND ProjectName <> 'Timesheet Administrative Work Items'
GO

SELECT [Number of Continued Projects Ending This FY] = count( ProjectName)  
			
		,[Number of Continued Projects Ending This FY initiated by PSR] = (SELECT count( ProjectName)
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Initiated by PSR] = 'Yes')
		,[Number of Continued Planned Projects Ending This FY] = (SELECT count( ProjectName)  
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Planned Project] = 'Yes')
		,[Number of Continued Projects Ending Next FY with Operating Budget Type] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items' 
				AND [Budget Type] = 'Operating') 
		,[Number of Continued Projects Ending Next FY with Capital Budget Type] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Budget Type] = 'Capital')
				
	from MSP_EpmProject_UserView
		WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'

SELECT [Number of Continued Projects Ending Next FY] = count( ProjectName)
		,[Number of Continued Planned Projects Ending Next FY initiated by PSR] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Initiated by PSR] = 'Yes')
		,[Number of Continued Planned Projects Ending Next FY] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Planned Project] = 'Yes')
		,[Number of Continued Planned Projects Ending Next FY with Operating Budget Type] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Budget Type] = 'Operating')
		,[Number of Continued Planned Projects Ending Next FY with Capital Budget Type] =(SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Budget Type] = 'Capital')

	from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items'
				AND [Initiated by PSR] = 'Yes'