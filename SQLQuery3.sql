SELECT        B.ProjectUID
			, B.Title
			, B.AssignedToResource
			, CASE 
				WHEN B.Status = '(1) Active' 
					THEN 'Active' 
						WHEN B.Status = '(2) Postponed' 
					THEN 'Postponed' 
						WHEN B.Status = '(3) Closed' 
					THEN 'Closed' 
						ELSE B.Status
                END AS Status
			, CASE 
				WHEN B.Category = '01 Resources' 
					THEN 'Resources' 
				WHEN B.Category = '02 Cost' 
					THEN 'Cost' 
				WHEN B.Category = '03 Schedule' 
					THEN 'Schedule' 
				ELSE B.Category 
			END AS Category
			, B.Description
			, B.MitigationPlan
			, B.Exposure
			, B.DueDate
			, B.CreatedDate
			, A.datetime2 AS [Risk Identification Date]
FROM WSS_Content_CHOC.dbo.AllUserData AS A 
	INNER JOIN MSP_WssRisk AS B 
	ON A.tp_DocId = B.RiskUniqueID
WHERE        (B.Status <> '(3) Closed')