SELECT DISTINCT 
                      [dbo].[Finance_Kronos_cPayPeriod_BreakDown].DeptNum AS [Department Code]
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].APPLYDATE
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].position
					  , dbo.LawsonPRpaycode$.PAY_CODE
					  , dbo.LawsonPRpaycode$.DESCRIPTION AS [Paycode Description]
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PAYCODEID
					  , dbo.PayCodeType.[Expense Account]
					  , dbo.PayCodeType.[Manhours Account]
					  , dbo.PayCodeType.[Pay Category Code] 
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].[Cost Center]
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PL
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].[Job Code]
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PERSONNUM
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PERSONFULLNAME
					  , dbo.Positions$.[Job Code Description]
					  , SUM([dbo].[Finance_Kronos_cPayPeriod_BreakDown].MinutesWorked) / 60.0 AS [Kronos Hours]
					  , [dbo].[Finance_Kronos_cPayPeriod_BreakDown].Activity
FROM         [dbo].[Finance_Kronos_cPayPeriod_BreakDown] 
					  LEFT OUTER JOIN dbo.LawsonPRpaycode$ 
					  ON [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PAYCODENAME = dbo.LawsonPRpaycode$.Kronos 
					  LEFT OUTER JOIN dbo.Positions$ 
					  ON [dbo].[Finance_Kronos_cPayPeriod_BreakDown].position = dbo.Positions$.JobCode
					  LEFT JOIN dbo.PayCodeType 
					  ON dbo.LawsonPRpaycode$.PAY_CODE = dbo.PayCodeType.[Pay Code]
GROUP BY [dbo].[Finance_Kronos_cPayPeriod_BreakDown].DeptNum, [dbo].[Finance_Kronos_cPayPeriod_BreakDown].APPLYDATE, dbo.LawsonPRpaycode$.DESCRIPTION, 
                      [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PAYCODEID, [dbo].[Finance_Kronos_cPayPeriod_BreakDown].position, [dbo].[Finance_Kronos_cPayPeriod_BreakDown].[Cost Center], 
                      [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PL, [dbo].[Finance_Kronos_cPayPeriod_BreakDown].[Job Code], [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PERSONNUM, 
                      [dbo].[Finance_Kronos_cPayPeriod_BreakDown].PERSONFULLNAME, dbo.Positions$.[Job Code Description], dbo.LawsonPRpaycode$.PAY_CODE, 
                      [dbo].[Finance_Kronos_cPayPeriod_BreakDown].Activity, dbo.PayCodeType.[Expense Account]
					  , dbo.PayCodeType.[Manhours Account]
					  , dbo.PayCodeType.[Pay Category Code] 
					  