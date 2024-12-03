/* TAREFA #25383 - JOSÉ */

INSERT INTO PARSIS
VALUES ('UPL_ARQ_RTM','Caminho de upload de arquivos RTM','VA',300,NULL,'N','/mnt/home1/SubAdquirencia/025/RTM/env/','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('UplArqRTM', 'UplArqRTM', 'Upload Arquivo RTM', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'UplArqRTM', 'Upload Arquivo RTM', 231, 'TAB_GER', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2Cod, mod2Id)
VALUES (25, 'UplArqRTM');

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'UplArqRTM');

/* TAREFA #25286 - JOSÉ */

INSERT INTO PARSIS
VALUES ('ARQ_SLC_RTM','Caminho de arquivos de retorno RTM','VA',300,NULL,'N','/mnt/home1/SubAdquirencia/025/reembolso/SLC/retorno/','ADMIN',GETDATE(),NULL,NULL,0);

CREATE TABLE [RTMArquivo] (
  [RTMArquivoId]   INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [RTMArquivoNome] VARCHAR(80)    NULL,
  [RTMArquivoData] DATETIME    NULL,
     PRIMARY KEY ( [RTMArquivoId] ));
	 
CREATE TABLE [RTMArqDet] (
  [RTMArquivoId]   INT    NOT NULL,
  [RTMArqDetId]    INT    NOT NULL,
  [RTMArqDetDados] VARCHAR(MAX)    NULL,
     PRIMARY KEY ( [RTMArquivoId],[RTMArqDetId] ))
ALTER TABLE [RTMArqDet]
 ADD CONSTRAINT [IRTMARQDET1] FOREIGN KEY ( [RTMArquivoId] ) REFERENCES [RTMArquivo]([RTMArquivoId]);

INSERT INTO PARSIS
VALUES ('ARQ_SLC_RET','Caminho de exportação do arquivo SLC','VA',300,NULL,'N','/mnt/home1/SubAdquirencia/025/reembolso/SLC/retornoprevia/','ADMIN',GETDATE(),NULL,NULL,0);
/* TAREFA #25228 - JOSÉ */

CREATE TABLE [ArranjoStatus] (
  [ArranjoStatusId]  SMALLINT    NOT NULL,
  [ArranjoStatusDsc] VARCHAR(40)    NULL,
     PRIMARY KEY ( [ArranjoStatusId] ));
	 
CREATE TABLE [ArqSlcArranjo] (
  [ArbNum]          INT    NOT NULL,
  [ArbLotNum]       SMALLINT    NOT NULL,
  [ArbDetSeq]       INT    NOT NULL,
  [ArqSlcId]        INT    NOT NULL,
  [ArqSlcEstCod]    INT    NULL,
  [ArqSlcBan]       CHAR(1)    NULL,
  [ArqSlcValor]     DECIMAL(17,2)    NULL,
  [ArqSlcDtaInc]    DATETIME    NULL,
  [ArranjoStatusId] SMALLINT    NULL,
     PRIMARY KEY ( [ArbNum],[ArbLotNum],[ArbDetSeq],[ArqSlcId] ));
CREATE NONCLUSTERED INDEX [IARQSLCARRANJO2] ON [ArqSlcArranjo] (
      [ArranjoStatusId]);
ALTER TABLE [ArqSlcArranjo]
 ADD CONSTRAINT [IARQSLCARRANJO1] FOREIGN KEY ( [ArbNum],[ArbLotNum],[ArbDetSeq] ) REFERENCES [ARQDET]([ArbNum],[ArbLotNum],[ArbDetSeq]);
ALTER TABLE [ArqSlcArranjo]
 ADD CONSTRAINT [IARQSLCARRANJO2] FOREIGN KEY ( [ArranjoStatusId] ) REFERENCES [ArranjoStatus]([ArranjoStatusId]);

 /* TAREFA #25249 - JOSÉ */

ALTER TABLE [TblBan]
ADD [TblBanSlcCodArranjo] SMALLINT    NULL,
    [TblBanTipo] CHAR(2)    NULL;

/* TAREFA #25203 - JOSÉ */

ALTER TABLE [EST]
ADD [EstSlcNuclea] BIT    NULL;

ALTER TABLE [ARQBAN]
ADD [ArbSlcTip] CHAR(2)    NULL,
	[ArbPgtoEfeito] CHAR(1)    NULL;

ALTER TABLE [TblBan]
ADD [TblBanSlcAtivo] CHAR(1)    NULL,
	[TblBanCodArranjo] CHAR(3)    NULL;

/* TAREFA #25148 - JOSÉ */

CREATE TABLE [SLCAPROVAPREVIA] ( 
  [SlcAprovaPreviaId]  INT    NOT NULL    IDENTITY ( 1 , 1 ), 
  [SlcNomeArquivo]     VARCHAR(50)    NULL, 
  [SlcDataPagamento]   DATETIME    NULL, 
  [SlcSequencial]      INT    NULL, 
  [SlcDocFavorecido]   VARCHAR(14)    NULL, 
  [SlcValor]           DECIMAL(17,2)    NULL, 
  [SlcStatusPrevia]    VARCHAR(40)    NULL, 
  [SlcStatusProc]      SMALLINT    NULL, 
  [SlcDataInclusao]    DATETIME    NULL, 
  [SlcUsuarioInclusao] VARCHAR(40)    NULL, 
  [SlcDataAlteracao]   DATETIME    NULL, 
     PRIMARY KEY ( [SlcAprovaPreviaId] ));

ALTER TABLE [ARQBAN]
ADD [ArbArqNom] VARCHAR(50)    NULL;

/* TAREFA #25472 - JOSÉ */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('TBLBAN_GRID', 'TBLBAN_GRID', 'Bandeiras', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'TBLBAN_GRID', 'Bandeiras', 232, 'TAB_GER', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2Cod, mod2Id)
VALUES (25, 'TBLBAN_GRID');

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'TBLBAN_GRID');