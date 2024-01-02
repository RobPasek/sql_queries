SELECT     distinct ISNULL(dbo.MSP_EpmAssignmentByDay.AssignmentUID, Baseline.AssignmentUID) AS AssignmentUID
			, ISNULL(dbo.MSP_EpmAssignmentByDay.TimeByDay
			, Baseline.TimeByDay) AS TimeByDay
			, ISNULL(dbo.MSP_EpmAssignmentByDay.ProjectUID
			, Baseline.ProjectUID) AS ProjectUID
			, ISNULL(dbo.MSP_EpmAssignmentByDay.TaskUID
			, Baseline.TaskUID) AS TaskUID
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentCost], 0) 
				END AS AssignmentCost
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentOvertimeCost], 0) 
                END AS AssignmentOvertimeCost
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentActualCost], 0) 
                END AS AssignmentActualCost
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentActualOvertimeCost], 0) 
                END AS AssignmentActualOvertimeCost
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentWork], 0) 
				END AS AssignmentWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentOvertimeWork], 0) 
                END AS AssignmentOvertimeWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentActualWork], 0) 
                END AS AssignmentActualWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentActualOvertimeWork], 0) 
                END AS AssignmentActualOvertimeWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentMaterialWork], 0) 
                END AS AssignmentMaterialWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentMaterialActualWork], 0) 
                END AS AssignmentMaterialActualWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentBudgetCost], 0) 
                END AS AssignmentBudgetCost
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentBudgetWork], 0) 
                END AS AssignmentBudgetWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentBudgetMaterialWork], 0) 
                END AS AssignmentBudgetMaterialWork
			, CASE 
				WHEN [MSP_EpmAssignmentByDay].[TaskIsActive] = 0 THEN 0 
				ELSE ISNULL([MSP_EpmAssignmentByDay].[AssignmentResourcePlanWork], 0) 
                END AS AssignmentResourcePlanWork
			, dbo.MSP_EpmAssignmentByDay.TaskIsActive
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentCost - MSP_EpmAssignmentByDay.AssignmentOvertimeCost,0) 
				END AS AssignmentRegularCost
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentCost - MSP_EpmAssignmentByDay.AssignmentActualCost,0) 
				END AS AssignmentRemainingCost
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentOvertimeCost - MSP_EpmAssignmentByDay.AssignmentActualOvertimeCost,0) 
				END AS AssignmentRemainingOvertimeCost
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentActualCost - MSP_EpmAssignmentByDay.AssignmentActualOvertimeCost,0) 
				END AS AssignmentActualRegularCost
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL((MSP_EpmAssignmentByDay.AssignmentCost - MSP_EpmAssignmentByDay.AssignmentOvertimeCost) - (MSP_EpmAssignmentByDay.AssignmentActualCost - MSP_EpmAssignmentByDay.AssignmentActualOvertimeCost), 0) 
				END AS AssignmentRemainingRegularCost
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentWork - MSP_EpmAssignmentByDay.AssignmentOvertimeWork, 0) 
				END AS AssignmentRegularWork
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentWork - MSP_EpmAssignmentByDay.AssignmentActualWork, 0) 
				END AS AssignmentRemainingWork
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentOvertimeWork - MSP_EpmAssignmentByDay.AssignmentActualOvertimeWork,0) 
				END AS AssignmentRemainingOvertimeWork
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL(MSP_EpmAssignmentByDay.AssignmentActualWork - MSP_EpmAssignmentByDay.AssignmentActualOvertimeWork,0) 
				END AS AssignmentActualRegularWork
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE ISNULL((MSP_EpmAssignmentByDay.AssignmentWork - MSP_EpmAssignmentByDay.AssignmentOvertimeWork) - (MSP_EpmAssignmentByDay.AssignmentActualWork - MSP_EpmAssignmentByDay.AssignmentActualOvertimeWork), 0) 
                END AS AssignmentRemainingRegularWork
			, CASE MSP_EpmAssignmentByDay.TaskIsActive 
				WHEN 0 THEN 0 
				ELSE 
				CASE ISNULL(MSP_EpmProject.ResourcePlanUtilizationType, 0) 
                WHEN 0 THEN MSP_EpmAssignmentByDay.AssignmentWork 
				WHEN 1 THEN MSP_EpmAssignmentByDay.AssignmentResourcePlanWork 
				ELSE 
					CASE 
						WHEN MSP_EpmProject.ResourcePlanUtilizationDate > MSP_EpmAssignmentByDay.TimeByDay THEN MSP_EpmAssignmentByDay.AssignmentWork 
						ELSE MSP_EpmAssignmentByDay.AssignmentResourcePlanWork 
						END
                    END 
				END AS AssignmentCombinedWork
				, 1 AS AssignmentCount
				, Baseline.AssignmentBaseline0Cost
				, Baseline.AssignmentBaseline0Work
				, Baseline.AssignmentBaseline0MaterialWork
				, Baseline.AssignmentBaseline0BudgetCost
				, Baseline.AssignmentBaseline0BudgetWork
				, Baseline.AssignmentBaseline0BudgetMaterialWork
				, Baseline.AssignmentBaseline1Cost
				, Baseline.AssignmentBaseline1Work
				, Baseline.AssignmentBaseline1MaterialWork
				, Baseline.AssignmentBaseline1BudgetCost
				, Baseline.AssignmentBaseline1BudgetWork
				, Baseline.AssignmentBaseline1BudgetMaterialWork
				, Baseline.AssignmentBaseline2Cost
				, Baseline.AssignmentBaseline2Work
				, Baseline.AssignmentBaseline2MaterialWork, Baseline.AssignmentBaseline2BudgetCost
				, Baseline.AssignmentBaseline2BudgetWork
				, Baseline.AssignmentBaseline2BudgetMaterialWork
				, Baseline.AssignmentBaseline3Cost
				, Baseline.AssignmentBaseline3Work
				, Baseline.AssignmentBaseline3MaterialWork
				, Baseline.AssignmentBaseline3BudgetCost
				, Baseline.AssignmentBaseline3BudgetWork
				, Baseline.AssignmentBaseline3BudgetMaterialWork
				, Baseline.AssignmentBaseline4Cost
				, Baseline.AssignmentBaseline4Work
				, Baseline.AssignmentBaseline4MaterialWork
				, Baseline.AssignmentBaseline4BudgetCost
				, Baseline.AssignmentBaseline4BudgetWork
				, Baseline.AssignmentBaseline4BudgetMaterialWork
				, Baseline.AssignmentBaseline5Cost
				, Baseline.AssignmentBaseline5Work
				, Baseline.AssignmentBaseline5MaterialWork
				, Baseline.AssignmentBaseline5BudgetCost
				, Baseline.AssignmentBaseline5BudgetWork
				, Baseline.AssignmentBaseline5BudgetMaterialWork
				, Baseline.AssignmentBaseline6Cost
				, Baseline.AssignmentBaseline6Work
				, Baseline.AssignmentBaseline6MaterialWork
				, Baseline.AssignmentBaseline6BudgetCost
				, Baseline.AssignmentBaseline6BudgetWork
				, Baseline.AssignmentBaseline6BudgetMaterialWork
				, Baseline.AssignmentBaseline7Cost
				, Baseline.AssignmentBaseline7Work
				, Baseline.AssignmentBaseline7MaterialWork
				, Baseline.AssignmentBaseline7BudgetCost
				, Baseline.AssignmentBaseline7BudgetWork
				, Baseline.AssignmentBaseline7BudgetMaterialWork
				, Baseline.AssignmentBaseline8Cost
				, Baseline.AssignmentBaseline8Work
				, Baseline.AssignmentBaseline8MaterialWork
				, Baseline.AssignmentBaseline8BudgetCost
				, Baseline.AssignmentBaseline8BudgetWork
				, Baseline.AssignmentBaseline8BudgetMaterialWork
				, Baseline.AssignmentBaseline9Cost
				, Baseline.AssignmentBaseline9Work
				, Baseline.AssignmentBaseline9MaterialWork
				, Baseline.AssignmentBaseline9BudgetCost
				, Baseline.AssignmentBaseline9BudgetWork
				, Baseline.AssignmentBaseline9BudgetMaterialWork
				, Baseline.AssignmentBaseline10Cost
				, Baseline.AssignmentBaseline10Work
				, Baseline.AssignmentBaseline10MaterialWork
				, Baseline.AssignmentBaseline10BudgetCost
				, Baseline.AssignmentBaseline10BudgetWork
				, Baseline.AssignmentBaseline10BudgetMaterialWork
