/* TAREFA #24046 - JOSÉ */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpTranBloq', 'wpTranBloq', 'Transações bloqueadas compliance', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpTranBloq', '', 60, 'AUDITORIA', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpTranBloq');

INSERT INTO sse2_grp_mod (UNG2Cod, USR2GrpId, MOD2Id)
VALUES (25, 'ADM', 'wpTranBloq');