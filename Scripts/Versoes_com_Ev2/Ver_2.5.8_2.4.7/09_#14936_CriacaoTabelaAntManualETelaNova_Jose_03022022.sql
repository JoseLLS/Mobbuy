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