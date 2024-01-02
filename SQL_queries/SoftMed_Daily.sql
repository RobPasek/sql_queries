USE [Productivity]
GO
Drop Table dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay
GO
SELECT DISTINCT 
                      Encoder_ID, SUM(enc_drg_weight) AS [Summed Outpatient Drg's], SUM(length_of_stay) AS [Summed Length of Stay], [InPatient Productivity], COUNT(bill_no) 
                      AS [OutPatient Productivity]
INTO dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay
FROM         dbo.SoftMed_OutPatient_Only
WHERE (CONVERT(VARCHAR(10), enc_code_dt_tm, 110) = DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())))

GROUP BY Encoder_ID, [InPatient Productivity]
GO
DROP TABLE
dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay
GO
SELECT DISTINCT  Encoder_ID
					  , SUM(enc_drg_weight) AS [Summed Inpatient Drg's], 
                      SUM(length_of_stay) AS [Summed Length of Stay], SUM(length_of_stay) AS [InPatient Productivity], 
                      [OutPatient Productivity]
INTO dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay
FROM         dbo.SoftMed_InPatient_Only
                     
WHERE (CONVERT(VARCHAR(10), enc_code_dt_tm, 110) = DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())))

GROUP BY Encoder_ID, [OutPatient Productivity]

GO
DROP TABLE myUnion_Encoder_ID
GO
SELECT * INTO myUnion_Encoder_ID
FROM 
(
SELECT DISTINCT dbo.SoftMed_OutPatient_Only.Encoder_ID
FROM         dbo.SoftMed_OutPatient_Only
UNION
SELECT DISTINCT dbo.SoftMed_InPatient_Only.Encoder_ID
FROM         dbo.SoftMed_InPatient_Only
)Encoder_ID
GO

DROP Table dbo.SoftMed_Previous_Day
GO

SELECT dbo.myUnion_Encoder_ID.Encoder_ID
	  ,['Position_Staff - Coder$'].EE#
      ,dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[Summed Inpatient Drg's] AS [InpatientDrgSum]
	  ,dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[Summed Outpatient Drg's] AS [OutpatientDrgSum]
      ,dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[Summed Length of Stay] AS [InpatientLengthOfStay]
	  ,dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[Summed Length of Stay] AS [OutPatientLengtOfStay]
	  ,dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[InPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)) AS [IpProductivity]
      ,dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[OutPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)) AS [OpProductivity]
	  ,ISNULL([dbo].[PayCodeSum_Daily].[Reg-1] ,0) AS [Total REG-1]
      ,ISNULL([dbo].[PayCodeSum_Daily].[Reg-2] ,0) AS [Total REG-2]
      ,ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0) AS [Total OT]
  INTO dbo.SoftMed_Previous_Day
  FROM dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay
  FULL JOIN dbo.myUnion_Encoder_ID
  ON dbo.myUnion_Encoder_ID.Encoder_ID = dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[Encoder_ID]
  LEFT JOIN dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay
  ON dbo.MyUnion_Encoder_ID.Encoder_ID= dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.Encoder_ID
  Left JOIN ['Position_Staff - Coder$']
  ON dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[Encoder_ID] = ['Position_Staff - Coder$'].enc_ID
  Left JOIN [dbo].[PayCodeSum_Daily]
  ON ['Position_Staff - Coder$'].EE# = [dbo].[PayCodeSum_Daily].[PERSONNUM]
GO


