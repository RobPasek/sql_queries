USE Productivity
GO

Declare @startDate varchar(20)
Declare @endDate varchar(20)

/*prevDay,CurrentPP, PrevPP*/

Set @startDate = dbo.GetStartDate('prevDay')
Set @endDate = dbo.GetEndDate('prevDay')

SELECT      DISTINCT PERSONNUM = VP_TOTALS_1.PERSONNUM
			, C.[Reg-1]
			, D.[Reg-2]
			, B.[OT_Hours] 
			, PERSONID = VP_TOTALS_1.PERSONID
INTO dbo.KronosPrevPayPeriod			
FROM            [CHOCNT-097].wfcdb.dbo.VP_TOTALS AS VP_TOTALS_1
Left JOIN (Select b.PERSONNUM, [OT_Hours] = CAST((SUM(b.TIMEINSECONDS) / 60 /60.00) AS decimal(18,2))  from [CHOCNT-097].wfcdb.dbo.VP_TOTALS as b  WHERE b.PAYCODENAME = 'OT-1' AND (b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS B
ON VP_TOTALS_1.PERSONNUM = B.PERSONNUM
Left JOIN (Select b.PERSONNUM, [Reg-1] = CAST((SUM(b.TIMEINSECONDS) / 60 /60.00) AS decimal(18,2))  from [CHOCNT-097].wfcdb.dbo.VP_TOTALS as b  WHERE b.PAYCODENAME = 'Reg-1' AND(b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS C
ON VP_TOTALS_1.PERSONNUM = C.PERSONNUM
Left JOIN (Select b.PERSONNUM, [Reg-2] = CAST((SUM(b.TIMEINSECONDS) / 60 /60.00) AS decimal(18,2))  from [CHOCNT-097].wfcdb.dbo.VP_TOTALS as b  WHERE b.PAYCODENAME = 'Reg-2' AND(b.APPLYDATE BETWEEN @startDate AND @endDate) group by b.PERSONNUM )AS D
ON VP_TOTALS_1.PERSONNUM = D.PERSONNUM
WHERE        (VP_TOTALS_1.PAYCODETYPE = 'P') 
			AND (VP_TOTALS_1.PAYCODENAME <> 'Previous Pay Period Approved') 
			AND (VP_TOTALS_1.PAYCODENAME <> '12HRDT-1') 
			AND (APPLYDATE BETWEEN @startDate AND @endDate)
			AND VP_TOTALS_1.PAYCODENAME <> 'PTO'

GROUP BY VP_TOTALS_1.PERSONNUM,VP_TOTALS_1.PAYCODEID, VP_TOTALS_1.PERSONID, B.[OT_Hours],C.[Reg-1], D.[Reg-2] 

GO

USE Productivity
GO

Declare @startDate varchar(20)
Declare @endDate varchar(20)

/*prevDay,CurrentPP, PrevPP*/

Set @startDate = dbo.GetStartDate('prevDay')
Set @endDate = dbo.GetEndDate('prevDay')

SELECT DISTINCT A.[Encoded_By]
		, B.[OutPatient_Productivity]
		, [Summed Outpatient Drg's] = D.[Summed Outpatient Drg's]/COUNT(D.[Summed Outpatient Drg's])
		, C.[InPatient_Productivity]
		, [Summed Inpatient Drg's] = E.[Summed Inpatient Drg's]/COUNT(E.[Summed Inpatient Drg's])
	  --[discharged],[visit_detail_pt_type],[enc_code_dt_tm],[Encode_Date],A.[rec_hstry_trans_date_time],[is_finalized],[Encoder_ID]
      --,[Encoded_By],[bill_no],[mrn],[last_name],[first_name],[length_of_stay],[enc_drg_weight]
INTO dbo.SoftMed_Tbl_PrevPayPeriod
  FROM [dbo].[3_M_Data] AS A
  LEFT JOIN (SELECT b.[Encoded_By], [OutPatient_Productivity]= COUNT([bill_no]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] NOT IN ('IPR','RHO') AND CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS B
  ON A.[Encoded_By] = B.[Encoded_By]
  LEFT JOIN (SELECT b.[Encoded_By], [InPatient_Productivity]= SUM([length_of_stay]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] IN ('IPR','RHO') AND CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS C
  ON A.[Encoded_By] = C.[Encoded_By]
  LEFT JOIN (SELECT b.[Encoded_By], [Summed Outpatient Drg's]= SUM([enc_drg_weight]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] NOT IN ('IPR','RHO') AND CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS D
  ON A.[Encoded_By] = D.[Encoded_By]
  LEFT JOIN (SELECT b.[Encoded_By], [Summed Inpatient Drg's]= SUM([enc_drg_weight]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] IN ('IPR','RHO') AND CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS E
  ON A.[Encoded_By] = E.[Encoded_By]
  WHERE CAST(A.[enc_code_dt_tm] as Date) between @startDate AND @endDate
  GROUP BY A.[Encoded_By], B.[OutPatient_Productivity],C.[InPatient_Productivity],D.[Summed Outpatient Drg's],E.[Summed Inpatient Drg's]
GO

DROP Table dbo.SoftMed_PrevPayPeriod
GO

SELECT dbo.myUnion_Encoder_ID.Encoder_ID
	  , ['Position_Staff - Coder$'].EE#
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[OutPatient_Productivity]
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[Summed Outpatient Drg's]
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[InPatient_Productivity]
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[Summed Inpatient Drg's]
	  , [IpProductivity] = 'NULL'
	  , [OpProductivity] = 'NULL'
	  , [Hourly Productivity] = 'NULL'
	  , dbo.KronosPrevPayPeriod.[Reg-1]
	  , dbo.KronosPrevPayPeriod.[Reg-2]
	  , dbo.KronosPrevPayPeriod.[OT_Hours]
INTO dbo.SoftMed_PrevPayPeriod 
FROM dbo.myUnion_Encoder_ID
LEFT JOIN ['Position_Staff - Coder$']
ON dbo.myUnion_Encoder_ID.Encoder_ID = ['Position_Staff - Coder$'].enc_ID
LEFT JOIN dbo.SoftMed_Tbl_PrevPayPeriod
ON dbo.myUnion_Encoder_ID.Encoder_ID = dbo.SoftMed_Tbl_PrevPayPeriod.Encoded_By
LEFT JOIN dbo.KronosPrevPayPeriod
ON ['Position_Staff - Coder$'].EE# = dbo.KronosPrevPayPeriod.PERSONNUM

DROP Table dbo.Productivity_prevDay
GO

SELECT dbo.myUnion_Encoder_ID.Encoder_ID
	  , ['Position_Staff - Coder$'].EE#
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[OutPatient_Productivity]
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[Summed Outpatient Drg's]
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[InPatient_Productivity]
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[Summed Inpatient Drg's]
	  , [IpProductivity] = 'NULL'
	  , [OpProductivity] = 'NULL'
	  , [Hourly Productivity] = 'NULL'
	  , dbo.KronosPrevPayPeriod.[Reg-1]
	  , dbo.KronosPrevPayPeriod.[Reg-2]
	  , dbo.KronosPrevPayPeriod.[OT_Hours]
INTO dbo.Productivity_prevDay 
FROM dbo.myUnion_Encoder_ID
LEFT JOIN ['Position_Staff - Coder$']
ON dbo.myUnion_Encoder_ID.Encoder_ID = ['Position_Staff - Coder$'].enc_ID
LEFT JOIN dbo.SoftMed_Tbl_PrevPayPeriod
ON dbo.myUnion_Encoder_ID.Encoder_ID = dbo.SoftMed_Tbl_PrevPayPeriod.Encoded_By
LEFT JOIN dbo.KronosPrevPayPeriod
ON ['Position_Staff - Coder$'].EE# = dbo.KronosPrevPayPeriod.PERSONNUM

GO

DROP Table dbo.SoftMed_prevDay_OPC
GO

SELECT dbo.OutPatient_Encoder_ID.Encoder_ID
	  ,['Position_Staff - Coder$'].EE#
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[OutPatient_Productivity]
	  , dbo.SoftMed_Tbl_PrevPayPeriod.[Summed Outpatient Drg's]
	  , [OpProductivity] = 'NULL'
	  , [Hourly Productivity] = 'NULL'
	  , dbo.KronosPrevPayPeriod.[Reg-1]
	  , dbo.KronosPrevPayPeriod.[Reg-2]
	  , dbo.KronosPrevPayPeriod.[OT_Hours]
INTO dbo.SoftMed_prevDay_OPC
FROM dbo.OutPatient_Encoder_ID
LEFT JOIN ['Position_Staff - Coder$']
ON dbo.OutPatient_Encoder_ID.Encoder_ID = ['Position_Staff - Coder$'].enc_ID
LEFT JOIN dbo.SoftMed_Tbl_PrevPayPeriod
ON dbo.OutPatient_Encoder_ID.Encoder_ID = dbo.SoftMed_Tbl_PrevPayPeriod.Encoded_By
LEFT JOIN dbo.KronosPrevPayPeriod
ON ['Position_Staff - Coder$'].EE# = dbo.KronosPrevPayPeriod.PERSONNUM
GO

DROP Table dbo.KronosPrevPayPeriod
GO
DROP TABLE dbo.SoftMed_Tbl_PrevPayPeriod
GO