use ProjectWebApp_Prod
Go 

SELECT [Order] = DENSE_RANK() OVER (ORDER BY MSP_TimeByDay.[TimeByDay])
	, CONVERT(varchar(10),CAST(MSP_TimeByDay.TimeByDay as date), 101) AS [Date]
	--,  CAST(MSP_TimeByDay.TimeByDay AS Date)
	, MSP_TimeByDay.TimeDayOfTheWeek AS [Week Day]
	, MSP_TimeByDay.TimeDayOfTheMonth AS [Day]
	, MSP_TimeByDay.TimeMonthOfTheYear AS [Month]
	, CONVERT(varchar(10),CAST(p.[Go Live Date] AS date),101) AS [Project Go Live]
	, p.ProjectName as [Project Name]
	

FROM MSP_TimeByDay 

LEFT JOIN (SELECT[ProjectUID]
      ,[ProjectName]
      ,[ProjectDescription]
      ,[ProjectAuthorName]
      ,[Go Live Date]
FROM [dbo].[MSP_EpmProject_UserView]
where [Go Live Date] <> '') as P
ON MSP_TimeByDay.TimeByDay = Convert(varchar(10),CAST(p.[Go Live Date] AS DATE),101)
WHERE MSP_TimeByDay.TimeByDay >= DATEADD(DD,-14,GETDATE())
AND MSP_TimeByDay.TimeByDay <= DATEADD(DD,-1, (DATEADD(M, 1, GETDATE())))
ORDER BY [Order]