SELECT        ProjectUID
			, Title
			, AssignedToResource
			, Status
			, Category
			, Description
			, MitigationPlan
			, Exposure
			, DueDate
			, CreatedDate
FROM            MSP_WssRisk AS R
WHERE Status <> '(3) Closed'