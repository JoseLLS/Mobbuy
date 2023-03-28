/* TAREFA #21252 - WESLEY */

USE [Pronto]
GO

/****** Object:  View [dbo].[VwMovTrn]    Script Date: 03/03/2023 12:23:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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
B.TavNum			 AS 'VwMovTrnTavNum',
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
		 E.AdqNom, B.EstBai, B.EstSegmento, A.MovTrnIdeTer, F.posCodTmrSfe, A.MovtrnAnt, B.TavNum, A.MovTrnInsTimStp,
		 A.MovTrnTxaAntPrv, A.MovtrnAnt
GO


-------------------------------------------------------------------------------------------------------------------------------------------------

USE [Pronto]
GO

/****** Object:  View [dbo].[AgdRec01]    Script Date: 06/03/2023 11:17:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[AgdRec01] as
select
AgdRc1Dta = v.VlrDtaPrvLiqAnt ,
AgdRc1VlrDeb = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ) ,
AgdRc1VlrCre = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
AgdRc1VlrPrc = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
AgdRc1VlrAju = sum( case when isnull(MovTrnCod,'') = 'AJ'then VlrVlrRec Else 0 end ),
AgdRc1VlrCan = sum( case when isnull(MovTrnCod,'') = 'CC'then VlrVlrRec Else 0 end ),
AgdRc1VlrOut = sum( case when isnull(MovTrnCod,'') = ''  then VlrVlrRec Else 0 end ),
AgdRc1VlrPix = sum( case when MovTrnTipPrd = 'P'  then VlrVlrRec Else 0 end )
from vlrrec v left join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) where v.VlrStsRec not in (4,5)
group by v.VlrDtaPrvLiqAnt
GO

-------------------------------------------------------------------------------------------------------------------------------------------------

USE [Pronto]
GO

/****** Object:  View [dbo].[AgdPag01]    Script Date: 06/03/2023 14:14:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER   view [dbo].[AgdPag01] as
select
AgdPg1Dta = v.VlpDtaVct ,
AgdPg1VlrDeb	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ) ,
AgdPg1VlrCre	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ),
AgdPg1VlrPrc	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 then VlpVlrPag Else 0 end ),
AgdPg1VlrAju	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='AJ' then VlpVlrPag Else 0 end ),
AgdPg1VlrCan	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='CC' then VlpVlrPag Else 0 end ),
AgdPg1VlrOut	= sum( case when v.TidCod>1 or  isnull(MovTrnCod,'')='AL'   then VlpVlrPag Else 0 end ),
AgdPg1VlrRee	= sum( case when v.VlpStspag=2                           then VlpVlrPag Else 0 end ),
AgdPg1VlrTotAbe = sum( case when v.VlpStspag=1                            then VlpVlrPag Else 0 end ),
AgdPg1VlrCom	= sum( case when v.TidCod=1 and isnull(MovTrnTipPrd,'')='S' then VlpVlrPag Else 0 end ),
AgdPg1VlrPix	= sum( case when m.MovTrnTipPrd ='P' then VlpVlrPag Else 0 end )
from VlrPag v left join movtrn01 m on (m.movtrnid =  v.VlpMovTrnId ) where v.VlpStspag not in (3,4)
group by v.VlpDtaVct
GO

-------------------------------------------------------------------------------------------------------------------------------------------------

USE [Pronto]
GO

/****** Object:  View [dbo].[RelatorioBaseTributacao]    Script Date: 06/03/2023 14:58:19 ******/
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
	SUM(CASE
	    WHEN M.MovtrnAnt = 'T' THEN (M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnGbpVlrTxaAnt)
		ELSE (M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnTxaAntPrv)
	END)                      AS 'RelBaseTribReceitaLiquida',  --NOVO 31/01/2023
	CASE
	    WHEN M.MovtrnAnt = 'T' THEN (M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnGbpVlrTxaAnt)
		ELSE SUM(M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnTxaAntPrv)
	END                       AS 'RelBaseTribTaxaAntAdq',           --NOVO 31/01/2023
    SUM(CASE WHEN M.MovTrnTipPrd = 'P' THEN M.MovTrnVlr ELSE 0 END) AS 'RelBaseTribValorPix'--NOVO  06/03/2023

FROM MovTrn01 M
	LEFT JOIN EST E 
	ON E.EstCod = M.EstCod
	
	WHERE MovTrnCod IN ('CV', 'CC')
	
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta, M.MovtrnAnt,
	         M.MovTrnVlr, M.MovTrnVlrLiqEst, M.MovTrnGbpVlrTxaInt, M.MovTrnGbpVlrTxaAnt

GO


select * from RelatorioBaseTributacao

/* SEM TAREFA - JOSÉ */

DROP INDEX [UMOVTRN0112] ON [MovTrn01]


/* SEM TAREFA - LEONARDO */

insert into parsis(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
values ('HORA_REDECAP', 'TRATAMENTO HORARIO JSON REDECAPTURA (SEGUNDOS)', 'CA', 80, 'N', 3600)