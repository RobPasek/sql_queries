USE [ProjectWebApp_Prod]
GO

SELECT   DISTINCT Z.[ProjectUID]
	  , A.ProjectName
      ,Z.[TaskFinishDate]
      
  FROM [dbo].[MSP_EpmTask_UserView] as Z
    Left join (select ProjectName, ProjectUID FROM [dbo].[MSP_EpmProject_UserView]) as A
  On Z.ProjectUID = A.ProjectUID
  where Z.[Task Go Live Date] = 'yes'
GO


