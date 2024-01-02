USE [Productivity]
GO

SELECT [Encoder_ID]
      ,[EE#]
      ,[# OP visits] = ISNULL([OutPatient_Productivity],0)
      ,AvgOPDRG = ISNULL([Summed Outpatient Drg's],0)
      ,[InPatient_Productivity] = ISNULL([InPatient_Productivity],0)
      ,AvgIPDRG = ISNULL([Summed Inpatient Drg's],0)
      ,[IpProductivity] = 0 
      ,[OpProductivity] = 0 
      ,[Hourly Productivity] = 0 
      ,[Total REG-1] = [Reg-1]
      ,[Total REG-2] = [Reg-2]
      ,[Total OT] = [OT_Hours]
  FROM [dbo].[Productivity_prevDay]
GO


