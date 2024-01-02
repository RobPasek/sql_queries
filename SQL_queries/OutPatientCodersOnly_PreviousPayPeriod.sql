USE Productivity
GO
Drop Table dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod
GO
SELECT DISTINCT 
                      Encoder_ID, SUM(enc_drg_weight) AS [Summed Outpatient Drg's], SUM(length_of_stay) AS [Summed Length of Stay], [InPatient Productivity], COUNT(bill_no) 
                      AS [OutPatient Productivity]
INTO dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod
FROM         dbo.SoftMed_OutPatient_Coders_Only
WHERE enc_code_dt_tm BETWEEN (SELECT CURRPAYPERIODSTART FROM dbo.Kronos_Current_PayPeriod) 
AND (SELECT CURRPAYPERIODEND FROM dbo.Kronos_Current_PayPeriod)
GROUP BY Encoder_ID, [InPatient Productivity]
GO
DROP TABLE
dbo.SoftMed_InPatient_Only_RHO_Sums_Tbl_PreviousPayPeriod
GO
SELECT DISTINCT  dbo.SoftMed_InPatient_Only_RHO.Encoder_ID
					  , SUM(dbo.SoftMed_InPatient_Only_RHO.enc_drg_weight) AS [Summed Inpatient Drg's], 
                      SUM(dbo.SoftMed_InPatient_Only_RHO.length_of_stay) AS [Summed Length of Stay], SUM(dbo.SoftMed_InPatient_Only_RHO.length_of_stay) AS [InPatient Productivity], 
                      dbo.SoftMed_InPatient_Only_RHO.[OutPatient Productivity]
INTO dbo.SoftMed_InPatient_Only_RHO_Sums_Tbl_PreviousPayPeriod
FROM         dbo.SoftMed_InPatient_Only_RHO
                     
WHERE enc_code_dt_tm BETWEEN (SELECT [PREVPAYPERIODSTART] FROM [dbo].[Kronos_Previous_PayPeriod]) 
AND (SELECT [PREVPAYPERIODEND] FROM [dbo].[Kronos_Previous_PayPeriod])

GROUP BY dbo.SoftMed_InPatient_Only_RHO.Encoder_ID, dbo.SoftMed_InPatient_Only_RHO.[OutPatient Productivity]

GO

USE [Productivity]
GO
DROP Table dbo.SoftMed_PreviousPayPeriod_OutPatientCoders
GO
SELECT dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod.[Encoder_ID]
	  ,['Position_Staff - Coder$'].EE#
      ,dbo.SoftMed_InPatient_Only_RHO_Sums_Tbl_PreviousPayPeriod.[Summed Inpatient Drg's] AS [InpatientDrgSum]
	  ,dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod.[Summed Outpatient Drg's] AS [OutpatientDrgSum]
      ,dbo.SoftMed_InPatient_Only_RHO_Sums_Tbl_PreviousPayPeriod.[Summed Length of Stay] AS [InpatientLengthOfStay]
	  ,dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod.[Summed Length of Stay] AS [OutPatientLengtOfStay]
	  ,dbo.SoftMed_InPatient_Only_RHO_Sums_Tbl_PreviousPayPeriod.[InPatient Productivity]/(5.9*[dbo].[Kronos_NumDays_PPeriod].WorkDays+ISNULL([dbo].[PayCodeSum_PayPeriod].[Total OT],0)) AS [IpProductivity]
      ,dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod.[OutPatient Productivity]/(5.9*[dbo].[Kronos_NumDays_PPeriod].WorkDays+ISNULL([dbo].[PayCodeSum_PayPeriod].[Total OT],0)) AS [OpProductivity]
	  ,ISNULL([dbo].[PayCodeSum_PayPeriod].[Total REG-1],0) AS [Total REG-1]
      ,ISNULL([dbo].[PayCodeSum_PayPeriod].[Total REG-2],0) AS [Total REG-2]
      ,ISNULL([dbo].[PayCodeSum_PayPeriod].[Total OT],0) AS [Total OT]
  INTO dbo.SoftMed_PreviousPayPeriod_OutPatientCoders
  FROM dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod
  FULL JOIN dbo.SoftMed_InPatient_Only_RHO_Sums_Tbl_PreviousPayPeriod
  ON dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod.[Encoder_ID]=dbo.SoftMed_InPatient_Only_RHO_Sums_Tbl_PreviousPayPeriod.[Encoder_ID]
  Left JOIN ['Position_Staff - Coder$']
  ON dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousPayPeriod.[Encoder_ID] = ['Position_Staff - Coder$'].enc_ID
  Left JOIN [dbo].[PayCodeSum_PayPeriod]
  ON ['Position_Staff - Coder$'].EE# = [dbo].[PayCodeSum_PayPeriod].[PERSONNUM]
  Left JOIN [dbo].[Kronos_NumDays_PPeriod]
  ON ['Position_Staff - Coder$'].EE# = [dbo].[Kronos_NumDays_PPeriod].PERSONNUM
GO