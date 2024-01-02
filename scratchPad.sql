SELECT        visit_view.discharged
			, ctc_visit.visit_detail_pt_type
			, ctc_encoderresults_view.enc_code_dt_tm
			, ctc_encoderresults_init_view.enc_code_dt_tm AS Encode_Date
			, ctc_record_hstry_view_latest_FNL.rec_hstry_trans_date_time
			, ctc_visit.is_finalized
			, LOWER(ctc_encoderresults_init_view.enc_code_id) AS Encoder_ID
			, LOWER(ctc_encoderresults_view.enc_code_id) AS Encoded_By
			, visit_view.bill_no
			, visit_view.mrn
			, visit_view.last_name
			, visit_view.first_name
			, visit_view.length_of_stay
			, ctc_encoderresults_view.enc_drg_weight
			, 0 AS [InPatient Productivity]
			, 0 AS [OutPatient Productivity]
FROM            [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.visit_view AS visit_view INNER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_encoderresults_view AS ctc_encoderresults_view ON 
                         visit_view.visit_id = ctc_encoderresults_view._fk_visit INNER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_encoderresults_init_view AS ctc_encoderresults_init_view ON 
                         visit_view.visit_id = ctc_encoderresults_init_view._fk_visit LEFT OUTER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_visit AS ctc_visit ON visit_view.visit_id = ctc_visit._fk_visit LEFT OUTER JOIN
                         [CHOC-CLSQL01].MMM_CORE_CHOC_LIVE.dbo.ctc_record_hstry_view_latest_FNL AS ctc_record_hstry_view_latest_FNL ON 
                         visit_view.visit_id = ctc_record_hstry_view_latest_FNL._fk_visit
WHERE        (ctc_visit.visit_detail_pt_type not LIKE 'IP%')