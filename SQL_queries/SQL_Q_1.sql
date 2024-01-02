AND [ctc_encoderresults_init_view].[enc_code_dt_tm] >= dateadd(day,datediff(day,1,GETDATE()),0)
AND [ctc_encoderresults_init_view].[enc_code_dt_tm] < dateadd(day,datediff(day,0,GETDATE()),0)