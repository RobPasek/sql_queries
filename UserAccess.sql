
ALTER DATABASE ProjectWebApp_Prod
SET SINGLE_USER WITH ROLLBACK IMMEDIATE -- MULTI_USER

GO

DBCC CHECKDB 

      ('ProjectWebApp_Prod ',REPAIR_REBUILD  )
    
 GO

ALTER DATABASE ProjectWebApp_Prod
SET MULTI_USER

GO
