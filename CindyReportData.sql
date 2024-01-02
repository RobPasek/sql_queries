USE ProjectWebApp_Prod
GO 

SELECT DISTINCT P.ProjectOwnerName
			, isnull(Z.[Initiated by PSR],0) AS [Initiated by PSR]
			, isnull(F.[Planned Projects],0) AS [Planned Projects]
			, isnull(G.[Non Planned Projects],0) AS [Non Planned Projects]
			, isnull(A.Completed,0) AS Completed
			, isnull(B.[In Progress],0) AS [In Progress]
			, isnull(C.[On Hold],0) AS [On Hold]
			, isnull(D.[Evaluation],0) AS Evaluation
			, isnull(E.[Scheduled],0) AS Scheduled
			, isnull(H.[Budget Variance],0) AS [Total Budget Variance]
			, isnull(I.[Actual Project Cost],0) AS [Actual Project Cost]
FROM MSP_EpmProject_UserView as P
LEFT JOIN (SELECT DISTINCT ProjectOwnerName , COUNT([Initiated by PSR]) as [Initiated by PSR] FROM MSP_EpmProject_UserView  
			WHERE [Initiated by PSR] = 'Yes' GROUP BY ProjectOwnerName) as Z
ON p.ProjectOwnerName = Z.ProjectOwnerName
LEFT JOIN (SELECT DISTINCT ProjectOwnerName , COUNT([Project Status]) as Completed FROM MSP_EpmProject_UserView  
			WHERE [Project Status] = '03 Completed'GROUP BY ProjectOwnerName) as A
ON p.ProjectOwnerName = A.ProjectOwnerName
LEFT JOIN (SELECT DISTINCT ProjectOwnerName , COUNT([Project Status]) as [In Progress] FROM MSP_EpmProject_UserView  
			WHERE [Project Status] = '02 In Progress' GROUP BY ProjectOwnerName) as B
ON p.ProjectOwnerName = B.ProjectOwnerName
LEFT JOIN (SELECT DISTINCT ProjectOwnerName , COUNT([Project Status]) as [On Hold] FROM MSP_EpmProject_UserView  
			WHERE [Project Status] = '04 On Hold' GROUP BY ProjectOwnerName) as C
ON p.ProjectOwnerName = C.ProjectOwnerName
LEFT JOIN (SELECT DISTINCT ProjectOwnerName , COUNT([Project Status]) as [Evaluation] FROM MSP_EpmProject_UserView  
			WHERE [Project Status] = '06 Evaluation' GROUP BY ProjectOwnerName) as D
ON p.ProjectOwnerName = D.ProjectOwnerName 
LEFT JOIN (SELECT DISTINCT ProjectOwnerName , COUNT([Project Status]) as [Scheduled] FROM MSP_EpmProject_UserView  
			WHERE [Project Status] = '01 Scheduled' GROUP BY ProjectOwnerName) as E
ON p.ProjectOwnerName = E.ProjectOwnerName
LEFT JOIN (SELECT projectownername,  COUNT([planned Project]) AS [Planned Projects] FROM MSP_EpmProject_UserView 
WHERE [Planned Project] = 'YES'GROUP BY ProjectOwnerName) AS F 
ON p.ProjectOwnerName = F.ProjectOwnerName
LEFT JOIN (SELECT projectownername,  COUNT([planned Project]) AS [Non Planned Projects] FROM MSP_EpmProject_UserView 
WHERE [Planned Project] = 'NO' GROUP BY ProjectOwnerName) as G
ON p.ProjectOwnerName = G.ProjectOwnerName
LEFT JOIN (SELECT projectownername,  SUM([CHOC Variance]) AS [Budget Variance] FROM MSP_EpmProject_UserView 
GROUP BY ProjectOwnerName) as H
ON p.ProjectOwnerName = H.ProjectOwnerName
LEFT JOIN (SELECT projectownername,  SUM([ProjectActualCost]) AS [Actual Project Cost] FROM MSP_EpmProject_UserView 
GROUP BY ProjectOwnerName) as I
ON p.ProjectOwnerName = I.ProjectOwnerName
WHERE [Go Live Date] < '2015-07-01'
Group By P.ProjectOwnerName, P.ProjectUID, A.Completed, B.[In Progress], C.[On Hold], D.[Evaluation]
	, E.[Scheduled], F.[Planned Projects], G.[Non Planned Projects], H.[Budget Variance]
	, I.[Actual Project Cost], Z.[Initiated by PSR]

GO

