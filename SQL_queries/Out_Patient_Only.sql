GO
DROP TABLE dbo.OUT_Patient_Only
GO
--out patient only
SELECT DISTINCT [SoftMed_OutPatient_Daily_Productivity].enc_code_id
      --,[SoftMed_OutPatient_Daily_Productivity].[EE#]
      ,[SoftMed_OutPatient_Daily_Productivity].[Number of Visits]
	  ,[SoftMed_OutPatient_Daily_Productivity].[Total OT]
	  ,[dbo].[SoftMed_OutPatient_Daily_Productivity].[Out Patient HIM Productivity]
	  ,[SoftMed_OutPatient_Daily_Productivity].[Kronos Productivity] AS [Kronos Out Patient Productivity]
	  ,[SoftMed_OutPatient_Daily_Productivity].[Summed DRG's] AS [Out Patient Summed Drg's]
      ,[SoftMed_OutPatient_Daily_Productivity].[Adjusted DRG Weight] AS [Out Patient DRG Weight]
	  ,[SoftMed_InPatient_Daily_Productivity].[Length of Stay]
	  ,[SoftMed_InPatient_Daily_Productivity].[In Patient HIM Productivity]
	  ,[SoftMed_InPatient_Daily_Productivity].[Kronos In Patient Productivity]
      ,[dbo].[SoftMed_InPatient_Daily_Productivity].[Summed DRG's] AS [In Patient Summed Drg's]
      ,[dbo].[SoftMed_InPatient_Daily_Productivity].[Adjusted DRG Weight] AS [In Patient DRG Weight]
  INTO Productivity.dbo.OUT_Patient_Only
  FROM [dbo].[SoftMed_OutPatient_Daily_Productivity]
  LEFT JOIN [dbo].[SoftMed_InPatient_Daily_Productivity]
  ON [dbo].[SoftMed_OutPatient_Daily_Productivity].EE# = [dbo].[SoftMed_InPatient_Daily_Productivity].EE#
  WHERE [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'rnguyen'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'nneaves'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'dmullaly'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'msaldana'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'mcullen'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'lksst'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'kyamada'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].enc_code_id <> 'jseaman'
GO