USE [Productivity]
GO
DROP TABLE DBO.CODERS_PREVIOUS_DAY
GO

SELECT CAST(DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())) AS DATE) AS [Coders Date For Previous Day]
INTO DBO.CODERS_PREVIOUS_DAY
GO

Drop Table dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay
GO
SELECT DISTINCT 
                      [Encoded_By]
					  , SUM(enc_drg_weight) AS [Summed Outpatient Drg's], COUNT(enc_drg_weight) as [opDRGNum], COUNT([bill_no]) AS [# Bills Coded], [InPatient Productivity]
					  , COUNT(length_of_stay) AS [OutPatient Productivity]
INTO dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay
FROM         dbo.SoftMed_OutPatient_Only
WHERE (CONVERT(VARCHAR(10), [enc_code_dt_tm], 110) = DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())))

GROUP BY [Encoded_By] 
, [InPatient Productivity]
GO
DROP TABLE dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay
GO
SELECT DISTINCT [Encoded_By]
					  , SUM(enc_drg_weight) AS [Summed Inpatient Drg's] 
					  , COUNT(enc_drg_weight) as [ipDRGNum]
                      , SUM([length_of_stay]) AS [Summed Length of Stay]
					  ,SUM([length_of_stay]) AS [InPatient Productivity], 
                      [OutPatient Productivity]
INTO dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay
FROM         dbo.SoftMed_InPatient_Only
                     
WHERE (CONVERT(VARCHAR(10), [enc_code_dt_tm], 110) = DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())))

GROUP BY [Encoded_By]
, [OutPatient Productivity]

GO
DROP TABLE myUnion_Encoder_ID

GO

Select DISTINCT Encoder_ID
INTO myUnion_Encoder_ID

FROM SoftMed_2month

WHERE Encoder_ID <> 'NULL'
AND Encoder_ID <> 'jbelt'
AND Encoder_ID <> 'tperies'
AND Encoder_ID <> 'khawkins'
AND Encoder_ID <> 'jcruz'
AND Encoder_ID <> 'dmullaly'

GO

DROP Table dbo.SoftMed_Previous_Day
GO

