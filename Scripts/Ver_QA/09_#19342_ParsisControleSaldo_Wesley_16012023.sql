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
           ('EC_CONTROLEEVENTO' 
           ,'EC para executar o controle de eventos.'
           ,'CA'
           ,10
           ,NULL
		   ,'N'
           ,'1'
           ,NULL
           ,NULL
           ,NULL
           ,'2022-11-14 10:00:36.000'
           ,0)
GO

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
           ('DATA_CONTROLEEVENTO' 
           ,'DATA para executar o controle de eventos.'
           ,'CA'
           ,10
           ,NULL
		   ,'N'
           ,'20221107'
           ,NULL
           ,NULL
           ,NULL
           ,'2022-11-14 10:00:36.000'
           ,0)
GO

--update parsis set parcon = '361' where parcod = 'EC_CONTROLEEVENTO'
--update parsis set parcon = '20190101' where parcod = 'DATA_CONTROLEEVENTO'

select * from parsis where parcod = 'EC_CONTROLEEVENTO'
select * from parsis where parcod = 'DATA_CONTROLEEVENTO'