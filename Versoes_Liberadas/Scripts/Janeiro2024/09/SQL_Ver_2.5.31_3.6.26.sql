/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.26','2.5.31',GETDATE());

/* TAREFA #20376 - JOSÉ */

--Rodar script em todos os clientes que irá ser atualizada a versão
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('CadastroWhitelabel', 'CadastroWhitelabel', 'Cadastro de whitelabel', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'CadastroWhitelabel', '', 161, 'TAB_GER', '', '/pronto/servlet/') --Mudar onde está 'pronto' conforme cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'CadastroWhitelabel') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'CadastroWhitelabel') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

/* TAREFA #20987 - CARLOS */

GO

/****** Object:  View [dbo].[RelatorioBaseTributacao]    Script Date: 23/11/2023 12:09:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 ALTER VIEW [dbo].[RelatorioBaseTributacao]

AS
SELECT 	
	M.EstCod                  AS 'RelBaseTribCodigo',
	E.EstAplPsq               AS 'RelBaseTribEstabelecimento',
	E.EstSegmento             AS 'RelBaseTribSegmentos',
	E.EstNomFan               AS 'RelBaseTribNomeFantasia',
	E.EstCpfCnpj              AS 'RelBaseTribCNPJ',
	E.EstTip                  AS 'RelBaseTribEstTipo',
	M.MovTrnDta               AS 'RelBaseTribData',
	SUM(M.MovTrnVlr)          AS 'RelBaseTribValorVenda', 	  
	SUM(M.MovTrnVlrLiqEst)    AS 'RelBaseTribValorEstabelecimento',		
	SUM(M.MovTrnBfaVlrTxaAdm) AS 'RelBaseTribTaxaAdministracao',	
	SUM(M.MovTrnBfaVlrTxaFin) AS 'RelBaseTribReceitaAntecipacao',
	SUM(M.MovTrnGbpVlrTxaInt) AS 'RelBaseTribTaxaAdquirente',
	SUM(M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnGbpVlrTxaAnt) AS 'RelBaseTribReceitaLiquida',  --ALTERADO EM 23/11/2023 CONF. TAREFA #20987
	SUM(M.MovTrnGbpVlrTxaAnt)  AS 'RelBaseTribTaxaAntAdq',          						    --ALTERADO EM 23/11/2023 CONF. TAREFA #20987
    	SUM(CASE WHEN M.MovTrnTipPrd = 'P' THEN M.MovTrnVlr ELSE 0 END) AS 'RelBaseTribValorPix'--NOVO  06/03/2023

FROM MovTrn01 M
	LEFT JOIN EST E 
	ON E.EstCod = M.EstCod
	
	WHERE MovTrnCod IN ('CV', 'CC')
	
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta, M.MovtrnAnt,
	         M.MovTrnVlr, M.MovTrnVlrLiqEst, M.MovTrnGbpVlrTxaInt, M.MovTrnGbpVlrTxaAnt
GO

/* TAREFA #23567 - CARLOS */

