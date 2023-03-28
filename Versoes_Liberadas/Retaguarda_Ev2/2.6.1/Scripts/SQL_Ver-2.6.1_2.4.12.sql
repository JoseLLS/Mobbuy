/* ALTERAÇÃO DA VERSÃO DO BANCO */

UPDATE PARSIS
SET ParCon = '2.6.1_2.4.12'
WHERE ParCod = 'VERSAO_BANCO'

UPDATE PARSIS
SET ParCon = '25/03/2022'
WHERE ParCod = 'VERSAO_BANCO_DATA'

/* TAREFA #14976 - WESLEY */

CREATE TABLE [Trn05_SitProc] (
  [Trn05_SitProcId]   CHAR(20)     NOT NULL,
  [Trn05_SitProcDesc] VARCHAR(200)     NOT NULL,
      PRIMARY KEY ( [Trn05_SitProcId] ))

Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (0,  'Pendente')
Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (10, 'Erro na validação (Movimento não encontrado)')
Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (20, 'Processado')
Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (30, 'Desprezado')

CREATE TABLE [Trn05_SitProcErro] (
  [Trn05_SitProcErroId]   CHAR(20)     NOT NULL,
  [Trn05_SitProcErroDesc] VARCHAR(200)     NOT NULL,
      PRIMARY KEY ( [Trn05_SitProcErroId] ))

Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (0,  'Processamento ok')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (1,  'Operação não encontrada (TrnBrsOprCodPrc diferente de 002000, 003000, 003100, 003800, 962000)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (2,  'Bandeira não encontrada (TrnBrsOprBan diferente de 002, 003, 004, 006, 010)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (3,  'Situação marcada como Pendente ou Pré Autorização (TrnBrsRdeSit marcada como 10 ou 13)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (4,  'Situação marcada cancelamento (TrnBrsRdeSit marcada como 20, 21, 40, 41, 43, ou 44)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (5,  'Situação não encontrada (TrnBrsOprCodPrc diferente de 00, 01, 03, 04, 10, 13, 20, 21, 40, 41, 43, 44, 50, 54)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (6,  'Movimento não cancelado (MovTrnIdCan marcada como null, '' pu 0')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (7,  'Movimento não encontrado na MovTrn01')

/* TAREFA #16776 - WESLEY */

USE [Pronto]
GO

/****** Object:  View [dbo].[tabven06_Aux01]    Script Date: 21/03/2022 16:34:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[Est08_Aux01] as 

Select 
      Estcod,
      VlpDtaVct                         as 'VENCIMENTO', 
	  GETDATE()                         as 'HOJE', 
	  DATEDIFF(day,GETDATE(),VlpDtaVct) as 'DIFERENCA' 
from vlrpag where vlpStspag = 1

GO

/***************************************************************************/

USE [Pronto]
GO

/****** Object:  View [dbo].[Est08]    Script Date: 21/03/2022 16:52:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[Est08] as 

SELECT 
	  E.EstCod as 'VwSdEstcod',

      E.EstNomFan AS 'VwSdEstNom',

      ISNULL(Convert(Numeric(15),EC.EfeitoContratoTitular),E.EstCpfCnpj) AS 'VwSdEstcpfCnpj',

	  E.EstTip as 'VwSdEstTipo',
	  
	  CASE 
	      WHEN NOT EC.EfeitoContratoTitular IS NULL AND EC.Data_Vencimento >= GETDATE() AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'S' 
		  WHEN E.EstPermiteCessao = 0 THEN 'S' 
		  ELSE 'N' 
	  END AS 'VwSdBloqueio',

	  CASE 
	      WHEN NOT EC.EfeitoContratoTitular IS NULL AND EC.Data_Vencimento >= GETDATE() AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'Bloqueio efeito de contrato.' 
		  WHEN E.EstPermiteCessao = 0 THEN 'Estabelecimento não tem permissão para gerar cessão.' 
		  ELSE '' 
	  END AS 'VwSdMotivoBloqueio', 
	  
	  CONVERT(DECIMAL(18,2), SUM(
	                             CASE 
								     WHEN V.VlpStsPag = 1 THEN V.VLPVLRPAG 
									 ELSE 0 
								 END)) 
	  AS 'VwSdSaldoTotal',
	  
	  CONVERT(DECIMAL(18,2), SUM(
	                             CASE 
								     WHEN EC.Data_Vencimento < GETDATE() OR EC.EfeitoContratoTitular IS NULL OR EC2.EfeitoContratoSituacao in ('B','R') THEN 
									      CASE 
										      WHEN V.VlpStsPag = 1 AND V.VlpTipPrd = 'C' THEN V.VLPVLRPAG 
											  ELSE 0 
										  END 
								     ELSE 0 
								 END)) 
	  AS 'VwSdSaldoAberto',
	  
	  CONVERT(DECIMAL(18,2), CASE 
	                             WHEN EC.Data_Vencimento < GETDATE() OR EC.EfeitoContratoTitular IS NULL  OR EC2.EfeitoContratoSituacao in ('B','R') THEN ISNULL(C.EstVlrCessao, 0) 
								 ELSE 0 
							 END) 
	  AS 'VwSdSaldoReservado',
	  
	  
	  CONVERT(DECIMAL(18,2), CASE
	                             WHEN EC.Data_Vencimento < GETDATE() OR EC.EfeitoContratoTitular IS NULL 
								 OR EC2.EfeitoContratoSituacao in ('B','R') THEN SUM(
								                                                     CASE 
																						 WHEN V.VlpStsPag = 1 AND V.VlpTipPrd = 'C' THEN V.VLPVLRPAG 
																						 ELSE 0 
																					 END) - ISNULL(C.EstVlrCessao, 0) 
							     ELSE 0  
							 END) 
	  AS 'VwSdSaldoDisponivelCessao',
	  
	  EC.Data_Vencimento AS 'VwSdDtaVenc',

	  EC2.EfeitoContratoSituacao AS 'VwEfeitoContratoSituacao',

	  ROUND(M.Media,2) AS 'VwSdPrazoMedio'

	 FROM EST E with(nolock)
LEFT JOIN VLRPAG V with(nolock)
     ON E.ESTCOD = V.EstCod

LEFT JOIN Est07 C with(nolock)
      ON V.EstCod = C.EstCodCessao

LEFT JOIN (select EfeitoContratoEstCod,
                  EfeitoContratoTitular,
                  max(EfeitoContratoDtaVenc) as 'Data_Vencimento'
		   from EfeitoContrato with(nolock) where EfeitoContratoAprovado = 1 group by EfeitoContratoEstCod,EfeitoContratoTitular) EC
     ON  E.EstCod = EC.EfeitoContratoEstCod 


LEFT JOIN (SELECT EfeitoContratoEstCod,
                  EfeitoContratoTitular,
				  EfeitoContratoDtaVenc,
				  EfeitoContratoSituacao
				  FROM EfeitoContrato
				  GROUP BY EfeitoContratoEstCod, EfeitoContratoTitular, EfeitoContratoDtaVenc, EfeitoContratoSituacao) EC2
ON EC2.EfeitoContratoEstCod  = EC.EfeitoContratoEstCod   AND 
   EC2.EfeitoContratoTitular = EC.EfeitoContratoTitular AND 
   EC2.EfeitoContratoDtaVenc = EC.Data_Vencimento

INNER JOIN Est08_Aux02 M
ON M.EstCod = E.EstCod

GROUP BY E.EstCod,
         E.EstNomFan, 
		 C.EstVlrCessao, 
		 EC.EfeitoContratoTitular, 
		 EC.Data_Vencimento, 
		 E.EstCpfCnpj,
		 E.EstPermiteCessao,
		 E.EstTip,
		 EC2.EfeitoContratoSituacao,
		 M.Media

GO

/***************************************************************************/

USE [Pronto]
GO

/****** Object:  View [dbo].[tabven06_Aux01]    Script Date: 21/03/2022 16:34:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[Est08_Aux02] as 

SELECT 
      Estcod,
	  SUM(DIFERENCA)   AS 'SOMA',
	  COUNT(DIFERENCA) AS 'QUANTIDADE', 
	  SUM(DIFERENCA) / CAST(COUNT(DIFERENCA) AS numeric(18,2)) AS 'MEDIA'
	  FROM Est08_Aux01
	  GROUP BY EstCod
GO