Select [visit_view].[last_name]
	,[visit_view].[first_name]
	,[visit_view].[middle_name]
	,[visit_view].[bill_no]
	,[visit_view].[admission_date]
	,[visit_view].[patient_type]
	,[visit_view].[v_facility_code]
	,[visit_view].[discharged]
	,[visit_view].[v_financial_cls]
	,[visit_view].[mrn]
	,[visit_view].[length_of_stay]
	,[ctc_visit].[visit_detail_pt_type]
	,[ctc_visit].[is_finalized]
	,[ctc_encoderresults_view].[enc_drg_weight]
	,[ctc_encoderresults_view].[enc_code_id]
	,[ctc_encoderresults_view].[enc_code_dt_tm]
	,[ctc_record_hstry_view_latest_FNL].[rec_hstry_trans_date_time]
	,[ctc_procedure].[proc_sequence_num]
	,[ctc_diagnosis].[diag_sequence_num]
	,[ctc_encoderresults_init_view].[enc_code_id]
	,[ctc_encoderresults_init_view].[enc_code_dt_tm]
FROM
[CHOC-CLSQL01].[MMM_CORE_CHOC_LIVE].[dbo].[visit_view]
,[CHOC-CLSQL01].[MMM_CORE_CHOC_LIVE].[dbo].[ctc_visit]
,[CHOC-CLSQL01].[MMM_CORE_CHOC_LIVE].[dbo].[ctc_encoderresults_view]
,[CHOC-CLSQL01].[MMM_CORE_CHOC_LIVE].[dbo].[ctc_encoderresults_init_view]
,[CHOC-CLSQL01].[MMM_CORE_CHOC_LIVE].[dbo].[ctc_record_hstry_view_latest_FNL]
,[CHOC-CLSQL01].[MMM_CORE_CHOC_LIVE].[dbo].[ctc_procedure]
,[CHOC-CLSQL01].[MMM_CORE_CHOC_LIVE].[dbo].[ctc_diagnosis]

WHERE
[visit_view].[visit_id] = [ctc_visit].[_fk_visit]
AND [visit_view].[patient_type] = 'IP'
AND [ctc_visit].[is_finalized] <> 'N'
AND [visit_view].[discharged] <> ''

AND [visit_view].[visit_id] = [ctc_encoderresults_view].[_fk_visit]
AND [visit_view].[visit_id] = [ctc_record_hstry_view_latest_FNL].[_fk_visit]
AND [visit_view].[visit_id] = [ctc_procedure].[_fk_visit]
AND [visit_view].[visit_id] = [ctc_diagnosis].[_fk_visit]
AND [visit_view].[visit_id] = [ctc_encoderresults_init_view].[_fk_visit]
AND [ctc_encoderresults_init_view].[enc_code_dt_tm] <> ''

AND [ctc_encoderresults_init_view].[enc_code_dt_tm] >= DATEADD(DAY, -1, convert(date, GETDATE()))
AND [ctc_encoderresults_init_view].[enc_code_dt_tm] < convert(date, GETDATE())

ORDER BY [ctc_encoderresults_init_view].[enc_code_id]