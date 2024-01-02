USE [Productivity]
GO
DROP TABLE [dbo].[Combined_HIM_Coders]
--Combined Patient Types 
SELECT DISTINCT [dbo].[SoftMed_2month].[Encoded_By]
      ,[SoftMed_OutPatient_Daily_Productivity].[EE#]
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
 INTO [dbo].[Combined_HIM_Coders]
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
////////////////////////////////////NEWER VERSION/////////////////////////
USE [Productivity]
GO
DROP TABLE [dbo].[Combined_HIM_Coders]
go
SELECT DISTINCT [dbo].[HIM_Coders].[Encoder_ID]
	  ,[SoftMed_OutPatient_Daily_Productivity].[EE#]
	  ,[SoftMed_OutPatient_Daily_Productivity].EE# AS [InPatient EE#]
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
 INTO [dbo].[Combined_HIM_Coders]
  FROM [dbo].[HIM_Coders]
  LEFT JOIN [dbo].[SoftMed_OutPatient_Daily_Productivity] 
  ON [dbo].[HIM_Coders].[Encoder_ID]= [dbo].[SoftMed_OutPatient_Daily_Productivity].[enc_ID]
  Right JOIN [dbo].[SoftMed_InPatient_Daily_Productivity]
  ON [dbo].[HIM_Coders].[Encoder_ID] = [dbo].[SoftMed_InPatient_Daily_Productivity].[Encoder_ID]
  
GO

//////////////////////////////Newest Version//////////////////////////////////////////

USE [Productivity]
GO
DROP TABLE [dbo].[Combined_HIM_Coders]
go
SELECT DISTINCT [dbo].[SoftMed_OutPatient_Daily_Productivity].[Encoded_BY] AS [Out Patients Enc]
	  ,[dbo].[SoftMed_InPatient_Daily_Productivity].[Encoded_BY] AS [In Patient Enc]
	  ,[SoftMed_OutPatient_Daily_Productivity].[EE#]
	  ,[SoftMed_OutPatient_Daily_Productivity].EE# AS [InPatient EE#]
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
  INTO [dbo].[Combined_HIM_Coders]
  FROM [dbo].[SoftMed_OutPatient_Daily_Productivity]
 
  FULL OUTER JOIN [dbo].[SoftMed_InPatient_Daily_Productivity]
  ON [dbo].[SoftMed_OutPatient_Daily_Productivity].[EE#] = [dbo].[SoftMed_InPatient_Daily_Productivity].[EE#]
  WHERE enc_code_id <> 'khawkins'
   AND enc_code_id <> 'jbelt'
   AND enc_code_id <> 'tperies'
   AND [SoftMed_InPatient_Daily_Productivity].[Encoder_ID] <> 'khawkins' 
   AND [SoftMed_InPatient_Daily_Productivity].[Encoder_ID] <> 'jbelt' 
   AND [SoftMed_InPatient_Daily_Productivity].[Encoder_ID] <> 'tperies'

  
GO

