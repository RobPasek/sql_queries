USE Productivity
GO

SELECT dbo.myUnion_Encoder_ID.Encoder_ID
	  ,['Position_Staff - Coder$'].EE#
      ,cast(ROUND(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.[Summed Inpatient Drg's]/dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.ipDRGNum,2,0)as decimal(18,2)) AS [AvgIPDRG]
	  ,cast(ROUND(dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod.[Summed Outpatient Drg's]/dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod.opDRGNum,2,0)as decimal(18,2)) AS [AvgOPDRG]
      ,dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.[Summed Length of Stay] AS [TotalIPLOS]
	  ,dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod.[# Bills Coded] AS [# OP visits]
	  --dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod
	  ,cast(round(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.[InPatient Productivity]/(5.9*[dbo].[PreviousPayPeriod_NumberOfDays].WorkDays+ISNULL([dbo].PayCodeSum_PreviousPayPeriod.[Total OT],0)),2,0) as decimal(18,2)) AS [IpProductivity]
      ,cast(round([dbo].SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.[OutPatient Productivity]/(5.9*[dbo].[PreviousPayPeriod_NumberOfDays].WorkDays+ISNULL([dbo].PayCodeSum_PreviousPayPeriod.[Total OT],0)),2,0) as decimal(18,2)) AS [OpProductivity]
	  ,(cast(round(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.[InPatient Productivity]/(5.9*[dbo].[PreviousPayPeriod_NumberOfDays].WorkDays+ISNULL([dbo].PayCodeSum_PreviousPayPeriod.[Total OT],0)),2,0) as decimal(18,2)) + cast(round([dbo].SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.[OutPatient Productivity]/(5.9*[dbo].[PreviousPayPeriod_NumberOfDays].WorkDays+ISNULL([dbo].[PayCodeSum_PreviousPayPeriod].[Total OT],0)),2,0) as decimal(18,2))) AS [Hourly Productivity]
	  ,cast(round(ISNULL([dbo].PayCodeSum_PreviousPayPeriod.[Total REG-1],0),2,0) as decimal(18,2)) AS [Total REG-1]
      ,cast(round(ISNULL([dbo].PayCodeSum_PreviousPayPeriod.[Total REG-2],0),2,0) as decimal(18,2)) AS [Total REG-2]
      ,cast(round(ISNULL([dbo].PayCodeSum_PreviousPayPeriod.[Total OT],0),2,0) as decimal(18,2)) AS [Total OT]
  --INTO dbo.SoftMed_Previous_PayPeriod_Combined
  FROM [dbo].SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod
  FULL JOIN dbo.myUnion_Encoder_ID
  ON dbo.myUnion_Encoder_ID.Encoder_ID = [dbo].SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod.[Encoded_By]
  FULL JOIN [dbo].SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod
  ON [dbo].SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod.[Encoded_By]= dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousPayPeriod.[Encoded_By]
  Left JOIN ['Position_Staff - Coder$']
  ON [dbo].SoftMed_OutPatient_Only_Sums_Tbl_PreviousPayPeriod.[Encoded_By] = ['Position_Staff - Coder$'].enc_ID
  Left JOIN [dbo].PayCodeSum_PreviousPayPeriod
  ON ['Position_Staff - Coder$'].EE# = [dbo].PayCodeSum_PreviousPayPeriod.[PERSONNUM]
  Left JOIN [dbo].[PreviousPayPeriod_NumberOfDays]
  ON ['Position_Staff - Coder$'].EE# = [dbo].[PreviousPayPeriod_NumberOfDays].PERSONNUM
GO