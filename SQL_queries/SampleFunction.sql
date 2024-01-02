USE [CHOC_Analytic]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GetCernerCodeValueCode]    Script Date: 5/27/2014 11:30:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[FN_GetCernerCodeValueCode] 
(@LookupField nvarchar(100),
 @CodeSet nvarchar(10),
 @SearchText nvarchar(100)
) 
returns nvarchar(100) 

Begin 

/*
Create by: Jessica Hsieh 
Create Date: 1/9/2014
Purpose: Retrieve Code_Value code from Code_Value table for the Display, code_set.
*/

Declare @RetValue nvarchar (100) 
set @RetValue = ''

If UPPER(@LookupField) = 'MEANING' 
	select @RetValue = cv.code_value from [dbo].[STGIn_Cerner_Code_Value] cv where cv.CODE_SET = @CodeSet and cv.CDF_MEANING = @SearchText
Else If UPPER(@LookupField) = 'DISPLAYKEY'
	select @RetValue = cv.code_value from [dbo].[STGIn_Cerner_Code_Value] cv where cv.CODE_SET = @CodeSet and cv.DISPLAY_KEY = @SearchText
Else If UPPER(@LookupField) = 'DESCRIPTION'
	select @RetValue = cv.code_value from [dbo].[STGIn_Cerner_Code_Value] cv where cv.CODE_SET = @CodeSet and cv.[DESCRIPTION] = @SearchText
Else If UPPER(@LookupField) = 'DISPLAY'
	select @RetValue = cv.code_value from [dbo].[STGIn_Cerner_Code_Value] cv where cv.CODE_SET = @CodeSet and cv.DISPLAY = @SearchText

Return ISNULL(@RetValue, '');

End 



--select * from [dbo].[STGIn_Cerner_Code_Value] cv where cv.CODE_SET = 333 and cv.CDF_MEANING= 'ATTENDDOC'

--select [dbo].[FN_GetCernerCodeValueCode] ( 'Meaning', '333', 'ATTNDDOC')
GO

