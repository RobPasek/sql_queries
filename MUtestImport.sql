USE [Meaningful_Use_Compliance]
GO
DROP TABLE [dbo].[Provider_Payment_Status]
GO
SELECT [ID]=IDENTITY (int,1,1) 
	  ,[NPI]
      ,[MU_Reporting_Period_Start]
      ,[MU_Reporting_Period_End]
	  ,[Expected_payment]
	  ,[Program_Year]
      ,[MU_Stage]
      ,[ATTESTATION]
	  ,cast(NULL as varchar(20)) AS [EXPECTEDPROVIDERPAYMENT]
	  ,cast(NULL as varchar(20)) AS [ExpectedFiscalYearPayment]
	  ,[AMOUNTRECEIVED]
	  ,[PAYMENTDATE]
      ,[ARNUMBER]
      ,[CHECKNUMBER]
      ,[Fiscal_Year]
	  ,cast(NULL as varchar(20)) AS [CHOCREC] 
      --,cast(NULL as varchar(20)) AS [GLCODE]
	  ,cast(NULL as varchar(20)) AS [WARRANTNUM]
	  ,cast(NULL as varchar(20)) AS [POSTDATE]
  INTO [dbo].[Provider_Payment_Status]
  FROM [dbo].[Sheet2$]
GO
ALTER TABLE [dbo].[Provider_Payment_Status] 
  ADD CONSTRAINT PK_Provider_Payment_Status
  PRIMARY KEY (ID);
  
GO
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [NPI] int

GO

ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [MU_Reporting_Period_Start] nvarchar(25)

GO	
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [MU_Reporting_Period_End] nvarchar(25)
 
GO	

ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [Expected_payment] nvarchar(25)
 
GO	
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [Program_Year] nvarchar(25)
 
GO
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [MU_Stage] nvarchar(25)
 
GO
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [ATTESTATION] nvarchar(25)
 
GO
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [AMOUNTRECEIVED] nvarchar(25)
 
GO
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [PAYMENTDATE] nvarchar(25)
 
GO
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [ARNUMBER] nvarchar(25)
 
GO
ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [CHECKNUMBER] nvarchar(25)
 
GO

ALTER TABLE [dbo].[Provider_Payment_Status]
ALTER COLUMN [Fiscal_Year] nvarchar(25)
 
GO


