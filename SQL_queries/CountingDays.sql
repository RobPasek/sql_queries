USE [Productivity]
GO

SELECT DISTINCT  (CONVERT(VARCHAR(10), rec_hstry_trans_date_time, 110))
      , [Encoded_By]
      ,COUNT((CONVERT(VARCHAR(10), rec_hstry_trans_date_time, 110)))
	  
	  
  FROM [dbo].[SoftMedTest]
 
  GROUP BY [rec_hstry_trans_date_time],[Encoded_By]
  
GO


