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