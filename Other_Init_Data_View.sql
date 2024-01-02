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
		,[Number of Continued Projects Ending This FY] = (SELECT count( ProjectName)  
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2015-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items')
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
		,[Number of Continued Projects Ending Next FY] = (SELECT count( ProjectName) 
			from MSP_EpmProject_UserView
			WHERE ProjectStartDate <= '2014-07-01'
				AND ProjectFinishDate < '2016-07-01'
				AND ProjectName <> 'Timesheet Administrative Work Items')
		,[Number of Continued Projects Ending Next FY initiated by PSR] = (SELECT count( ProjectName)
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

from  MSP_EpmProject_UserView
WHERE ProjectStartDate >= '2014-07-01'
	AND ProjectFinishDate <= '2015-07-01'
	AND ProjectName <> 'Timesheet Administrative Work Items'