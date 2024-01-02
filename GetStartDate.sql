SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Robert Pasek>
-- Create date: <Create Date, 6/24/2014>
-- Description:	<Description, populates the date of a variable depenting on what is its own values>
-- =============================================
CREATE FUNCTION [DBO].[GetStartDate]
(@timePeriod nvarchar (20)
/*prevDay,CurrentPP, PrevPP*/
) 

RETURNS DATE

BEGIN
	
	DECLARE @retValue DATE
	SET @retValue = ''

	
	if @timePeriod = 'prevDay'
			SELECT @retValue = CAST(DATEADD(dd, - 1, DATEDIFF(dd, 0, GETDATE())) AS DATE);
	ELSE if @timePeriod = 'CurrentPP'
		    SELECT TOP 1 @retValue =
			  CAST(CURRPAYPERIODSTART AS DATE) 
			FROM [CHOCNT-097].wfcdb.dbo.VP_TOTALS
	ELSE if @timePeriod = 'PrevPP'
		SELECT TOP 1 @retValue = 
			 CAST(PREVPAYPERIODEND AS DATE) 
		FROM [CHOCNT-097].wfcdb.dbo.VP_TOTALS

	-- Return the result of the function
	RETURN @retValue;

END
GO

