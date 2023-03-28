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
           ('ControleVendas_CSV' 
           ,'Pasta aonde vai ficar os CSV de controle de vendas.'
           ,'CA'
           ,200
           ,NULL
		   ,'N'
           ,'/mnt/home1/SubAdquirencia/025/BI'
           ,NULL
           ,NULL
           ,'025ADM                           '
           ,'2022-01-12 17:00:36.000'
           ,0)
GO

select * from Pronto..PARSIS where parcod = 'ControleVendas_CSV'
--UPDATE PARSIS SET PARCON = '/mnt/home1/SubAdquirencia/025/BI' WHERE PARCOD = 'ControleVendas_CSV' -- QA
--UPDATE PARSIS SET PARCON = 'C:\Temp'                          WHERE PARCOD = 'ControleVendas_CSV' -- LOCAL