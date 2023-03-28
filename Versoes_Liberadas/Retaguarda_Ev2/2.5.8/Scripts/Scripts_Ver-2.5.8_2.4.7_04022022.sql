/* TAREFA #14814 - JOSÉ */

--Quais clientes precisam do script
USE Banese
USE Bemfacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

--Parâmetro para alterar o de/para do segmento com a tabela de vendas
INSERT INTO PARSIS
VALUES ('SEGMENTO_TABVEN', 'Parâmetro que associa tabela de vendas com segmento (Segmento;TavNum)', 'VA', 500, NULL, 'N', 
'Grupo Comolatti;2;Oficina;6;PitStop;7;Varejo;12', 'ADMIN', '2022-01-31 00:00:00:000', NULL, NULL, 0)

/* TAREFA #14936 - JOSÉ */

--Clientes que precisam do script dessa tarefa ---------------------------------------------------
USE Pronto

--Criação de tabela AntManual --------------------------------------------------------------------
CREATE TABLE [AntManual] (
  [AntManualId]       DECIMAL(10)     NOT NULL     IDENTITY ( 1 , 1 ),
  [AntManualSegmento] VARCHAR(40)     NOT NULL,
  [AntManualTaxa]     SMALLMONEY     NOT NULL,
  [AntManualUsuInc]   VARCHAR(40)     NOT NULL,
  [AntManualUsuAlt]   VARCHAR(40)     NOT NULL,
  [AntManualDtaInc]   DATETIME     NOT NULL,
  [AntManualDtaAlt]   DATETIME     NOT NULL,
  [TavNum]            SMALLINT     NULL,
      PRIMARY KEY ( [AntManualId] ))

CREATE NONCLUSTERED INDEX [UANTMANUAL] ON [AntManual] (
      [TavNum],
      [AntManualSegmento])
 
CREATE NONCLUSTERED INDEX [UANTMANUAL1] ON [AntManual] (
      [AntManualSegmento])

ALTER TABLE [AntManual]
 ADD CONSTRAINT [IANTMANUAL1] FOREIGN KEY ( [TavNum] ) REFERENCES [TABVEN]([TavNum])

 --Criação de índice na tabela EST ---------------------------------------------------------------
 CREATE NONCLUSTERED INDEX [UEST4] ON [EST] (
      [EstSegmento])

--Adição de tela nova no menu do Retaguarda ------------------------------------------------------
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('MANUTANTMANUAL_GRID', 'MANUTANTMANUAL_GRID', 'Manutenção Taxas Antecipação', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'MANUTANTMANUAL_GRID', '', 104, 'CRED_ESTAB', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'MANUTANTMANUAL_GRID')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'MANUTANTMANUAL_GRID')

/* TAREFA #14934 - WESLEY */

ALTER TABLE GrupoComercial ALTER COLUMN GrupoComercialNome VARCHAR(50) NOT NULL

/* TAREFA #14924 - WESLEY */

CREATE NONCLUSTERED INDEX [UMOVTRN015] ON [MOVTRN01] ( 
      [MovTrnNsu], 
      [MovTrnAutCodStr])

/* TAREFA #14397 - WESLEY */

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

ALTER TABLE [MovTrn01]
ADD [MovTrnDtaHraCan] DATETIME     NULL,
    [MovTrnUsuCan] VARCHAR(128)     NULL

/* TAREFA #14867 - WESLEY */

CREATE TABLE [VlpStatusPag] (
  [VlpStatusPagId]   CHAR(20)     NOT NULL,
  [VlpStatusPagDesc] VARCHAR(30)     NOT NULL,
      PRIMARY KEY ( [VlpStatusPagId] ))

/*
EXECUTAR CASO ALGUNS DOS REGISTROS ESTIVEREM FALTANDO

INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (1 , 'Aberto')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (2 , 'Liquidado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (3 , 'Cancelado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (4 , 'Cancelado após liquidado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (5 , 'Em antecipação')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (6 , 'Conciliado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (7 , 'Em aberto para cessão')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (8 , 'Cessão cancelada')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (9 , 'Cancelamento manual')
*/

select * from VlpStatusPag

/* TAREFA #14908 - CARLOS */

Use BancoOrigem
Use Banese
Use BemFacil
Use CredInov
Use CredPag
Use Pronto
Use Smartpagamentos
INSERT INTO TLog0002 VALUES ('TabVen02', 'TabVen02',0)
select top 1 * from TLog0002 ORDER BY TLOGID DESC /*VERIFICAR QUAL TLogID*/
INSERT INTO TLog0003 VALUES (/*Inserir TLogID*/,1,'TavVigDtaIni', 'Nova Vigência')

INSERT INTO TLog0002 VALUES ('TabVen05', 'TabVen05',0)
select top 1 * from TLog0002 ORDER BY TLOGID DESC /*VERIFICAR QUAL TLogID*/
INSERT INTO TLog0003 VALUES (/*Inserir TLogID*/,1,'TavNum', 'Taxas')

INSERT INTO TLog0002 VALUES ('TabVen07', 'TabVen07',0)
select top 1 * from TLog0002 ORDER BY TLOGID DESC /*VERIFICAR QUAL TLogID*/
INSERT INTO TLog0003 VALUES (28,1,'TavComNum', 'Comissões')


/*VERIFICAR SE GRAVOU*/
select top 3 * from TLog0002 ORDER BY TLOGID DESC 
select top 3 * from TLog0003 ORDER BY TLOGID DESC

/* ALTERAÇÃO DA VERSÃO DO BANCO */
USE Banese
USE Bemfacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

UPDATE PARSIS
SET ParCon = '2.5.8_2.4.7'
WHERE ParCod = 'VERSAO_BANCO'

UPDATE PARSIS
SET ParCon = '28/01/2022'
WHERE ParCod = 'VERSAO_BANCO_DATA'