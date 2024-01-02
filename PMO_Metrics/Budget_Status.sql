Use ProjectWebApp_Prod
GO

declare @fiscalyear date

SET @fiscalyear = '2015'

SELECT        dbo.fnc_FiscalYear(@fiscalyear) AS FiscalYear,ProjectName, [Budget Status], ProjectOwnerName, [PM Summary Score], ProjectPercentCompleted
FROM            MSP_EpmProject_UserView as p
WHERE        (ProjectName <> 'Timesheet Administrative Work Items') AND (ProjectPercentCompleted = 100) and (P.ProjectFinishDate >= '07/01/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear))) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1)) OR
                         (P.ProjectFinishDate >= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1))