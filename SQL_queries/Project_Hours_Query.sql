use ProjectWebApp_Prod
go

SELECT  DISTINCT [dbo].[MSP_EpmAssignment].ProjectUID
		,[dbo].[MSP_EpmProject].[ProjectName]
		--,[dbo].[MSP_EpmProject].
		,[dbo].[MSP_EpmProject].[ProjectUID]
		,[dbo].[MSP_TimesheetProject].[ProjectUID]
		,[dbo].[MSP_TimesheetProject].ParentProjectNameUID
		
FROM [dbo].[MSP_EpmAssignment]
LEFT JOIN [dbo].[MSP_EpmProject]
ON [dbo].[MSP_EpmAssignment].ProjectUID = [dbo].[MSP_EpmProject].[ProjectUID]
LEFT JOIN [dbo].[MSP_TimesheetProject]
ON [dbo].[MSP_EpmAssignment].ProjectUID = [dbo].[MSP_TimesheetProject].[ProjectUID]
go