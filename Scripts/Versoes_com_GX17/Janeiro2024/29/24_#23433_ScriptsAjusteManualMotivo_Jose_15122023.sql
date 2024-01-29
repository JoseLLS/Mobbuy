/* TAREFA #23433 - JOSÉ */

USE Pronto;

CREATE TABLE [AjusteManualMot] (
  [AjusteManualMotId]  SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AjusteManualMotDsc] VARCHAR(100)    NULL,
  [AjusteManualMotSts] BIT    NULL,
  [AjusteManualMotDtaAlt] DATETIME    NULL,
  [AjusteManualMotDtaInc] DATETIME    NULL,
  [AjusteManualMotUsuAlt] VARCHAR(40)    NULL,
  [AjusteManualMotUsuInc] VARCHAR(40)    NULL,
     PRIMARY KEY ( [AjusteManualMotId] ));
	 
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('MotAjusteManual', 'MotAjusteManual', 'Ajuste Manual - Motivo', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'MotAjusteManual', '', 220, 'TAB_GER', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'MotAjusteManual');

INSERT INTO sse2_grp_mod (UNG2Cod, USR2GrpId, MOD2Id)
VALUES (25, 'ADM', 'MotAjusteManual');

ALTER TABLE [AJM0001]
ADD [AjmMotObs] VARCHAR(1024)    NULL,
    [AjusteManualMotId] SMALLINT    NULL;
CREATE NONCLUSTERED INDEX [IAJM2] ON [AJM0001] (
      [AjusteManualMotId]);
ALTER TABLE [AJM0001]
 ADD CONSTRAINT [IAJM2] FOREIGN KEY ( [AjusteManualMotId] ) REFERENCES [AjusteManualMot]([AjusteManualMotId]);