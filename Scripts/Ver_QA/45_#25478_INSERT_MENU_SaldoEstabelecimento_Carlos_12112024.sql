use Credinov
/*OBSERVAÇÃO: APENAS PARA CREDINOV*/

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HEST0153_GRID','HEST0153_GRID', 'Saldo do Estabelecimento', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HEST0153_GRID', 'Saldo do Estabelecimento', 125, 'CTR_FIN', '', '/credinov/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'HEST0153_GRID')

INSERT INTO sse2_grp_mod
VALUES (26, 'ADM', 'HEST0153_GRID')

delete sse2_grp_mod where  mod2id = 'HEST0150_GRID'
delete sse2_ung_mod where  mod2id = 'HEST0150_GRID'
delete sse2_mnu02 where MnuIteIde = 'HEST0150_GRID'
delete sse2_mod WHERE MOD2Id = 'HEST0150_GRID'
