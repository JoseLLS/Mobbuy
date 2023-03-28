/*TAREFA #14703 - CARLOS*/ 

/*CRIA A TABELA HierarquiaComercial*/

CREATE TABLE [HierarquiaComercial] (
  [HierarquiaComercialId]     DECIMAL(10)    NOT NULL,
  [PacCod]                    DECIMAL(6)     NOT NULL,
  [HierarquiaTipoId]          DECIMAL(10)    NOT NULL,
  [HierarquiaPai]             DECIMAL(10)    NOT NULL,
  [HierarquiaComercialStatus] BIT    NOT NULL,
     PRIMARY KEY ( [HierarquiaComercialId] ))
CREATE NONCLUSTERED INDEX [IHIERARQUIACOMERCIAL1] ON [HierarquiaComercial] (
      [HierarquiaTipoId])

/*CRIA A TABELA HierarquiaTipo*/

CREATE TABLE [HierarquiaTipo] (
  [HierarquiaTipoId]   DECIMAL(10)    NOT NULL,
  [HierarquiaTipoDesc] VARCHAR(255)    NOT NULL,
     PRIMARY KEY ( [HierarquiaTipoId] ))

INSERT INTO hierarquiatipo VALUES
	(1, 'PARCEIRO'),
	(2, 'REPRESENTANTE 1'),
	(3, 'REPRESENTANTE 2'),
	(4, 'REPRESENTANTE 3'),
	(5, 'REPRESENTANTE 4')

/*
USE BEMFACIL
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPHIERARQUIA_GRID', 'WPHIERARQUIA_GRID', 'Hierarquia Representantes', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPHIERARQUIA_GRID', '', 110, 'CRED_ESTAB', 'Hierarquia Representantes', '/bemfacil/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (6, 'WPHIERARQUIA_GRID')

INSERT INTO sse2_grp_mod
VALUES (6, 'ADM', 'WPHIERARQUIA_GRID')
*/

/*
USE BANESE
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPHIERARQUIA_GRID', 'WPHIERARQUIA_GRID', 'Hierarquia Representantes', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPHIERARQUIA_GRID', '', 110, 'CRED_ESTAB', 'Hierarquia Representantes', '/banese/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'WPHIERARQUIA_GRID')

INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'WPHIERARQUIA_GRID')
*/

/*
USE CREDINOV
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPHIERARQUIA_GRID', 'WPHIERARQUIA_GRID', 'Hierarquia Representantes', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPHIERARQUIA_GRID', '', 110, 'CRED_ESTAB', 'Hierarquia Representantes', '/credinov/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'WPHIERARQUIA_GRID')

INSERT INTO sse2_grp_mod
VALUES (26, 'ADM', 'WPHIERARQUIA_GRID')
*/

/*
USE CREDPAG
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPHIERARQUIA_GRID', 'WPHIERARQUIA_GRID', 'Hierarquia Representantes', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPHIERARQUIA_GRID', '', 110, 'CRED_ESTAB', 'Hierarquia Representantes', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'WPHIERARQUIA_GRID')

INSERT INTO sse2_grp_mod
VALUES (24, 'ADM', 'WPHIERARQUIA_GRID')
*/

/*
USE SMARTPAGAMENTOS
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPHIERARQUIA_GRID', 'WPHIERARQUIA_GRID', 'Hierarquia Representantes', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPHIERARQUIA_GRID', '', 110, 'CRED_ESTAB', 'Hierarquia Representantes', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'WPHIERARQUIA_GRID')

INSERT INTO sse2_grp_mod
VALUES (218, 'ADM', 'WPHIERARQUIA_GRID')
*/

/*
USE PRONTO
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPHIERARQUIA_GRID', 'WPHIERARQUIA_GRID', 'Hierarquia Representantes', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPHIERARQUIA_GRID', '', 110, 'CRED_ESTAB', 'Hierarquia Representantes', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'WPHIERARQUIA_GRID')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'WPHIERARQUIA_GRID')
*/

/*
USE THEPAY
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPHIERARQUIA_GRID', 'WPHIERARQUIA_GRID', 'Hierarquia Representantes', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPHIERARQUIA_GRID', '', 110, 'CRED_ESTAB', 'Hierarquia Representantes', '/thepay/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (27, 'WPHIERARQUIA_GRID')

INSERT INTO sse2_grp_mod
VALUES (27, 'ADM', 'WPHIERARQUIA_GRID')
*/

/*TAREFA #14785 - LÉIA*/

