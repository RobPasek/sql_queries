
select  ['Position_Staff - Coder$'].EE#
		,[KRONOS_TIME] = SUM([dbo].[Kronos_Previous_PP_Curr_PP].MinutesWorked/60.0)
 FROM ['Position_Staff - Coder$']
 LEFT JOIN [dbo].[Kronos_Previous_PP_Curr_PP]
 ON  ['Position_Staff - Coder$'].EE# = [dbo].[Kronos_Previous_PP_Curr_PP].[PERSONNUM] 
 where [dbo].[Kronos_Previous_PP_Curr_PP].PAYCODENAME = 'Reg-2'
 AND ['Position_Staff - Coder$'].EE# = '5121'
 AND cast(APPLYDATE AS DATE) between [dbo].[Kronos_Previous_PP_Curr_PP].PREVPAYPERIODSTART and [dbo].[Kronos_Previous_PP_Curr_PP].PREVPAYPERIODEND /*= DATEADD(dd, - 5, DATEDIFF(dd, 0, GETDATE()))*/
 GROUP BY ['Position_Staff - Coder$'].EE#,[dbo].[Kronos_Previous_PP_Curr_PP].[PERSONNUM]