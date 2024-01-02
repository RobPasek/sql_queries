USE ProjectWebApp_Prod
GO
SELECT DISTINCT dbo.MSP_EpmTask.ProjectUID
		, dbo.MSP_EpmProject.ProjectName 
		,CPI = SUM(taskCPI)/COUNT(taskCPI)
		,SPI = SUM(TaskSPI)/COUNT(TaskSPI)
		,EAC = SUM(TaskEAC)
		,COST = SUM(TaskCost)
		,VARIANCE = SUM(TaskCostVariance)
FROM dbo.MSP_EpmTask
LEFT JOIN dbo.MSP_EpmProject
ON dbo.MSP_EpmTask.ProjectUID = dbo.MSP_EpmProject.ProjectUID

GROUP BY dbo.MSP_EpmTask.ProjectUID, dbo.MSP_EpmProject.ProjectName