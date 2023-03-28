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
           ('PER_USU_CAN_MANUAL' 
           ,'Usuário(s) com permissão para fazer cancelamento manual.Separa cada usuário por |'
           ,'CA'
           ,200
           ,NULL
		   ,'N'
           ,''
           ,NULL
           ,NULL
           ,'025ADM                           '
           ,'2022-01-27 17:00:36.000'
           ,0)
GO

select * from Pronto..PARSIS where parcod = 'PER_USU_CAN_MANUAL'
--UPDATE PARSIS SET PARCON = '025ADM|025FERNAND|' WHERE PARCOD = 'PER_USU_CAN_MANUAL' -- QA