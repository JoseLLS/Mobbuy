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
           ('GERAR_DATA_COMISSAO' 
           ,'Data especifica para gerar comissão dos representantes.'
           ,'CA'
           ,200
           ,NULL
		   ,'N'
           ,'2021-12-08'
           ,NULL
           ,NULL
           ,NULL
           ,'2022-07-11 10:00:36.000'
           ,0)
GO

-- update parsis set parcon = '' where parcod = 'GERAR_DATA_COMISSAO'
-- update parsis set parcon = '2021-12-08' where parcod = 'GERAR_DATA_COMISSAO'