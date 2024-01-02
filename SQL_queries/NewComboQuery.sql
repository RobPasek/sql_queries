USE Productivity
GO

Declare @startDate varchar(20)
Declare @endDate varchar(20)

/*prevDay,CurrentPP, PrevPP*/

Set @startDate = dbo.GetStartDate('prevDay')
Set @endDate = dbo.GetEndDate('prevDay')

SELECT [dbo].[TestTable].Encoded_By
	  , ['Position_Staff - Coder$'].EE#
	  , [dbo].[TestTable].[OutPatient_Productivity]
	  , [dbo].[TestTable].[Summed Outpatient Drg's]
	  , [dbo].[TestTable].[InPatient_Productivity]
	  , [dbo].[TestTable].[Summed Inpatient Drg's]
	  , [IpProductivity] = 'NULL'
	  , [OpProductivity] = 'NULL'
	  , [Hourly Productivity] = 'NULL'
	  , A.[Reg-1]
	  , A.[Reg-2]
	  , A.[OT_Hours]
INTO dbo.SoftMed_PrevPayPeriod 
FROM [dbo].[TestTable]
LEFT JOIN ['Position_Staff - Coder$']
ON [dbo].[TestTable].Encoded_By = ['Position_Staff - Coder$'].enc_ID
LEFT JOIN dbo.SoftMed_Tbl_PrevPayPeriod
ON dbo.myUnion_Encoder_ID.Encoder_ID = dbo.SoftMed_Tbl_PrevPayPeriod.Encoded_By
LEFT JOIN (SELECT      DISTINCT dbo.Kronos_3_Year_to_present.PERSONNUM 
			, C.[Reg-1]
			, D.[Reg-2]
			, B.[OT_Hours] 
			, PERSONID 
--INTO dbo.Kronos3MTime			
FROM            dbo.Kronos_3_Year_to_present
Left JOIN (Select b.PERSONNUM, [OT_Hours] = CAST((SUM(b.MinutesWorked) /60.00) AS decimal(18,2))  from dbo.Kronos_3_Year_to_present as b  WHERE b.PAYCODENAME = 'OT-1' AND (b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS B
ON dbo.Kronos_3_Year_to_present.PERSONNUM = B.PERSONNUM
Left JOIN (Select b.PERSONNUM, [Reg-1] = CAST((SUM(b.MinutesWorked) /60.00) AS decimal(18,2))  from dbo.Kronos_3_Year_to_present as b  WHERE b.PAYCODENAME = 'Reg-1' AND(b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS C
ON dbo.Kronos_3_Year_to_present.PERSONNUM = C.PERSONNUM
Left JOIN (Select b.PERSONNUM, [Reg-2] = CAST((SUM(b.MinutesWorked) /60.00) AS decimal(18,2))  from dbo.Kronos_3_Year_to_present as b  WHERE b.PAYCODENAME = 'Reg-2' AND(b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS D
ON dbo.Kronos_3_Year_to_present.PERSONNUM = D.PERSONNUM
WHERE        (APPLYDATE BETWEEN @startDate AND @endDate)
GROUP BY dbo.Kronos_3_Year_to_present.PERSONNUM,dbo.Kronos_3_Year_to_present.PAYCODEID, dbo.Kronos_3_Year_to_present.PERSONID, B.[OT_Hours],C.[Reg-1], D.[Reg-2] 
) AS A
ON ['Position_Staff - Coder$'].EE# = A.PERSONNUM


SELECT      DISTINCT dbo.Kronos_3_Year_to_present.PERSONNUM 
			, C.[Reg-1]
			, D.[Reg-2]
			, B.[OT_Hours] 
			, PERSONID 
--INTO dbo.Kronos3MTime			
FROM            dbo.Kronos_3_Year_to_present
Left JOIN (Select b.PERSONNUM, [OT_Hours] = CAST((SUM(b.MinutesWorked) /60.00) AS decimal(18,2))  from dbo.Kronos_3_Year_to_present as b  WHERE b.PAYCODENAME = 'OT-1' AND (b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS B
ON dbo.Kronos_3_Year_to_present.PERSONNUM = B.PERSONNUM
Left JOIN (Select b.PERSONNUM, [Reg-1] = CAST((SUM(b.MinutesWorked) /60.00) AS decimal(18,2))  from dbo.Kronos_3_Year_to_present as b  WHERE b.PAYCODENAME = 'Reg-1' AND(b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS C
ON dbo.Kronos_3_Year_to_present.PERSONNUM = C.PERSONNUM
Left JOIN (Select b.PERSONNUM, [Reg-2] = CAST((SUM(b.MinutesWorked) /60.00) AS decimal(18,2))  from dbo.Kronos_3_Year_to_present as b  WHERE b.PAYCODENAME = 'Reg-2' AND(b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS D
ON dbo.Kronos_3_Year_to_present.PERSONNUM = D.PERSONNUM
WHERE        (APPLYDATE BETWEEN @startDate AND @endDate)
GROUP BY dbo.Kronos_3_Year_to_present.PERSONNUM,dbo.Kronos_3_Year_to_present.PAYCODEID, dbo.Kronos_3_Year_to_present.PERSONID, B.[OT_Hours],C.[Reg-1], D.[Reg-2] 

GO