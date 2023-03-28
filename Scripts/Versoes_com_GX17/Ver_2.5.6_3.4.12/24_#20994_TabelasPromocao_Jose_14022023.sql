/* TAREFA #20994 - JOSÉ */

--Rodar script em todos os clientes que serão atualizados
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('PromocaoTaxa_imp', 'PromocaoTaxa_imp', 'Promoção de Taxas', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'PromocaoTaxa_imp', '', 115, 'CRED_ESTAB', '', '/pronto/servlet/');--Alterar o '/pronto/servlet/' conforme o cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'PromocaoTaxa_imp');--Alterar o '25' conforme a unidade de negócio do cliente

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'PromocaoTaxa_imp');--Alterar o '25' conforme a unidade de negócio do cliente

---------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE [TABVEN]
ADD [TavTipTab] CHAR(1)    NULL;

ALTER TABLE [TABVEN02]
ADD [TavVigDtaFim] DATETIME    NULL

----------------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UTABVEN1] ON [TABVEN] (
      [TavDsc]);
	  
CREATE NONCLUSTERED INDEX [UTABVEN053] ON [TABVEN05] (
      [TavNum],
      [TavVigDtaIni],
      [TavAdqCod],
      [TavBanCod],
      [TavDetTipPln],
      [TavDetQtdPar]);
	  
CREATE NONCLUSTERED INDEX [UTABVEN054] ON [TABVEN05] (
      [TavNum],
      [TavVigDtaIni],
      [TavAdqCod],
      [TavBanCod],
      [TavDetSeq] DESC);
	  
-----------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('TabVenEst_imp', 'TabVenEst_imp', 'Vinculo Tabela Promoções', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'TabVenEst_imp', '', 120, 'CRED_ESTAB', '', '/pronto/servlet/');--Alterar o '/pronto/servlet/' conforme o cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'TabVenEst_imp');--Alterar o '25' conforme a unidade de negócio do cliente

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'TabVenEst_imp');--Alterar o '25' conforme a unidade de negócio do cliente

------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE [EstPromocao] (
  [EstPromId]          INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [EstCod]             INT    NULL,
  [EstPromDtaInc]      DATETIME    NULL,
  [EstPromDtaAlt]      DATETIME    NULL,
  [EstPromTavAnterior] SMALLINT    NULL,
  [EstPromTavNum]      SMALLINT    NULL,
  [EstPromStatus]      CHAR(20)    NULL,
  [EstPromUsuInc]      VARCHAR(40)    NULL,
  [EstPromUsuAlt]      VARCHAR(40)    NULL,
     PRIMARY KEY ( [EstPromId] ));

CREATE NONCLUSTERED INDEX [IESTPROMOCAO1] ON [EstPromocao] (
      [EstCod]);

ALTER TABLE [EstPromocao]
 ADD CONSTRAINT [IESTPROMOCAO1] FOREIGN KEY ( [EstCod] ) REFERENCES [EST]([EstCod]);

 CREATE NONCLUSTERED INDEX [UESTPROMOCAO] ON [EstPromocao] (
      [EstPromTavNum],
      [EstCod]);