ALTER TABLE [LogUpdArq]
ADD [GX_AUX] VARCHAR(250)    NOT NULL CONSTRAINT GX_AUXLogUpdArq_DEFAULT DEFAULT ''

ALTER TABLE [LogUpdArq]
DROP CONSTRAINT GX_AUXLogUpdArq_DEFAULT

UPDATE [LogUpdArq]
SET    [GX_AUX] = Rtrim([LogUpdArqNomArq])

ALTER TABLE [LogUpdArq]
DROP COLUMN [LogUpdArqNomArq]

EXEC sp_rename '[LogUpdArq].GX_AUX', 'LogUpdArqNomArq'

/*TAREFA #18057 - LÉIA*/

CREATE NONCLUSTERED INDEX [UTPG0001] ON [TPG0001] (
      [TpgDat],
      [UNG2Cod],
      [BnfTip],
      [BnfCod])

/* TAREFA #18061 - JOSÉ */

--CLientes que irão usar o script
USE Banese
USE BemFacil
USE Credinov
USE CredPag
USE Pronto
USE SmartPagamentos

ALTER TABLE [EST]
ALTER COLUMN [EstIE] DECIMAL(15) NULL

/*TAREFA #18216 - CARLOS*/

USE [Banese]
--USE [BemFacil]
--USE [CredInov]
--USE [CredPag]
--USE [Pronto]
--USE [SmartPagamentos]
--USE [ThePay]
GO

/***** Object:  View [dbo].[VwMovTrn]    Script Date: 22/06/2022 10:27:24 *****/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[VwMovTrn] AS
SELECT
A.MovTrnId        AS 'VwMovTrnId',
A.MovTrnDta       AS 'VwMovTrnDta',
A.MovTrnNsu       AS 'VwMovTrnNsu',
A.MovTrnAutCod    AS 'VwMovTrnAutCod',
A.MovTrnVlr       AS 'VwMovTrnVlr',
A.MovTrnNsuMovOri AS 'VwMovTrnNsuMovOri',
A.MovTrnBan       AS 'VwMovTrnBan',
D.TblBanBandeira  AS 'VwMovTrnBanDsc',
A.MovTrnTipPrd    AS 'VwMovTrnTipPrd',
CASE
	WHEN A.MovTrnCod = 'AJ' THEN 'Ajuste'
	WHEN A.MovTrnCod = 'CC' THEN 'Cancelamento'
	WHEN A.MovTrnCod = 'PS' THEN 'Prestação de serviço'
	WHEN A.MovTrnTipPrd = 'D'  THEN 'Débito'
	WHEN A.MovTrnTipPrd = 'V'  THEN 'Voucher'
	WHEN A.MovTrnTipPrd = 'C' AND A.MovTrnParQtd <= 1 THEN 'Crédito a vista'
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
A.MovTrnIdeTer       AS 'VwMovTrnIdeTer'			--NOVO 22/06/2022

FROM MovTrn01 A
INNER JOIN EST B
	ON A.EstCod = B.EstCod
INNER JOIN PARCOM C
	ON A.MovTrnPacCod = C.PacCod
LEFT JOIN TblBan D
    ON A.MovTrnBan = D.TblBanSigla AND D.TblBanAtivo = 'S'
LEFT JOIN ADQ0001 E
    ON A.AdqCod = E.AdqCod

GROUP BY A.MovTrnId, A.MovTrnDta, A.MovTrnNsu, A.MovTrnAutCod, A.MovTrnVlr, A.MovTrnNsuMovOri, A.MovTrnBan, D.TblBanBandeira,
         A.MovTrnTipPrd, A.MovTrnCod, A.MovTrnTipPrd, A.MovTrnParQtd, A.MovTrnParVlr, A.MovTrnParIndBemFac, A.MovTrnCod, A.MovTrnParQtd ,
		 A.MovTrnVlrLiqBemFac, A.MovTrnVlrLiqEst, A.MovTrnBfaVlrTxaAnt, A.EstCod, B.EstNomFan, B.EstPacCod, B.EstCodMcc,
		 B.EstUF, B.EstMun, A.AdqCod, A.MovTrnPacCod, C.PacNom, A.MovTrnGbpVlrTxaAdm, A.MovTrnGbpVlrTxaInt, A.MovTrnGbpVlrTxaAnt,
		 A.MovTrnBfaVlrTarCre, A.MovTrnBfaVlrTxaFin, A.MovTrnBfaVlrTxaAdm, A.MovTrnBfaVlrCusTrn, A.MovTrnBfaVlrCusCap,
		 E.AdqNom, B.EstBai, B.EstSegmento, A.MovTrnIdeTer

GO