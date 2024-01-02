Use Productivity
GO

Declare @startDate varchar(20)
Declare @endDate varchar(20)

Set @startDate = dbo.GetStartDate('PrevPP')
Set @endDate = dbo.GetEndDate('PrevPP')

select distinct [dbo].[myUnion_Encoder_ID].Encoder_ID as [Encoded_By]
	,['Position_Staff - Coder$'].EE#
	,[AvgOPDRG] = CAST(E.avgOPdrg AS decimal(18,2))
	,[AvgIPDRG] = CAST(F.avgIPdrg AS decimal(18,2))
	,[IpProductivity] =case
			WHEN ([dbo].['Position_Staff - Coder$'].[EE#] IN ('5121','6367')) THEN CAST(((ISNULL(B.length_of_stay,0)/(Z.TotalHrs + ISNULL(Z.[OT_Hours],0))))AS DECIMAL(18,2))
			ELSE CAST((ISNULL(B.length_of_stay/((5.9 * (z.DW)) + isnull((Z.[OT_Hours]),0)),0))AS DECIMAL(18,2))
		End
	  , [OpProductivity] = case
			WHEN ([dbo].['Position_Staff - Coder$'].[EE#] IN ('5121','6367')) THEN CAST(((ISNULL(A.BillCount,0)/(Z.TotalHrs + ISNULL(Z.[OT_Hours],0))))AS DECIMAL(18,2))
			else CAST((ISNULL(A.BillCount/((5.9 * (Z.DW)) + isnull((Z.[OT_Hours]),0)),0))as decimal(18,2))
		end
	,[Hourly Productivity] = case
		WHEN ([dbo].['Position_Staff - Coder$'].[EE#] IN ('5121','6367')) THEN CAST(((ISNULL(B.length_of_stay + A.BillCount,0)/(Z.TotalHrs + ISNULL(Z.[OT_Hours],0))))as decimal(18,2))
			ELSE cast(((ISNULL(B.length_of_stay + A.BillCount,0)/((5.9 * (Z.DW)) + isnull((Z.[OT_Hours]+ Z.PtD),0))))AS DECIMAL(18,2))
		END
	, Z.[Reg-1]
	, Z.[Reg-2]
	, Z.[OT_Hours]
	, Z.TotalHrs
	, Z.DW
	, Z.PtD
from [dbo].[myUnion_Encoder_ID]
LEFT JOIN [dbo].['Position_Staff - Coder$']
on [dbo].[myUnion_Encoder_ID].Encoder_ID = [dbo].['Position_Staff - Coder$'].enc_ID
LEFT JOIN (SELECT Encoded_By, count(bill_no) as [BillCount] from dbo.[3M_2011_to_Present] where visit_detail_pt_type <> 'IP%'  AND cast(rec_hstry_trans_date_time as date) between @startDate AND @endDate GROUP BY Encoded_By) as A
on [dbo].[myUnion_Encoder_ID].Encoder_ID = A.Encoded_By
LEFT JOIN (SELECT Encoded_By, SUM(length_of_stay) as [length_of_stay] from dbo.[3M_2011_to_Present] where visit_detail_pt_type like 'IP%' AND cast(rec_hstry_trans_date_time as date) between @startDate AND @endDate GROUP BY Encoded_By) as B
on [dbo].[myUnion_Encoder_ID].Encoder_ID = B.Encoded_By
LEFT JOIN (SELECT Encoded_By, avg(enc_drg_weight) as [avgOPdrg] from dbo.[3M_2011_to_Present] where visit_detail_pt_type <> 'IP%' AND cast(rec_hstry_trans_date_time as date) between @startDate AND @endDate GROUP BY Encoded_By) as E
on [dbo].[myUnion_Encoder_ID].Encoder_ID = E.Encoded_By
LEFT JOIN (SELECT Encoded_By, avg(enc_drg_weight) as [avgIPdrg] from dbo.[3M_2011_to_Present] where visit_detail_pt_type like 'IP%' AND cast(rec_hstry_trans_date_time as date) between @startDate AND @endDate GROUP BY Encoded_By) as F
on [dbo].[myUnion_Encoder_ID].Encoder_ID = F.Encoded_By
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
) AS Z
ON ['Position_Staff - Coder$'].EE# = Z.PERSONNUM