FROM            dbo.MSP_EpmAssignmentByDay 
			INNER JOIN dbo.MSP_EpmProject 
			ON dbo.MSP_EpmProject.ProjectUID = dbo.MSP_EpmAssignmentByDay.ProjectUID 
			FULL OUTER JOIN (SELECT ProjectUID
							, CAST(MAX(CAST(TaskUID AS nvarchar(36))) AS uniqueidentifier) AS TaskUID
							, AssignmentUID
							, TimeByDay
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 0 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost 
								ELSE NULL 
								END) AS AssignmentBaseline0Cost
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 0 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork 
								ELSE NULL 
								END) AS AssignmentBaseline0Work
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 0 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                ELSE NULL 
								END) AS AssignmentBaseline0MaterialWork
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 0 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                ELSE NULL 
								END) AS AssignmentBaseline0BudgetCost
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 0 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                ELSE NULL 
								END) AS AssignmentBaseline0BudgetWork
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 0 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                ELSE NULL 
								END) AS AssignmentBaseline0BudgetMaterialWork
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 1 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost 
								ELSE NULL 
								END) AS AssignmentBaseline1Cost
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 1 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork 
								ELSE NULL 
								END) AS AssignmentBaseline1Work
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 1 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                ELSE NULL 
								END) AS AssignmentBaseline1MaterialWork
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 1 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                ELSE NULL 
								END) AS AssignmentBaseline1BudgetCost
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 1 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                ELSE NULL 
								END) AS AssignmentBaseline1BudgetWork
							, MAX(CASE 
								WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 1 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline1BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 2 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline2Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 2 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline2Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 2 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline2MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 2 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline2BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 2 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline2BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 2 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline2BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 3 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline3Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 3 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline3Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 3 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline3MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 3 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline3BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 3 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline3BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 3 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline3BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 4 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline4Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 4 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline4Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 4 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline4MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 4 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline4BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 4 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline4BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 4 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline4BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 5 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline5Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 5 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline5Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 5 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline5MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 5 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline5BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 5 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline5BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 5 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline5BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 6 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline6Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 6 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline6Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 6 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline6MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 6 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline6BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 6 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline6BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 6 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline6BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 7 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline7Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 7 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline7Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 7 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline7MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 7 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline7BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 7 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline7BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 7 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline7BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 8 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline8Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 8 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline8Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 8 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline8MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 8 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline8BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 8 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline8BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 8 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline8BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 9 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline9Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 9 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline9Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 9 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline9MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 9 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline9BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 9 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline9BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 9 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline9BudgetMaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 10 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineCost ELSE
                                                          NULL END) AS AssignmentBaseline10Cost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 10 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineWork ELSE
                                                          NULL END) AS AssignmentBaseline10Work, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 10 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline10MaterialWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 10 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetCost
                                                          ELSE NULL END) AS AssignmentBaseline10BudgetCost, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 10 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetWork
                                                          ELSE NULL END) AS AssignmentBaseline10BudgetWork, 
                                                         MAX(CASE WHEN MSP_EpmAssignmentBaselineByDay.BaselineNumber = 10 THEN MSP_EpmAssignmentBaselineByDay.AssignmentBaselineBudgetMaterialWork
                                                          ELSE NULL END) AS AssignmentBaseline10BudgetMaterialWork
                               FROM            dbo.MSP_EpmAssignmentBaselineByDay
                               WHERE        (BaselineNumber IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
                               GROUP BY ProjectUID, AssignmentUID, TimeByDay) AS Baseline ON Baseline.ProjectUID = dbo.MSP_EpmAssignmentByDay.ProjectUID AND 
                         Baseline.AssignmentUID = dbo.MSP_EpmAssignmentByDay.AssignmentUID AND 
                         Baseline.TimeByDay = dbo.MSP_EpmAssignmentByDay.TimeByDay LEFT OUTER JOIN
                         dbo.MSP_EpmAssignment ON dbo.MSP_EpmAssignment.ProjectUID = ISNULL(dbo.MSP_EpmAssignmentByDay.ProjectUID, Baseline.ProjectUID) AND 
                         dbo.MSP_EpmAssignment.AssignmentUID = ISNULL(dbo.MSP_EpmAssignmentByDay.AssignmentUID, Baseline.AssignmentUID)