/* TAREFA #22350 - JOSÉ */

CREATE TABLE [AlugPOS] (
  [AlugPOSId]     SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AlugPOSModelo] VARCHAR(40)    NULL,
  [AlugPOSValor]  DECIMAL(17,2)    NULL,
     PRIMARY KEY ( [AlugPOSId] ))
	 

CREATE TABLE [AlugMeta] (
  [AlugMetaId]         SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AlugMetaSegmento]   VARCHAR(40)    NOT NULL,
  [AlugMetaModalidade] VARCHAR(40)    NULL,
  [AlugMetaValor]      DECIMAL(17,2)    NULL,
     PRIMARY KEY ( [AlugMetaId] ))
	 

CREATE TABLE [AlugMotivo] (
  [AlugMotivoId]   SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AlugMotivoDsc]  VARCHAR(40)    NULL,
  [AlugMotivoDias] SMALLINT    NULL,
     PRIMARY KEY ( [AlugMotivoId] ))
	 

CREATE TABLE [AlugParm] (
  [AlugParmId]      SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AlugParmDtaVct]  SMALLINT    NULL,
  [AlugParmDiasCar] SMALLINT    NULL,
  [AlugParmDiasInat] SMALLINT    NULL,
  [AlugParmDiasIsePOS] SMALLINT    NULL,
     PRIMARY KEY ( [AlugParmId] ))


ALTER TABLE [POS]
ADD [AlugMotivoId] SMALLINT    NULL
CREATE NONCLUSTERED INDEX [IPOS5] ON [POS] (
      [AlugMotivoId])
ALTER TABLE [POS]
 ADD CONSTRAINT [IPOS5] FOREIGN KEY ( [AlugMotivoId] ) REFERENCES [AlugMotivo]([AlugMotivoId])


 ALTER TABLE [EST]
ADD [EstIseAlug] BIT    NULL

ALTER TABLE [EST]
ADD [EstDtaAltStatus] DATETIME    NULL

ALTER TABLE [GrupoComercial]
ADD [GrupoComercialIseAlug] BIT    NULL

ALTER TABLE [GrupoComercialEst]
ADD [GrupoComercialEstCobCen] BIT    NULL
	 
------------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('AlugParametros', 'AlugParametros', 'Parâmetros de aluguel', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'AlugParametros', '', 163, 'TAB_GER', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'AlugParametros')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'AlugParametros')