SELECT dbo.myUnion_Encoder_ID.Encoder_ID
	  ,['Position_Staff - Coder$'].EE#
      ,cast(round(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[Summed Inpatient Drg's]/dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.ipDRGNum,2) as decimal(18,2)) AS [AvgIPDRG]
	  ,cast(round(dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[Summed Outpatient Drg's]/dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.opDRGNum,2) as decimal(18,2)) AS [AvgOPDRG]
      ,dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[Summed Length of Stay] AS [TotalIPLOS]
	  ,dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[# Bills Coded] AS [# OP visits]
	  ,CASE 	
			WHEN ([dbo].['Position_Staff - Coder$'].[EE#] = '5121') THEN (cast(round(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[InPatient Productivity]/(ISNULL([dbo].[PayCodeSum_Daily].[Reg-2] ,0)+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)),2,0) as decimal(18,2)))
			WHEN ([dbo].['Position_Staff - Coder$'].[EE#] = '6367') THEN (cast(round(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[InPatient Productivity]/(ISNULL([dbo].[PayCodeSum_Daily].[Reg-2] ,0)+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)),2,0) as decimal(18,2)))
			ELSE (cast(round(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[InPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)),2,0) as decimal(18,2)))
		END
      [IpProductivity] 
	  ,cast(round(dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[OutPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)),2,0) as decimal(18,2)) AS [OpProductivity]
	  ,cast(round(ISNULL(dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[InPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)),0)+ISNULL((dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[OutPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0))),0),0) as decimal(18,2)) AS [Hourly Productivity]
	  ,cast(ISNULL([dbo].[PayCodeSum_Daily].[Reg-1] ,0) as decimal(18,2)) AS [Total REG-1]
      ,cast(ISNULL([dbo].[PayCodeSum_Daily].[Reg-2] ,0) as decimal(18,2)) AS [Total REG-2]
      ,cast(ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0) as decimal(18,2)) AS [Total OT]
  INTO dbo.SoftMed_Previous_Day
  FROM dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay
  FULL JOIN dbo.myUnion_Encoder_ID
  ON dbo.myUnion_Encoder_ID.Encoder_ID = dbo.SoftMed_OutPatient_Only_Sums_Tbl_PreviousDay.[Encoded_By] 
  FULL JOIN dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay
  ON dbo.myUnion_Encoder_ID.Encoder_ID= dbo.SoftMed_InPatient_Only_Sums_Tbl_PreviousDay.[Encoded_By]  
  LEFT JOIN ['Position_Staff - Coder$']
  ON dbo.myUnion_Encoder_ID.Encoder_ID = ['Position_Staff - Coder$'].enc_ID
  LEFT JOIN [dbo].[PayCodeSum_Daily]
  ON ['Position_Staff - Coder$'].EE# = [dbo].[PayCodeSum_Daily].[PERSONNUM]
GO

Drop Table dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay
GO
SELECT DISTINCT 
                      Encoded_By, SUM(enc_drg_weight) AS [Summed Outpatient Drg's],count(enc_drg_weight) as [opDRGcount] , SUM(length_of_stay) AS [Summed Length of Stay], [InPatient Productivity], COUNT(bill_no) 
                      AS [OutPatient Productivity]
INTO dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay
FROM         dbo.SoftMed_OutPatient_Coders_Only
WHERE (CONVERT(VARCHAR(10), [Encode_Date], 110) = DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())))

GROUP BY Encoded_By, [InPatient Productivity]
GO

DROP TABLE dbo.OutPatient_Encoder_ID
GO 
 
Select DISTINCT Encoder_ID
INTO OutPatient_Encoder_ID
FROM SoftMed_2month

WHERE Encoder_ID <> 'NULL'
AND Encoder_ID <> 'jseaman'
AND Encoder_ID <> 'kyamada'
AND Encoder_ID <> 'mcullen'
AND Encoder_ID <> 'msaldana'
AND Encoder_ID <> 'lksst'
AND Encoder_ID <> 'nneaves'
AND Encoder_ID <> 'rnguyen'
AND Encoder_ID <> 'dmullaly'

GO


DROP Table dbo.SoftMed_OutPatientCoders_Only_Previous_Day
GO
SELECT [dbo].[OutPatient_Encoder_ID].[Encoder_ID]
	  ,['Position_Staff - Coder$'].EE#
      ,cast(round(dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.[Summed Outpatient Drg's]/dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.opDRGcount,2) as decimal(18,2)) AS [AvgOPDRG]
      ,cast(round(dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.[OutPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)),2) as decimal(18,2)) AS [Hourly Productivity]
	  ,dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.[OutPatient Productivity] AS [#OP Visits]
	  ,cast(round(ISNULL([dbo].[PayCodeSum_Daily].[Reg-1] ,0),2) as decimal(18,2)) AS [Total REG-1]
      ,cast(round(ISNULL([dbo].[PayCodeSum_Daily].[Reg-2] ,0),2) as decimal(18,2)) AS [Total REG-2]
      ,cast(round(ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0),2) as decimal(18,2)) AS [Total OT]
  INTO dbo.SoftMed_OutPatientCoders_Only_Previous_Day
  FROM dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay
  FULL JOIN dbo.OutPatient_Encoder_ID
  ON dbo.OutPatient_Encoder_ID.Encoder_ID = dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.Encoded_By
  Left JOIN ['Position_Staff - Coder$']
  ON dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.Encoded_By = ['Position_Staff - Coder$'].enc_ID
  Left JOIN [dbo].[PayCodeSum_Daily]
  ON ['Position_Staff - Coder$'].EE# = [dbo].[PayCodeSum_Daily].[PERSONNUM]
  GROUP BY [dbo].[OutPatient_Encoder_ID].[Encoder_ID]
	  ,['Position_Staff - Coder$'].EE#
	  ,dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.[Summed Outpatient Drg's]/dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.opDRGcount
	  ,dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.[OutPatient Productivity]/(5.9+ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0))
	  ,dbo.SoftMed_OutPatient_Coders_Only_Sums_Tbl_PreviousDay.[OutPatient Productivity]
	  ,ISNULL([dbo].[PayCodeSum_Daily].[Reg-1] ,0) 
      ,ISNULL([dbo].[PayCodeSum_Daily].[Reg-2] ,0) 
      ,ISNULL([dbo].[PayCodeSum_Daily].[Total OT],0)
GO
