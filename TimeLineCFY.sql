use ProjectWebApp_Prod
GO

declare @fiscalyear date
set @fiscalyear = getdate()


SELECT DISTINCT 
                         GETDATE() AS Expr1, p.ProjectUID, dbo.fnc_FiscalYear(@fiscalyear) AS FiscalYear, P.ProjectName, P.[Project Status], P.[Project Stage], P.ProjectStartDate, 
                         P.ProjectFinishDate, EPT.EnterpriseProjectTypeName, P.ProjectOwnerName, T.TaskName, T.TaskFinishDate, T.TaskBaseline0FinishDate, T.[Go Live Date], 
                         P.ProjectOwnerResourceUID, ISNULL(P.Program, 'NA') AS Program, ISNULL(P.[Organization and Alignment], 'z_NA') AS [Organization and Alignment]
FROM            (SELECT        ProjectUID, TaskName, [Go Live Date], TaskFinishDate, TaskBaseline0FinishDate
                          FROM            MSP_EpmTask_UserView
                          WHERE        ([Go Live Date] = 'Yes')) AS T RIGHT OUTER JOIN
                         MSP_EpmProject_UserView AS P ON T.ProjectUID = P.ProjectUID INNER JOIN
                         MSP_EpmEnterpriseProjectType AS EPT ON EPT.EnterpriseProjectTypeUID = P.EnterpriseProjectTypeUID
WHERE        (P.ProjectFinishDate >= '07/01/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear))) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1)) OR
                         (P.ProjectFinishDate >= '06/30/' + CONVERT(nchar(4), dbo.fnc_FiscalYear(@fiscalyear) + 1)) AND (P.ProjectStartDate <= '06/30/' + CONVERT(nchar(4), 
                         dbo.fnc_FiscalYear(@fiscalyear) + 1))