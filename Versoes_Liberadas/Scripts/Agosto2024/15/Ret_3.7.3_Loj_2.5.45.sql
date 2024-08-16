/* TAREFA #24166 - JOSÉ */

CREATE TABLE [NOTIFICACAO] ( 
  [NotificacaoId]        INT    NOT NULL    IDENTITY ( 1 , 1 ), 
  [NotificacaoMsg]       VARCHAR(200)    NULL, 
  [NotificacaoEc]        SMALLINT    NULL, 
  [NotificacaoVista]     BIT    NULL, 
  [NotificacaoData]      DATETIME    NULL, 
  [NotificacaoDataVista] DATETIME    NULL, 
  [NotificacaoUsuInc]    VARCHAR(40)    NULL, 
     PRIMARY KEY ( [NotificacaoId] ))

/* TAREFA #24238 - CARLOS */

/************ IMPORTANTE: RODAR UMA INSTRUÇÃO DE CADA VEZ ************/

ALTER TABLE [SOLICITACAOCANCELAMENTO] 
ADD [SolCan_motivo_solicitacao] VARCHAR(MAX)    NULL

update SOLICITACAOCANCELAMENTO set SolCan_motivo_solicitacao = 'Não informado' 

ALTER TABLE [SOLICITACAOCANCELAMENTO] 
ADD [SolCan_motivo_recusa] VARCHAR(MAX)    NULL

update [SOLICITACAOCANCELAMENTO] set SolCan_motivo_recusa = SolCan_motivo

ALTER TABLE [SOLICITACAOCANCELAMENTO] 
DROP COLUMN [SolCan_motivo]

------------------------------------------------------------------------------

CREATE TABLE [SolCancelMot] (
  [SolCancelMotId]     SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [SolCancelMotDsc]    VARCHAR(100)    NULL,
  [SolCancelMotSts]    BIT    NULL,
  [SolCancelMotUsuInc] VARCHAR(40)    NULL,
  [SolCancelMotUsuAlt] VARCHAR(40)    NULL,
  [SolCancelMotDtaInc] DATETIME    NULL,
  [SolCancelMotDtaAlt] DATETIME    NULL,
     PRIMARY KEY ( [SolCancelMotId] ))

---------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('SelecTipoSolicCancel','SelecTipoSolicCancel', 'Tipos Sol.Cancelamento', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'SelecTipoSolicCancel', 'Tipos Sol.Cancelamento', 230, 'TAB_GER', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'SelecTipoSolicCancel')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'SelecTipoSolicCancel')

CREATE NONCLUSTERED INDEX [UTRNPAGSEG5] ON [TrnPagSeg] ([TrnPagSegCVCodigo], [TrnPagSegValorTotal])

--------------------------------------------------------------------------------

CREATE TABLE [RecusaSolicitacaoMot] (
  [RecSolMotId]     SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [RecSolMotDsc]    VARCHAR(100)    NULL,
  [RecSolMotSts]    BIT    NULL,
  [RecSolMotUsuInc] VARCHAR(40)    NULL,
  [RecSolMotUsuAlt] VARCHAR(40)    NULL,
  [RecSolMotDtaInc] DATETIME    NULL,
  [RecSolMotDtaAlt] DATETIME    NULL,
     PRIMARY KEY ( [RecSolMotId] ))