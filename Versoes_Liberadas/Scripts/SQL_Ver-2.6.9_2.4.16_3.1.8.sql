/* TAREFA #17638 - JOÃO */

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
  
----------------------------------------------------------------------------------------

USE [Pronto]
GO

delete from [dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES ('IMPORTAREDECAPTURADO', 'Transação do Dia', 'CA', '3','N' ,'S', '2022-05-12', '0')
GO

USE [Banese]
GO

delete from [dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES ('IMPORTAREDECAPTURADO', 'Transação do Dia', 'CA', '3','N' ,'S', '2022-05-12', '0')
GO

USE [BemFacil]
GO

delete from [dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES ('IMPORTAREDECAPTURADO', 'Transação do Dia', 'CA', '3','N' ,'S', '2022-05-12', '0')
GO

USE [Credinov]
GO

delete from [dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES ('IMPORTAREDECAPTURADO', 'Transação do Dia', 'CA', '3','N' ,'S', '2022-05-12', '0')
GO

USE [CredPag]
GO

delete from [dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES ('IMPORTAREDECAPTURADO', 'Transação do Dia', 'CA', '3','N' ,'S', '2022-05-12', '0')
GO

USE [SmartPagamentos]
GO

delete from [dbo].[PARSIS] where [ParCod] = 'PARCELAS_MENOR_QUE_HOJE'

INSERT INTO [dbo].[PARSIS] ([ParCod], [ParDsc], [ParTipPar], [ParTamPar], [ParIndSin], [ParCon], [ParDtiInc], [ParFlgInt])
					VALUES ('IMPORTAREDECAPTURADO', 'Transação do Dia', 'CA', '3','N' ,'S', '2022-05-12', '0')
GO

/* TAREFA #17995 - JOSÉ */

--Clientes que irão usar o script
USE Banese
USE BemFacil
USE Credinov
USE Pronto
USE SmartPagamentos

INSERT INTO PARSIS
VALUES ('POS_OTP_OBRIGATORIO', 'Informa se o OTP é obrigatório na tela de POS.', 'VA', 1, NULL, 'N', 'S', NULL, NULL, 'ADMIN', 
'2022-06-02 12:18:00.000', 0)

--Usar 'N' somente para a Credpag
USE Credpag

INSERT INTO PARSIS
VALUES ('POS_OTP_OBRIGATORIO', 'Informa se o OTP é obrigatório na tela de POS.', 'VA', 1, NULL, 'N', 'N', NULL, NULL, 'ADMIN', 
'2022-06-02 12:18:00.000', 0)