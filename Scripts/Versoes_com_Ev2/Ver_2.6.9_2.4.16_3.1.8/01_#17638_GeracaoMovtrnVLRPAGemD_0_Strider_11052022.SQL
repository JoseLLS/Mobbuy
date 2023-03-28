USE [Pronto]
GO

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES 
						   ('PARCELAS_MENOR_QUE_HOJE', 'Não geração das parcelas no mesmo dia', 'CA', '3','N' ,'SIM', '2022-05-12', '0')
GO

USE [Banese]
GO

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES 
						   ('PARCELAS_MENOR_QUE_HOJE', 'Não geração das parcelas no mesmo dia', 'CA', '3','N' ,'SIM', '2022-05-12', '0')
GO

USE [BemFacil]
GO

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES 
						   ('PARCELAS_MENOR_QUE_HOJE', 'Não geração das parcelas no mesmo dia', 'CA', '3','N' ,'SIM', '2022-05-12', '0')
GO

USE [Credinov]
GO

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES 
						   ('PARCELAS_MENOR_QUE_HOJE', 'Não geração das parcelas no mesmo dia', 'CA', '3','N' ,'SIM', '2022-05-12', '0')
GO

USE [CredPag]
GO

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES 
						   ('PARCELAS_MENOR_QUE_HOJE', 'Não geração das parcelas no mesmo dia', 'CA', '3','N' ,'SIM', '2022-05-12', '0')
GO

USE [SmartPagamentos]
GO

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES 
						   ('PARCELAS_MENOR_QUE_HOJE', 'Não geração das parcelas no mesmo dia', 'CA', '3','N' ,'SIM', '2022-05-12', '0')
GO


/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [ParCod]
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
      ,[ParFlgInt]
  FROM [Pronto].[dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'
  
  /****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [ParCod]
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
      ,[ParFlgInt]
  FROM [Banese].[dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'
  
  /****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [ParCod]
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
      ,[ParFlgInt]
  FROM [BemFacil].[dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'
  
  /****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [ParCod]
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
      ,[ParFlgInt]
  FROM [Credinov].[dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'
  
  /****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [ParCod]
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
      ,[ParFlgInt]
  FROM [CredPag].[dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'
  
  /****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [ParCod]
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
      ,[ParFlgInt]
  FROM [SmartPagamentos].[dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'
  
  
  