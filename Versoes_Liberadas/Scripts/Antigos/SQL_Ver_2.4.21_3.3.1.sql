/* TAREFA #18446 - WESLEY */

ALTER TABLE [MovTrn01] ADD [MovTrnExpCom] BIT    NOT NULL CONSTRAINT MovTrnExpComMovTrn01_DEFAULT DEFAULT Convert(BIT,0)

CREATE NONCLUSTERED INDEX [UMOVTRN021] ON [MovTrn01] (
      [EstCod],
      [MovTrnDta],
      [MovTrnCod],
      [MovTrnExpCom])

CREATE NONCLUSTERED INDEX [UTABVEN07] ON [TABVEN07] (
      [TavComNum],
      [TavComVigDtaIni],
      [TavComAdqCod],
      [TavComBanCod],
      [TavComDetTipPln],
      [TavComDetQtdPar])

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

CREATE TABLE [VlpCom] (
  [VlpComId]       DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [VlpComPacCod]   INT    NULL,
  [VlpComEstCod]   SMALLINT    NULL,
  [VlpComSts]      SMALLINT    NULL,
  [VlpComMovTrnId] DECIMAL(18)    NULL,
  [VlpComVlr]      DECIMAL(17,2)    NULL,
  [VlpComPerc]     SMALLMONEY    NULL,
  [VlpComVlrFixo]  DECIMAL(17,2)    NULL,
  [VlpComDtainc]   DATETIME    NULL,
     PRIMARY KEY ( [VlpComId] ))

CREATE NONCLUSTERED INDEX [IVLPCOM1] ON [VlpCom] (
      [VlpComMovTrnId])

ALTER TABLE [VlpCom]
 ADD CONSTRAINT [IVLPCOM1] FOREIGN KEY ( [VlpComMovTrnId] ) REFERENCES [MovTrn01]([MovTrnId])

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('ApuracaoCom_Grid', 'ApuracaoCom_Grid', 'Apuração Comissão', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'ApuracaoCom_Grid', '', 103, 'CRED_ESTAB', '', '/pronto/servlet/')

-- 26 é CREDIPAG, VERIFICAR O UNG2COD DE CADA CLIENTE ANTES DE RODAR
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'ApuracaoCom_Grid')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (26, 'ADM', 'ApuracaoCom_Grid')