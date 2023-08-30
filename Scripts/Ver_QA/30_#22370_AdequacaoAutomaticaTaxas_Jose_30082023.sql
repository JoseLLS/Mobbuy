CREATE TABLE [TaxaParm] (
  [TaxaParmId]   SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [TaxaParmDe]   DECIMAL(17,2)    NULL,
  [TaxaParmAte]  DECIMAL(17,2)    NULL,
  [TaxaParmNome] VARCHAR(40)    NULL,
     PRIMARY KEY ( [TaxaParmId] ));
	 
ALTER TABLE [EST]
ADD [EstDtaAltTab] DATETIME    NULL
	 
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('TaxaParametros', 'TaxaParametros', 'Parametros de taxas', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'TaxaParametros', '', 163, 'TAB_GER', '', '/pronto/servlet/'); --Mudar onde está 'pronto' conforme cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'TaxaParametros'); --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'TaxaParametros'); --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto