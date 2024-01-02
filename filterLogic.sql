=switch(Fields!EnterpriseProjectTypeName.Value = "Evaluation" , "Proposal",
Fields!EnterpriseProjectTypeName.Value <> "Evaluation" and Fields!Project_Stage.Value = "04 Close"and Fields!Project_Status.Value = "02 In Progress","Closing",
Fields!EnterpriseProjectTypeName.Value <> "Evaluation" and Fields!Project_Stage.Value <> "00 Evaluate" and Fields!Project_Status.Value = "01 Scheduled","Scheduled",
Fields!EnterpriseProjectTypeName.Value <> "Evaluation" and Fields!Project_Stage.Value <> "00 Evaluate" and Fields!Project_Status.Value = "04 On Hold","OnHold",
Fields!EnterpriseProjectTypeName.Value <> "Evaluation" and Fields!Project_Stage.Value <> "00 Evaluate" and Fields!Project_Status.Value = "05 Cancelled","Cancelled",
Fields!EnterpriseProjectTypeName.Value <> "Evaluation" and Fields!Go_Live_Date.Value = "Yes" and Fields!TaskFinishDate.Value > Fields!TaskBaseline0FinishDate.Value ,"Behind",
Fields!EnterpriseProjectTypeName.Value <> "Evaluation" and Fields!Project_Stage.Value <> "00 Evaluate" and Fields!Project_Status.Value = "02 In Progress","InProgress",
Fields!EnterpriseProjectTypeName.Value <> "Evaluation" and Fields!Project_Stage.Value = "04 Close" and Fields!Project_Status.Value = "03 Completed","Completed",
true,"InProgress")