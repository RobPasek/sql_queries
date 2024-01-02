SELECT DISTINCT 
                      [dbo].[Previous_PayPeriod_BreakDown].DeptNum AS [Department Code]
					  , [dbo].[Previous_PayPeriod_BreakDown].APPLYDATE
					  , [dbo].[Previous_PayPeriod_BreakDown].position
					  , dbo.LawsonPRpaycode$.PAY_CODE
					  , dbo.LawsonPRpaycode$.DESCRIPTION AS [Paycode Description]
					  , [dbo].[Previous_PayPeriod_BreakDown].PAYCODEID
					  , dbo.PayCodeType.[Expense Account]
					  , dbo.PayCodeType.[Manhours Account]
					  , dbo.PayCodeType.[Pay Category Code] 
					  , [dbo].[Previous_PayPeriod_BreakDown].[Cost Center]
					  , [dbo].[Previous_PayPeriod_BreakDown].PL
					  , [dbo].[Previous_PayPeriod_BreakDown].[Job Code]
					  , [dbo].[Previous_PayPeriod_BreakDown].PERSONNUM
					  , '"'+ [dbo].[Previous_PayPeriod_BreakDown].PERSONFULLNAME + '"' AS [PERSONFULLNAME] 
					  , '"'+ dbo.Positions$.[Job Code Description] + '"' AS [Job Code Description]
					  , SUM([dbo].[Previous_PayPeriod_BreakDown].MinutesWorked) / 60.0 AS [Kronos Hours]
					  , [dbo].[Previous_PayPeriod_BreakDown].Activity
FROM         [dbo].[Previous_PayPeriod_BreakDown] 
					  LEFT OUTER JOIN dbo.LawsonPRpaycode$ 
					  ON [dbo].[Previous_PayPeriod_BreakDown].PAYCODENAME = dbo.LawsonPRpaycode$.Kronos 
					  LEFT OUTER JOIN dbo.Positions$ 
					  ON [dbo].[Previous_PayPeriod_BreakDown].position = dbo.Positions$.JobCode
					  LEFT JOIN dbo.PayCodeType 
					  ON dbo.LawsonPRpaycode$.PAY_CODE = dbo.PayCodeType.[Pay Code]
GROUP BY [dbo].[Previous_PayPeriod_BreakDown].DeptNum
, [dbo].[Previous_PayPeriod_BreakDown].APPLYDATE
, dbo.LawsonPRpaycode$.DESCRIPTION
, [dbo].[Previous_PayPeriod_BreakDown].PAYCODEID
, [dbo].[Previous_PayPeriod_BreakDown].position
, [dbo].[Previous_PayPeriod_BreakDown].[Cost Center]
, [dbo].[Previous_PayPeriod_BreakDown].PL
, [dbo].[Previous_PayPeriod_BreakDown].[Job Code]
, [dbo].[Previous_PayPeriod_BreakDown].PERSONNUM
, [dbo].[Previous_PayPeriod_BreakDown].PERSONFULLNAME
, dbo.Positions$.[Job Code Description]
, dbo.LawsonPRpaycode$.PAY_CODE
, [dbo].[Previous_PayPeriod_BreakDown].Activity
, dbo.PayCodeType.[Expense Account]
, dbo.PayCodeType.[Manhours Account]
, dbo.PayCodeType.[Pay Category Code]