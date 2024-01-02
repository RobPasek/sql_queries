USE Productivity
GO


Declare @startDate varchar(20)
Declare @endDate varchar(20)

Set @startDate = dbo.GetStartDate('PrevPP')
Set @endDate = dbo.GetEndDate('PrevPP')

SELECT [dbo].[myUnion_Encoder_ID].Encoder_ID as [Encoded_By]
	  , ['Position_Staff - Coder$'].EE#
	  , isNULL([dbo].[TestTable].[OutPatient_Productivity],0) as [OutPatient_Productivity]
	  , isNULL([dbo].[TestTable].[Summed Outpatient Drg's],0) as [Summed Outpatient Drg's]
	  , isNULL([dbo].[TestTable].[InPatient_Productivity],0) as [InPatient_Productivity]
	  , isNULL([dbo].[TestTable].[Summed Inpatient Drg's],0) as [Summed Inpatient Drg's]
	  , [IpProductivity] =case
			WHEN ([dbo].['Position_Staff - Coder$'].[EE#] IN ('5121','6367')) THEN (ISNULL([InPatient_Productivity],0)/(A.TotalHrs + ISNULL(A.[OT_Hours],0)))
			ELSE ISNULL([dbo].[TestTable].[InPatient_Productivity]/((5.9 * (A.DW)) + isnull((A.[OT_Hours]),0)),0)
		End
	  , [OpProductivity] = case
			WHEN ([dbo].['Position_Staff - Coder$'].[EE#] IN ('5121','6367')) THEN (ISNULL([dbo].[TestTable].[OutPatient_Productivity],0)/(A.TotalHrs + ISNULL(A.[OT_Hours],0)))
			else ISNULL([dbo].[TestTable].[OutPatient_Productivity]/((5.9 * (A.DW)) + isnull((A.[OT_Hours]),0)),0)
		end
	  , [Hourly Productivity] = CASE 
			WHEN ([dbo].['Position_Staff - Coder$'].[EE#] IN ('5121','6367')) THEN (ISNULL([InPatient_Productivity] + [dbo].[TestTable].[OutPatient_Productivity],0)/(A.TotalHrs + ISNULL(A.[OT_Hours],0)))
			ELSE (ISNULL([InPatient_Productivity] + [dbo].[TestTable].[OutPatient_Productivity],0)/((5.9 * (A.DW)) + isnull((A.[OT_Hours]+ A.PtD),0)))
		END
	  , A.[Reg-1]
	  , A.[Reg-2]
	  , A.[OT_Hours]
	  , A.TotalHrs
	  , A.DW
	  , A.PtD
FROM [dbo].[myUnion_Encoder_ID]
LEFT JOIN [dbo].[TestTable]
ON [dbo].[myUnion_Encoder_ID].Encoder_ID = [dbo].[TestTable].Encoded_By
LEFT JOIN ['Position_Staff - Coder$']
ON [dbo].[TestTable].Encoded_By = ['Position_Staff - Coder$'].enc_ID
LEFT JOIN (SELECT      DISTINCT dbo.Kronos_3_Year_to_present.PERSONNUM 
			, (isNull(C.[Reg-1],0)) as [Reg-1]
			, (isNull(D.[Reg-2],0)) as [Reg-2]
			, (isNull(B.[OT_Hours],0)) as [OT_Hours]
			, (isnull(C.[Reg-1],0) + isnull(D.[Reg-2],0)) as TotalHrs
			, (isnull(C.[Reg-1],0) + isnull(D.[Reg-2],0))/8 as DW
			, (isnull(C.[Reg-1],0) + isnull(D.[Reg-2],0))%8 as PtD
			, PERSONID 
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
group by [dbo].[myUnion_Encoder_ID].Encoder_ID
	  , ['Position_Staff - Coder$'].EE#
	  , [dbo].[TestTable].[OutPatient_Productivity]
	  , [dbo].[TestTable].[Summed Outpatient Drg's]
	  , [dbo].[TestTable].[InPatient_Productivity]
	  , [dbo].[TestTable].[Summed Inpatient Drg's]
	  , A.[Reg-1]
	  , A.[Reg-2]
	  , A.[OT_Hours]
	  , A.TotalHrs
	  , A.DW
	  , A.PtD


GO