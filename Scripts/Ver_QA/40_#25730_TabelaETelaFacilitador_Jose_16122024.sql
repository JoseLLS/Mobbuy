/* TAREFA #25730 - JOSÉ */

CREATE TABLE [Facilitador] (
  [FacilitadorId]  SMALLINT    NOT NULL,
  [FacilitadorDsc] VARCHAR(40)    NULL,
     PRIMARY KEY ( [FacilitadorId] ));
	 
ALTER TABLE [EST]
ADD [FacilitadorId] SMALLINT    NULL;
CREATE NONCLUSTERED INDEX [IEST9] ON [EST] (
      [FacilitadorId]);
ALTER TABLE [EST]
 ADD CONSTRAINT [IEST9] FOREIGN KEY ( [FacilitadorId] ) REFERENCES [Facilitador]([FacilitadorId]);
 
ALTER TABLE [CNTBAN]
ADD [FacilitadorId] SMALLINT    NULL;
CREATE NONCLUSTERED INDEX [ICNTBAN2] ON [CNTBAN] (
      [FacilitadorId]);
ALTER TABLE [CNTBAN]
 ADD CONSTRAINT [ICNTBAN2] FOREIGN KEY ( [FacilitadorId] ) REFERENCES [Facilitador]([FacilitadorId]);
 
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('FacilitadorGrid', 'FacilitadorGrid', 'Facilitador', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'FacilitadorGrid', 'Facilitador', 231, 'TAB_GER', '', '/credpag/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'FacilitadorGrid');

INSERT INTO sse2_grp_mod
VALUES (24, 'ADM', 'FacilitadorGrid');