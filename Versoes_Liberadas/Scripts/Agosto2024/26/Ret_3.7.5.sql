/* TAREFA #24711 - CARLOS */

CREATE TABLE [LogCadastroCompliance] (
  [LogCadCompID]        DECIMAL(10)    NOT NULL    IDENTITY ( 1 , 1 ),
  [LogCadCompTabela]    VARCHAR(40)    NULL,
  [LogCadCompCampo]     VARCHAR(40)    NULL,
  [LogCadCompInfoAnt]   VARCHAR(MAX)    NULL,
  [LogCadCompInfoAtual] VARCHAR(MAX)    NULL,
  [LogCadCompOrigem]    VARCHAR(40)    NULL,
  [LogCadCompEstCod]    INT    NULL,
  [LogCadCompUsuReq]    CHAR(20)    NULL,
  [LogCadCompDtaReq]    DATETIME    NULL,
  [LogCadCompUsuObs]    VARCHAR(350)    NULL,
  [LogCadCompStatus]    SMALLINT    NOT NULL,
  [LogCadCompUsuAprov]  CHAR(20)    NULL,
  [LogCadCompDtaAprov]  DATETIME    NULL,
  [LogCadCompMotivo]    VARCHAR(350)    NULL,
  [LogCadCompAtributo]  VARCHAR(40)    NULL,
     PRIMARY KEY ( [LogCadCompID] ));

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogCadComp_Grid','HLogCadComp_Grid', 'Compliance - Manut. Cadastro', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogCadComp_Grid', 'Compliance - Manut. Cadastro', 80, 'AUDITORIA', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'HLogCadComp_Grid');

INSERT INTO sse2_grp_mod
VALUES (25, 'COMPLIANCE', 'HLogCadComp_Grid');

INSERT INTO sse2_grp_mod
VALUES (25, 'COMPLIANCE NOVO', 'HLogCadComp_Grid');

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'HLogCadComp_Grid');