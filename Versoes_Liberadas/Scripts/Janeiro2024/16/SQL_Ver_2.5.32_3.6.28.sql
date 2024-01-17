/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.28','2.5.32',GETDATE());

/* TAREFA #23647 - CARLOS */

USE BANESE

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', 125, 'CRED_ESTAB', '', '/banese/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (12, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE SMARTPAGAMENTOS

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', 125, 'CRED_ESTAB', '', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (18, 'ADM', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE CREDPAG

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', 125, 'CRED_ESTAB', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (24, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE PRONTO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', 125, 'CRED_ESTAB', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE CREDINOV

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', 125, 'CRED_ESTAB', '', '/credinov/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (26, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE ESTBANK

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimenta��o', 125, 'CRED_ESTAB', '', '/estbank/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (28, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (28, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/

CREATE TABLE [tmpEstabSemMov] (
  [tmpEstabSemMovEstab]  CHAR(50)    NOT NULL,
  [tmpEstabSemMovDta]    DATETIME    NOT NULL,
  [tmpEstabSemMovEstCod] INT		     NULL,
  [tmpEstabSemMovParCom] CHAR(40)    NULL,
  [tmpEstabSemMovPacCod] INT 	       NULL,
  [tmpEstabSemMovQtdPos] SMALLINT    NULL,
     PRIMARY KEY ( [tmpEstabSemMovEstab],[tmpEstabSemMovDta] ))