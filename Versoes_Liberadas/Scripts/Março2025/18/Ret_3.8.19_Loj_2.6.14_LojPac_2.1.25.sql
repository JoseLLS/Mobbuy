/* Versionamento de scripts */

INSERT INTO SQLHistorico
VALUES ('3.8.19','2.6.14',GETDATE());

/* TAREFA #26109 - CARLOS */

CREATE TABLE [TblFilial] (
  [TblFilialID]     INT    NOT NULL IDENTITY ( 1 , 1 ),
  [TblFilialDsc]    CHAR(50)    NOT NULL,
  [TblFilialSts]    BIT    NOT NULL,
  [TblFilialDtaInc] DATETIME    NULL,
  [TblFilialUsuInc] CHAR(20)    NULL,
  [TblFilialDtaAlt] DATETIME    NULL,
  [TblFilialUsuAlt] CHAR(20)    NULL,
     PRIMARY KEY ( [TblFilialID] ));

CREATE TABLE [TblMarca] (
  [TblMarcaID]     INT    NOT NULL IDENTITY ( 1 , 1 ),
  [TblMarcaDsc]    CHAR(50)    NOT NULL,
  [TblMarcaSts]    BIT    NOT NULL,
  [TblMarcaDtaInc] DATETIME    NULL,
  [TblMarcaUsuInc] CHAR(20)    NULL,
  [TblMarcaDtaAlt] DATETIME    NULL,
  [TblMarcaUsuAlt] CHAR(20)    NULL,
     PRIMARY KEY ( [TblMarcaID] ));

ALTER TABLE [EST]
ADD [EstFilial] INT    NULL,
    [EstMarca] INT    NULL;

/* SOMENTE PERMITE */
USE permite;

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpTblFilial','wpTblFilial', 'Tabela de Filiais', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpTblFilial', 'Tabela de Filiais', 241, 'TAB_GER', '', '/permite/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (30, 'wpTblFilial');

INSERT INTO sse2_grp_mod
VALUES (30, 'ADM', 'wpTblFilial');

/* SOMENTE PERMITE */
USE permite;

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpTblMarca','wpTblMarca', 'Tabela de Marcas', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpTblMarca', 'Tabela de Marcas', 240, 'TAB_GER', '', '/permite/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (30, 'wpTblMarca');

INSERT INTO sse2_grp_mod
VALUES (30, 'ADM', 'wpTblMarca');

/* VIEW - RODAR SEPARADAMENTE DESSE SCRIPT */

ALTER VIEW [dbo].[VwMovTrn] AS

SELECT
A.MovTrnId                             AS 'VwMovTrnId',
A.MovTrnDta                            AS 'VwMovTrnDta',
A.MovTrnNsu                            AS 'VwMovTrnNsu',
A.MovTrnAutCod                         AS 'VwMovTrnAutCod',
A.MovTrnVlr                            AS 'VwMovTrnVlr',
A.MovTrnNsuMovOri                      AS 'VwMovTrnNsuMovOri',
ISNULL(D.TblBanSigla, '0')             AS 'VwMovTrnBan',
ISNULL(D.TblBanBandeira, 'MarketPay')  AS 'VwMovTrnBanDsc',
A.MovTrnTipPrd                         AS 'VwMovTrnTipPrd',
CASE
	WHEN A.MovTrnCod = 'AJ' THEN 'Ajuste'
	WHEN A.MovTrnCod = 'CC' THEN 'Cancelamento'
	WHEN A.MovTrnCod = 'PS' THEN 'Prestação de serviço'
	WHEN A.MovTrnTipPrd = 'P'  THEN 'Pix'
	WHEN A.MovTrnTipPrd = 'D'  THEN 'Débito'
	WHEN A.MovTrnTipPrd = 'V'  THEN 'Voucher'
	WHEN A.MovTrnTipPrd = 'C' AND A.MovTrnParQtd = 1 THEN 'Crédito a vista'
	WHEN A.MovTrnTipPrd = 'C' AND A.MovTrnParQtd > 1 AND A.MovTrnParIndBemFac = 'N' THEN 'Crédito parcelado'
	WHEN A.MovTrnTipPrd = 'C' AND A.MovTrnParQtd > 1 AND A.MovTrnParIndBemFac = 'S' THEN 'Crédito parcelado BF'
