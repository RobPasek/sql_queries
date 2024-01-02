USE Productivity
GO

Declare @startDate varchar(20)
Declare @endDate varchar(20)

/*prevDay,CurrentPP, PrevPP*/

Set @startDate = dbo.GetStartDate('PrevPP')
Set @endDate = dbo.GetEndDate('PrevPP')

SELECT DISTINCT A.[Encoded_By]
		, B.[OutPatient_Productivity]
		, [Summed Outpatient Drg's] = D.[Summed Outpatient Drg's]/COUNT(D.[Summed Outpatient Drg's])
		, C.[InPatient_Productivity]
		, [Summed Inpatient Drg's] = E.[Summed Inpatient Drg's]/COUNT(E.[Summed Inpatient Drg's])
	  --[discharged],[visit_detail_pt_type],[enc_code_dt_tm],[Encode_Date],A.[rec_hstry_trans_date_time],[is_finalized],[Encoder_ID]
      --,[Encoded_By],[bill_no],[mrn],[last_name],[first_name],[length_of_stay],[enc_drg_weight]
--INTO dbo.SoftMed_Tbl_PrevPayPeriod
  FROM [dbo].[3_M_Data] AS A
  LEFT JOIN (SELECT b.[Encoded_By], [OutPatient_Productivity]= COUNT([bill_no]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] <> 'IPR'AND  CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS B
  ON A.[Encoded_By] = B.[Encoded_By]
  LEFT JOIN (SELECT b.[Encoded_By], [InPatient_Productivity]= SUM([length_of_stay]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] LIKE 'IP%' AND CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS C
  ON A.[Encoded_By] = C.[Encoded_By]
  LEFT JOIN (SELECT b.[Encoded_By], [Summed Outpatient Drg's]= SUM([enc_drg_weight]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] <> 'IPR' AND CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS D
  ON A.[Encoded_By] = D.[Encoded_By]
  LEFT JOIN (SELECT b.[Encoded_By], [Summed Inpatient Drg's]= SUM([enc_drg_weight]) FROM [dbo].[3_M_Data] AS b WHERE b.[visit_detail_pt_type] LIKE 'IP%' AND CAST(b.[enc_code_dt_tm] as Date) between @startDate AND @endDate GROUP BY b.[Encoded_By] ) AS E
  ON A.[Encoded_By] = E.[Encoded_By]
  WHERE CAST(A.[rec_hstry_trans_date_time] as Date) between @startDate AND @endDate
  AND A.Encoded_By = 'kyamada'
  OR A.Encoded_By = 'jseaman'
  GROUP BY A.[Encoded_By], B.[OutPatient_Productivity],C.[InPatient_Productivity],D.[Summed Outpatient Drg's],E.[Summed Inpatient Drg's]
GO