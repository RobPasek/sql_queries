SELECT [APPLYDATE]
      ,[PAYCODENAME]
      ,[KPAYCODE]
      ,SUM([MinutesWorked]) [Kronos Time]
      ,[PAYCODEID]
      ,[PERSONNUM]
      ,[PERSONFULLNAME]
      ,[position]
      ,[Cost Center]
      ,[PL]
      ,[DeptNum]
      ,[Job Code]
      ,[title]
      ,[PERSONID]
FROM [Productivity_Report].[dbo].[KronosExpanded]
WHERE [PERSONID] IN (SELECT  DISTINCT [PERSONID] FROM [Productivity_Report].[dbo].[3M_Coder_Kronos]) 
AND [APPLYDATE] <= getdate()
AND getdate() BETWEEN  [PREVPAYPERIODSTART] AND [CURRPAYPERIODEND]
AND [APPLYDATE] BETWEEN [PREVPAYPERIODSTART] AND [CURRPAYPERIODEND]
GROUP BY [APPLYDATE]
      ,[PAYCODENAME]
      ,[KPAYCODE]
      ,[PAYCODEID]
      ,[PERSONNUM]
      ,[PERSONFULLNAME]
      ,[position]
      ,[Cost Center]
      ,[PL]
      ,[DeptNum]
      ,[Job Code]
      ,[title]
      ,[PERSONID]