END                  AS 'VwMovTrnTipo',
A.MovTrnCod          AS 'VwMovTrnCod',
A.MovTrnParQtd       AS 'VwMovTrnParQtd',
A.MovTrnParVlr		 AS 'VwMovTrnParVlr',		--NOVO  14/03/2022
A.MovTrnParIndBemFac AS 'VwMovTrnParIndBemFac',
A.MovTrnVlrLiqBemFac AS 'VwMovTrnVlrLiqBemFac',
A.MovTrnVlrLiqEst    AS 'VwMovTrnVlrLiqEst',
A.MovTrnBfaVlrTxaAnt AS 'VwMovTrnBfaVlrTxaAnt',
A.EstCod             AS 'VwMovTrnEstCod',
B.EstNomFan          AS 'VwMovTrnEstNomFan',
B.EstPacCod          AS 'VwMovTrnEstPacCod',
B.EstCodMcc          AS 'VwMovTrnEstCodMcc',
B.EstUF              AS 'VwMovTrnEstUF',
B.EstMun             AS 'VwMovTrnEstMun',
B.EstSegmento		 AS 'VwMovTrnEstSegmento',
A.AdqCod             AS 'VwMovTrnAdqCod',
A.MovTrnPacCod       AS 'VwMovTrnPacCod',
C.PacNom             AS 'VwMovTrnPacNom',
A.MovTrnGbpVlrTxaAdm AS 'VwGbpVlrTxaAdm',
A.MovTrnGbpVlrTxaInt AS 'vWGbpVlrTxaInt',
A.MovTrnGbpVlrTxaAnt AS 'VwGbpVlrTxaAnt',
A.MovTrnBfaVlrTarCre AS 'vwMovBfaVlrTarCre',
A.MovTrnBfaVlrTxaFin AS 'VwMovTrnBfaVlrTxaFin',
A.MovTrnBfaVlrTxaAdm AS 'VwMovTrnBfaVlrTxaAdm', --NOVO  14/03/2022
A.MovTrnBfaVlrCusTrn AS 'VwMovTrnBfaVlrCusTrn',
A.MovTrnBfaVlrCusCap AS 'VwMovTrnBfaVlrCusCap',	--NOVO  14/03/2022
E.AdqNom             AS 'VwMovTrnAdqNom',
B.EstBai             AS 'VwMovTrnBaiNom',
A.MovTrnIdeTer       AS 'VwMovTrnIdeTer',	    --NOVO 22/06/2022
F.PosCodTmrSfe		 AS 'VwMovTrnPos',
A.MovtrnAnt			 AS 'VwMovTrnAnt',
A.MovTrnTavNum		 AS 'VwMovTrnTavNum',
A.MovTrnInsTimStp	 AS 'VwMovTrnInsTimStp',

A.MovTrnTxaAntPrv    AS 'VwMovTrnTxaAntPrv', --NOVO 31/01/2023
CASE
    WHEN A.MovtrnAnt = 'T' THEN A.MovTrnGbpVlrTxaAnt
    ELSE A.MovTrnTxaAntPrv
END                  AS 'VwMovTrnTxaAntCons', --NOVO 31/01/2023

CASE
    WHEN A.MovTrnVanSeq > 0 THEN 'Rede de captura'
    ELSE 'Adquirente'
END                  AS 'VwMovTrnOrigem', --NOVO 23/02/2024

A.MovTrnTxCobrancaId AS 'VwMovTrnTxCobrancaId',
A.MovTrnNumCar AS 'vwMovTrnNumCar', --TAREFA #26091 [CARLOS]
G.VanTrnCupFis AS 'vwVanTrnCupFis', --TAREFA #26091 [CARLOS]
(A.MovTrnBfaVlrTxaFin + A.MovTrnBfaVlrTxaAdm) - (A.MovTrnGbpVlrTxaInt - A.MovTrnGbpVlrTxaAnt) AS 'vwMovTrnResLiq', --TAREFA #26091 [CARLOS]
H.TblMarcaDsc  AS 'vwMarcaDsc', --TAREFA #26109 [CARLOS]
I.TblFilialDsc AS 'vwFilialDsc' --TAREFA #26109 [CARLOS]

FROM MovTrn01 A
INNER JOIN EST B
	ON A.EstCod = B.EstCod
INNER JOIN PARCOM C
	ON A.MovTrnPacCod = C.PacCod
LEFT JOIN TblBan D
    ON A.MovTrnBan = D.TblBanSigla AND D.TblBanAtivo = 'S'
LEFT JOIN ADQ0001 E
    ON A.AdqCod = E.AdqCod
LEFT JOIN POS F
	ON A.MovTrnPosNum = F.PosNum
LEFT JOIN VAN04 G
	ON A.MovTrnVanSeq = G.VanTrnSeq
LEFT JOIN TblMarca H
	ON B.EstMarca = H.TblMarcaID
LEFT JOIN TblFilial I
	ON B.EstFilial = I.TblFilialID


GROUP BY A.MovTrnId, A.MovTrnDta, A.MovTrnNsu, A.MovTrnAutCod, A.MovTrnVlr, A.MovTrnNsuMovOri, D.TblBanSigla, D.TblBanBandeira,
         A.MovTrnTipPrd, A.MovTrnCod, A.MovTrnTipPrd, A.MovTrnParQtd, A.MovTrnParVlr, A.MovTrnParIndBemFac, A.MovTrnCod,
		 A.MovTrnParQtd , A.MovTrnVlrLiqBemFac, A.MovTrnVlrLiqEst, A.MovTrnBfaVlrTxaAnt, A.EstCod, B.EstNomFan, B.EstPacCod, 
		 B.EstCodMcc,B.EstUF, B.EstMun, A.AdqCod, A.MovTrnPacCod, C.PacNom, A.MovTrnGbpVlrTxaAdm, A.MovTrnGbpVlrTxaInt, 
		 A.MovTrnGbpVlrTxaAnt, A.MovTrnBfaVlrTarCre, A.MovTrnBfaVlrTxaFin, A.MovTrnBfaVlrTxaAdm, A.MovTrnBfaVlrCusTrn, 
		 A.MovTrnBfaVlrCusCap, E.AdqNom, B.EstBai, B.EstSegmento, A.MovTrnIdeTer, F.posCodTmrSfe, A.MovtrnAnt, A.MovTrnTavNum, 
		 A.MovTrnInsTimStp, A.MovTrnTxaAntPrv, A.MovtrnAnt, A.MovTrnVanSeq, A.MovTrnTxCobrancaId, A.MovTrnNumCar, G.VanTrnCupFis, 
		 H.TblMarcaDsc, I.TblFilialDsc
GO