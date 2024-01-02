USE Productivity
GO
SELECT       LOWER(ctc_encoderresults_view.enc_code_id) AS Encoded_By
			, ctc_record_hstry_view_latest_FNL.rec_hstry_trans_date_time
			, [visit_view.bill_no] = COUNT(visit_view.bill_no)
			, [visit_view.length_of_stay] = SUM(visit_view.length_of_stay)
			, [ctc_encoderresults_view.enc_drg_weight] = SUM(ctc_encoderresults_view.enc_drg_weight)
			
FROM            [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.visit_view AS visit_view INNER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_encoderresults_view AS ctc_encoderresults_view ON 
                         visit_view.visit_id = ctc_encoderresults_view._fk_visit INNER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_encoderresults_init_view AS ctc_encoderresults_init_view ON 
                         visit_view.visit_id = ctc_encoderresults_init_view._fk_visit LEFT OUTER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_visit AS ctc_visit ON visit_view.visit_id = ctc_visit._fk_visit LEFT OUTER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_record_hstry_view_latest_FNL AS ctc_record_hstry_view_latest_FNL ON 
                         visit_view.visit_id = ctc_record_hstry_view_latest_FNL._fk_visit
WHERE CAST(ctc_encoderresults_view.enc_code_dt_tm AS date) BETWEEN CAST(DATEADD(dd, - 120, DATEDIFF(dd, 0, GETDATE()))AS DATE)  AND CAST(DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())) AS DATE)
--AND (SELECT DISTINCT CURRPAYPERIODEND FROM dbo.Kronos_Previous_PP_Curr_PP)
--AND CAST(enc_code_dt_tm  AS DATE) < CAST(GETDATE() AS DATE)
AND LOWER(ctc_encoderresults_view.enc_code_id) <> 'jbelt'
AND LOWER(ctc_encoderresults_view.enc_code_id) <> 'tperies'
AND LOWER(ctc_encoderresults_view.enc_code_id) <> 'khawkins'
AND LOWER(ctc_encoderresults_view.enc_code_id) <> 'jcruz'        
/*(CAST(ctc_encoderresults_view.enc_code_dt_tm AS DATE) <= CAST(DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())) AS DATE)) 
			 AND (CAST(ctc_encoderresults_init_view.enc_code_dt_tm AS DATE) >= CAST(DATEADD(MONTH, - 1, CONVERT(date, GETDATE())) AS DATE))*/
GROUP BY LOWER(ctc_encoderresults_view.enc_code_id),ctc_record_hstry_view_latest_FNL.rec_hstry_trans_date_time 