USE BANESE

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/banese/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (12, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/

USE SMARTPAGAMENTOS

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (18, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/
USE CREDINOV

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/credinov/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (26, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/
USE CREDPAG

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (24, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/

/****** Object:  View [dbo].[vwPartidasAberto]    Script Date: 11/12/2023 00:00:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwPartidasAberto]
AS
SELECT
	NEWID() AS  'vwPartidasAbertoID',
	M.MovTrnNsu AS 'vwPartidasAbertoNSU',
    V.ESTCOD AS 'vwPartidasAbertoEstCod',
	E.EstAplPsq AS 'vwPartidasAbertoEstApl',
	V.VlpBan AS 'vwPartidasAbertoBanCod',
	CASE
		WHEN V.VlpBan = 1	THEN 'MasterCard'
		WHEN V.VlpBan = 2	THEN 'Visa'
		WHEN V.VlpBan = 22	THEN 'Elo'
		WHEN V.VlpBan = 24	THEN 'Amex'
		WHEN V.VlpBan = 33	THEN 'Hipercard'
		WHEN V.VlpBan = 36	THEN 'Cabal'
		WHEN V.VlpBan = 6	THEN 'VardeCard'
		WHEN V.VlpBan = 0	THEN 'MarketPay'
		WHEN V.VlpBan = 99	THEN 'Todas'
		WHEN V.VlpBan = 55	THEN 'Pix'
	END AS 'vwPartidasAbertoBandeira',
	V.VlpDtaVct AS 'vwPartidasAbertoDtaVenc',
	V.VlpNumPar AS 'vwPartidasAbertoParc',
	V.VlpNumTotPar AS 'vwPartidasAbertoTotPar',
	V.VlpVlrPag AS 'vwPartidasAbertoVlrVenda',
	A.AdqNom AS 'vwPartidasAbertoAdqNom',
	M.MovTrnAutCod AS 'vwPartidasAbertoAutorizacao',
	M.MovTrnCod AS 'vwPartidasAbertoMovTrnCod',
	CASE
		WHEN M.MovTrnCod = 'AJ' THEN 'Ajuste (AJ)'
		WHEN M.MovTrnCod = 'CC'	THEN 'Cancelamento (CC)'
		WHEN M.MovTrnCod = 'CV'	THEN 'Crédito a vista (CV)'
		WHEN M.MovTrnCod = 'PS' THEN 'Prestação de serviço (PS)'
	END AS 'vwPartidasAbertoTransacao',
	M.MovTrnTipPrd AS 'vwPartidasAbertoMovTrnTipPrd',
	CASE 
		WHEN M.MovTrnTipPrd = 'C' THEN 'Crédito'
		WHEN M.MovTrnTipPrd = 'D' THEN 'Débito'
		WHEN M.MovTrnTipPrd = 'V' THEN 'Voucher'
		WHEN M.MovTrnTipPrd = 'O' THEN 'Outros'
		WHEN M.MovTrnTipPrd = 'S' THEN 'Prestação de Serviço'
		WHEN M.MovTrnTipPrd = 'P' THEN 'Pix'
	END  AS 'vwPartidasAbertoProduto',
	M.MovTrnDta AS 'vwPartidasAbertoDtaVenda'

FROM VLRPAG V LEFT JOIN MOVTRN01 M
ON V.VlpMovTrnId = M.MovTrnId
INNER JOIN EST E
ON V.ESTCOD = E.ESTCOD
INNER JOIN ADQ0001 A
ON M.ADQCOD = A.ADQCOD
WHERE V.VlpStsPag  = 1

GO

/* TAREFA #23647 - CARLOS */


/****** Object:  View [dbo].[vwEstabSemMov]    Script Date: 05/01/2024  ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW vwEstabSemMov AS 
	SELECT NEWID() AS  'vwEstabSemMovID',
	B.EstCod AS 'vwEstabSemMovEstCod',
	A.MovTrnDta AS 'vwEstabSemMovDta'
	FROM movtrn01 A LEFT JOIN EST B
	ON A.EstCod = B.EstCod
	WHERE B.EstSit = 'A'
	GROUP BY B.EstCod, A.MovTrnDta

Go

USE BANESE

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', 125, 'CRED_ESTAB', '', '/banese/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (12, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE SMARTPAGAMENTOS

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', 125, 'CRED_ESTAB', '', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (18, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE CREDPAG

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', 125, 'CRED_ESTAB', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (24, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE PRONTO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', 125, 'CRED_ESTAB', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/
USE CREDINOV

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpEstabSemMov_Grid','wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpEstabSemMov_Grid', 'Estabelecimentos sem Movimentação', 125, 'CRED_ESTAB', '', '/credinov/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'wpEstabSemMov_Grid')

INSERT INTO sse2_grp_mod
VALUES (26, 'CADASTROS', 'wpEstabSemMov_Grid')
/*********************************************************************************************************************/

/* TAREFA #23687 - JOSÉ */

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
END                  AS 'VwMovTrnTxaAntCons' --NOVO 31/01/2023

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

GROUP BY A.MovTrnId, A.MovTrnDta, A.MovTrnNsu, A.MovTrnAutCod, A.MovTrnVlr, A.MovTrnNsuMovOri, D.TblBanSigla, D.TblBanBandeira,
         A.MovTrnTipPrd, A.MovTrnCod, A.MovTrnTipPrd, A.MovTrnParQtd, A.MovTrnParVlr, A.MovTrnParIndBemFac, A.MovTrnCod, A.MovTrnParQtd ,
		 A.MovTrnVlrLiqBemFac, A.MovTrnVlrLiqEst, A.MovTrnBfaVlrTxaAnt, A.EstCod, B.EstNomFan, B.EstPacCod, B.EstCodMcc,
		 B.EstUF, B.EstMun, A.AdqCod, A.MovTrnPacCod, C.PacNom, A.MovTrnGbpVlrTxaAdm, A.MovTrnGbpVlrTxaInt, A.MovTrnGbpVlrTxaAnt,
		 A.MovTrnBfaVlrTarCre, A.MovTrnBfaVlrTxaFin, A.MovTrnBfaVlrTxaAdm, A.MovTrnBfaVlrCusTrn, A.MovTrnBfaVlrCusCap,
		 E.AdqNom, B.EstBai, B.EstSegmento, A.MovTrnIdeTer, F.posCodTmrSfe, A.MovtrnAnt, A.MovTrnTavNum, A.MovTrnInsTimStp,
		 A.MovTrnTxaAntPrv, A.MovtrnAnt