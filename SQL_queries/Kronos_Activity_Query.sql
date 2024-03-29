SELECT    APPLYDATE
		, PAYCODENAME
		, SUM(TIMEINSECONDS) / 60 AS MinutesWorked
		, PERSONNUM
		, PERSONFULLNAME
		, LABORLEVELNAME2 AS position
		, LABORLEVELDSC2 AS title
		, PAYCODEID
		, PERSONID
		, CURRPAYPERIODSTART
		, CURRPAYPERIODEND
		, PREVPAYPERIODSTART
		, PREVPAYPERIODEND
		, LABORLEVELNAME3 AS [Activity]
FROM [CHOCNT-097].wfcdb.dbo.VP_TOTALS AS VP_TOTALS_1
WHERE     (PAYCODETYPE = 'P') 
AND (PAYCODENAME <> 'Previous Pay Period Approved') 
AND (PAYCODENAME <> '12HRDT-1') 
AND (APPLYDATE = DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())))
--AND LABORLEVELNAME3 > 11111111
GROUP BY APPLYDATE, PAYCODENAME, TIMEINSECONDS, PERSONNUM, PERSONFULLNAME, LABORLEVELNAME2, LABORLEVELDSC2, PAYCODEID, PERSONID, 
                      CURRPAYPERIODSTART, CURRPAYPERIODEND, PREVPAYPERIODSTART, PREVPAYPERIODEND, LABORLEVELNAME3