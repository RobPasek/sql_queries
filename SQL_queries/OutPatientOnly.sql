USE [Productivity]
GO
--out patient only
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
  ON [dbo].[SoftMed_2month].[Encoded_By]= [dbo].[SoftMed_InPatient_Daily_Productivity].[Encoded_By]
  
  WHERE [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'rnguyen'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'nneaves'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'dmullaly'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'msaldana'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'mcullen'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'lksst'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'kyamada'
  AND [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_By] <> 'jseaman'
GO