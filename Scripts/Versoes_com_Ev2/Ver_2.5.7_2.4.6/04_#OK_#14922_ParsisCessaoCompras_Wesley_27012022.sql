USE pronto

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
           ('TELA_GESTAO_COMPRAS' 
           ,'Usar tela de gestão de compras.'
           ,'CA'
           ,200
           ,NULL
		   ,'N'
           ,'S'
           ,NULL
           ,NULL
           ,'025ADM                           '
           ,'2022-01-27 17:00:36.000'
           ,0)
GO

select * from Pronto..PARSIS where parcod = 'TELA_GESTAO_COMPRAS'
--UPDATE PARSIS SET PARCON = 'S' WHERE PARCOD = 'TELA_GESTAO_COMPRAS' -- QA