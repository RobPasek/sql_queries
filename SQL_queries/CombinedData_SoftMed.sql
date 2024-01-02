USE [Productivity]
GO
--out patient
SELECT DISTINCT [dbo].[SoftMed_2month].[Encoded_By]
      ,[SoftMed_OutPatient_Daily_Productivity].[EE#]
      ,[SoftMed_OutPatient_Daily_Productivity].[Number of Visits]
	  ,[SoftMed_OutPatient_Daily_Productivity].[Adjusted HIM Productivity] AS [Out Patient HIM Productivity]
	  ,[SoftMed_OutPatient_Daily_Productivity].[Summed DRG's] AS [Out Patient Summed Drg's]
      ,[SoftMed_OutPatient_Daily_Productivity].[Adjusted DRG Weight] AS [Out Patient DRG Weight]
	  ,[SoftMed_InPatient_Daily_Productivity].[Length of Stay]
	  ,[SoftMed_InPatient_Daily_Productivity].[Adjusted HIM Productivity]
      ,[dbo].[SoftMed_InPatient_Daily_Productivity].[Summed DRG's] AS [In Patient Summed Drg's]
      ,[dbo].[SoftMed_InPatient_Daily_Productivity].[Adjusted DRG Weight] AS [In Patient DRG Weight]
      
  FROM [dbo].[SoftMed_2month]
  LEFT JOIN [dbo].[SoftMed_OutPatient_Daily_Productivity] 
  ON [dbo].[SoftMed_2month].[Encoded_By]= [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By]
  LEFT JOIN [dbo].[SoftMed_InPatient_Daily_Productivity]
  ON [dbo].[SoftMed_2month].[Encoded_By] = [dbo].[SoftMed_InPatient_Daily_Productivity].[Encoded_By]
  WHERE [dbo].[SoftMed_2month].[Encoded_By] <> 'khawkins'
  AND [dbo].[SoftMed_2month].[Encoded_By] <> 'jbelt'
  AND [dbo].[SoftMed_2month].[Encoded_By] <> 'dmullaly'
  AND [dbo].[SoftMed_2month].[Encoded_By] <> 'tperies'
  AND [dbo].[SoftMed_2month].[Encoded_By] <> 'jcruz'
GO