INSERT INTO [dbo].[PARSIS]
           ([ParCod]
           ,[ParDsc]
           ,[ParTipPar]
           ,[ParTamPar]
           ,[ParQtdDec]
           ,[ParIndSin]
           ,[ParCon]
           ,[ParUsuInc]
           ,[ParDtiInc]
           ,[ParUsuAlt]
           ,[ParDtiAlt]
           ,[ParFlgInt])
     VALUES
           ('DIRETORIO_LOGSIS' 
           ,'Diretorio onde fica os logs do sistema'
           ,'CA'
           ,10
           ,NULL
		   ,'N'
           ,'/mnt/home1/sistema/logs'
           ,NULL
           ,NULL
           ,NULL
           ,'2022-12-13 15:00:36.000'
           ,0)
GO