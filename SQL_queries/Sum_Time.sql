SELECT DISTINCT [enc_code_id]
      ,SUM(DATEDIFF(MINUTE,[enc_code_dt_tm],[rec_hstry_trans_date_time]) )[Time To Complete (in minutes)]
      
      
  FROM [Productivity_Report].[dbo].[SoftMed_ExtractNew]

  

  GROUP BY [enc_code_id]