USE [Pronto]
GO

/****** Object:  View [dbo].[CON0001]    Script Date: 23/02/2024 16:06:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 ALTER   View [dbo].[CON0001]
As
Select * From (																								
select   NewID() ConTrnId, 
		'Van04' ConTrnOri, 
		a.MovTrnDta ConTrnDta, 
		a.EstCod  ConTrnEstCod, 
		a.MovTrnBan as ConTrnBan,  
		a.MovTrnTipPrd ConTrnTipPrd, 
		a.MovTrnNsu   ConTrnNsu, 
		a.MovTrnVlr ConTrnVlr , 
		a.MovTrnNumMov ConTrnAdqNumMov , 
		a.MovTrnNumReg ConTrnAdqNumReg , 
		''           as ConTrnPosNroSerInt , 
		''               as ConTrnPosNroSer , 
		a.MovTrnAutCodStr as ConTrnNumAtzStr , 
		a.MovTrnIdeTer as ConTrnAdqIdeTer , 
		a.MovTrnNumCar as ConTrnNumCar , 
		ConTrnAdqCod = a.AdqCod,
		'' 'ConTrnSta'
		FROM MOVTRN01 a
		left join trn05 b on a.movtrnid =  b.trnbrsoprmovtrnid 
		Where b.trnbrsoprmovtrnid is null
		and a.adqcod = 5
		and a.movtrncod in ( 'CV' , 'PS' )
		and MovTrnIdOri = 0 
		and MovTrnIdCan = 0 

		
UNION All


SELECT 
		NEWID() ConTrnId, 
	   'MOVTRN01'  ConTrnOri, 
	   trnbrsoproridat ConTrnDta, 
	   EstCod = 0,
	   CASE 
			WHEN TrnBrsOprBan = '002' THEN 'M'
			WHEN TrnBrsOprBan = '003' THEN 'V'
			WHEN TrnBrsOprBan = '004' THEN 'E'
			WHEN TrnBrsOprBan = '010' THEN 'C'
			WHEN TrnBrsOprBan = '006' THEN 'D'
			ELSE ''
	   END AS ConTrnBan,
	   SUBSTRING(Trnbrsoprideser, 4, 1) ConTrnTipPrd,
	   Trnbrsoprmovnsucrr ConTrnNsu,
	   Trnbrsoprvlr ConTrnVlr , 
	   ConTrnAdqNumMov = 0, 
	   ConTrnAdqNumReg = 0, 
	   trnbrsoprtrm as ConTrnPosNroSerInt , 
	   trnbrsoprtrm  as ConTrnPosNroSer , 
	   VanTrnNumAtzStr = '' , 
	   ''           as ConTrnAdqIdeTer , 
	   concat (trnbrsoprbin,trnbrsoprpan )  as ConTrnNumCar , 
	   adqcod as ConTrnAdqCod,
	   '' 'ConTrnSta'
FROM trn05    
Where trnbrsoprmovtrnid  = 0
and TrnBrsRdeSit in ('00','01','03','04')
group by trnbrsoproridat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, adqcod, TrnBrsOprBan, Trnbrsoprvlr



UNION All

select   NewID() ConTrnId, 
		'Van04' ConTrnOri, 
		a.MovTrnDta ConTrnDta, 
		a.EstCod  ConTrnEstCod, 
		a.MovTrnBan as ConTrnBan,  
		a.MovTrnTipPrd ConTrnTipPrd, 
		a.MovTrnNsu   ConTrnNsu, 
		a.MovTrnVlr ConTrnVlr , 
		a.MovTrnNumMov ConTrnAdqNumMov , 
		a.MovTrnNumReg ConTrnAdqNumReg , 
		''           as ConTrnPosNroSerInt , 
		''               as ConTrnPosNroSer , 
		a.MovTrnAutCodStr as ConTrnNumAtzStr , 
		a.MovTrnIdeTer as ConTrnAdqIdeTer , 
		a.MovTrnNumCar as ConTrnNumCar , 
		ConTrnAdqCod = a.AdqCod,
		'' 'ConTrnSta'
		FROM MOVTRN01 a
		left join TrnPagSeg b on a.movtrnid =  b.TrnPagSegMovTrnId 
		Where b.TrnPagSegMovTrnId is null
		and a.adqcod = 8
		and a.movtrncod in ( 'CV' , 'PS' )
		and MovTrnIdOri = 0 
		and MovTrnIdCan = 0 
		
UNION All

SELECT NEWID() ConTrnId, 
	   'MOVTRN01'    ConTrnOri, 
	   convert(datetime, trnpagsegdatainicial, 121) ConTrnDta, 
	   EstCod = trnpagsegestabelecimento ,
	   CASE
		WHEN TrnPagSegInstituicao = 'AMEX' THEN 'A'
		WHEN TrnPagSegInstituicao =	'CABAL' THEN 'C'
		WHEN TrnPagSegInstituicao =	'ELO' THEN 'E'
		WHEN TrnPagSegInstituicao =	'HIPERCARD' THEN 'H'
		WHEN TrnPagSegInstituicao =	'MAESTRO' THEN 'M'
		WHEN TrnPagSegInstituicao =	'MASTERCARD' THEN 'M'
		WHEN TrnPagSegInstituicao =	'VISA' THEN 'V'
		WHEN TrnPagSegInstituicao =	'VISA ELECTRON' THEN 'V'
		ELSE ''
		END AS ConTrnBan,
	   iif(TrnPagSegMeioPagamento = 3, 'C', 'D') ConTrnTipPrd,
	   trnpagsegcvcodigo ConTrnNsu,
	   trnpagsegvalororiginal ConTrnVlr , 
	   ''  as ConTrnAdqNumMov , 
	   ''  as ConTrnAdqNumReg , 
	   convert(varchar(40), trnpagsegestabelecimento) as ConTrnPosNroSerInt , 
	   convert(varchar(40), trnpagsegestabelecimento)  as ConTrnPosNroSer , 
	   convert(varchar(40), trnpagsegautorizacaocodigo) as VanTrnNumAtzStr, 
	   ''           as ConTrnAdqIdeTer , 
	   concat (trnpagsegcartaobin,trnpagsegcartaoholder )  as ConTrnNumCar , 
	   8 as ConTrnAdqCod,
	   '' 'ConTrnSta'
FROM TrnPagSeg    
Where (TrnPagSegMovTrnId  = 0
or TrnPagSegMovTrnId is null)
and TrnPagSegSituacaoProcesso <> 'Processado'
group by trnpagsegdatainicial, TrnPagSegInstituicao, TrnPagSegMeioPagamento, trnpagsegcvcodigo, trnpagsegvalororiginal,
trnpagsegestabelecimento, trnpagsegautorizacaocodigo, trnpagsegcartaobin, trnpagsegcartaoholder
) Resultado

UNION ALL
	SELECT 
	NewID() 'ConTrnId',
	'Van04' 'ConTrnOri',
	Canc.VanWbsDat 'ConTrnDta', 
	0 'ConTrnEstCod', 
	Canc.Bandeira 'ConTrnBan',
	Canc.Produto 'ConTrnTipPrd',
	canc.VanWbsNsu 'ConTrnNsu',--alterado de cancelamento para venda
	Canc.ValorSitef 'ConTrnVlr',
	0 'ConTrnAdqNumMov',
	0 'ConTrnAdqNumReg',
	Canc.VanWbsPosIde 'ConTrnPosNroSerInt', 
	'' 'ConTrnPosNroSer', 
	Canc.VanWbsAtz 'ConTrnNumAtzStr', 
	'' 'ConTrnAdqIdeTer',
	'' 'ConTrnNumCar',
	C.AdqCod 'ConTrnAdqCod',
	'' 'ConTrnSta'
	FROM 
	(
		SELECT 
		(CONVERT(numeric(17,2), VanWbsVlr)/-100) 'ValorSitef',
		VanWbsVlr,
		VanWbsAtz, 
		VanWbsDat, 
		VanWbsPosIde, 
		VanWbsDsc, 
		VanWbsSta,
		VanWbsTrnSeq,
		VanWbsNsu,
		SUBSTRING(VanWbsBdaNom, 1, 1) 'Bandeira',
		VanWbsAdqIde,
		IIF(VanWbsDsc LIKE '%CREDITO%', 'C', 'D') 'Produto'
		FROM VAN02
		WHERE VanWbsDsc LIKE '%CANCELAMENTO%'
		AND VanWbsTrnSeq = 0
	) Canc
	INNER JOIN
	(
		SELECT 
		(CONVERT(numeric(17,2), VanWbsVlr)/-100) 'ValorSitef',
		VanWbsVlr,
		VanWbsAtz, 
		VanWbsDat, 
		VanWbsPosIde, 
		VanWbsDsc, 
		VanWbsSta,
		VanWbsTrnSeq,
		VanWbsNsu,
		SUBSTRING(VanWbsBdaNom, 1, 1) 'Bandeira',
		VanWbsAdqIde,
		IIF(VanWbsDsc LIKE '%CREDITO%', 'C', 'D') 'Produto'
		FROM VAN02
		WHERE VanWbsDsc LIKE '%VENDA%'
		AND VanWbsTrnSeq > 0
		AND VanWbsSta LIKE '%ESTORNADA%'
	) Venda
	ON Canc.VanWbsDat = Venda.VanWbsDat 
	AND Canc.ValorSitef = Venda.ValorSitef 
	AND Canc.Bandeira = Venda.Bandeira
	AND Canc.Produto = Venda.Produto
	AND Canc.VanWbsPosIde = VENDA.VanWbsPosIde
	LEFT JOIN ADQ0001 C
	ON Canc.VanWbsAdqIde = C.AdqNom
	LEFT JOIN MovTrn01 Mov
	ON Canc.VanWbsDat = Mov.MovTrnDta AND Canc.ValorSitef = Mov.MovTrnVlr AND Venda.VanWbsAtz = MOV.MovTrnAutCodStr AND CONVERT(NUMERIC(18), Venda.VanWbsNsu) = Mov.MovTrnNsuMovOri
	WHERE Mov.MovTrnId IS NULL

UNION ALL

	SELECT 
	NewID() 'ConTrnId', 
	'VAN04' 'ConTrnOri',
	B.MovTrnDta 'ConTrnDta',
	B.EstCod 'ConTrnEstCod',
	B.MovTrnBan 'ConTrnBan',
	B.MovTrnTipPrd 'ConTrnTipPrd',
	Cast(B.MovTrnNsu as varchar(18)) 'ConTrnNsu',
	B.MovTrnVlr 'ConTrnVlr',
	B.MovTrnNumMov 'ConTrnAdqNumMov',
	B.MovTrnNumReg 'ConTrnAdqNumReg',
	'' 'ConTrnPosNroSerInt',
	'' 'ConTrnPosNroSer',
	B.MovTrnAutCodStr 'ConTrnNumAtzStr',
	'' 'ConTrnAdqIdeTer',
	B.MovTrnNumCar 'ConTrnNumCar',
	1 'ConTrnAdqCod',
	'' 'ConTrnSta'
	FROM VLRPAG A
	INNER JOIN MOVTRN01 B
	ON A.VlpMovTrnId = B.MovTrnId
	WHERE VLPSTSPAG = 13
GO


USE [Banese]
GO

/****** Object:  View [dbo].[VwMovTrn]    Script Date: 23/02/2024 15:31:59 ******/
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

A.MovTrnTxCobrancaId AS 'VwMovTrnTxCobrancaId'

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
		 A.MovTrnTxaAntPrv, A.MovtrnAnt, A.MovTrnVanSeq, A.MovTrnTxCobrancaId
GO


USE [Banese]
GO

/****** Object:  View [dbo].[CON0001]    Script Date: 23/02/2024 16:04:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER View [dbo].[CON0001]
As

SELECT * FROM (
/*SELECT 
NewID() ConTrnId, 
'MOVTRN01' 'ConTrnOri',
A.TrnDtaTrnCV 'ConTrnDta',
A.TrnEstCod 'ConTrnEstCod',
CASE
	WHEN A.TrnBanCV = '001' THEN 'M'
	WHEN A.TrnBanCV = '002' THEN 'V'
	WHEN A.TrnBanCV = '022' THEN 'E'
	WHEN A.TrnBanCV = '033' THEN 'H'
	WHEN A.TrnBanCV = '024' THEN 'A'
	ELSE 'M'
END 'ConTrnBan',
A.TrnTipPrdCV 'ConTrnTipPrd',
Cast(A.TrnNsuCV as varchar(18)) 'ConTrnNsu',
TrnVlrBruVenCV 'ConTrnVlr',
A.TrnNumMov 'ConTrnAdqNumMov',
A.TrnNumReg 'ConTrnAdqNumReg',
'' 'ConTrnPosNroSerInt',
'' 'ConTrnPosNroSer',
A.TrnCodAutCvStr 'ConTrnNumAtzStr',
'' 'ConTrnAdqIdeTer',
A.TrnNumCarCV 'ConTrnNumCar',
1 'ConTrnAdqCod',
'' 'ConTrnSta'
FROM Trn A
INNER JOIN TrnGlobalStatus B
ON A.TrnSts = B.TrnGlobalStatusCod
WHERE A.TrnCodTrn = 'CV' 
AND A.TrnSts <> 'OK'

UNION ALL

SELECT 
NewID() ConTrnId, 
'MOVTRN01' 'ConTrnOri',
A.TrnDtatrnAJ 'ConTrnDta',
A.TrnEstCod 'ConTrnEstCod',
CASE
	WHEN A.TrnBanAJ = '001' THEN 'M'
	WHEN A.TrnBanAJ = '002' THEN 'V'
	WHEN A.TrnBanAJ = '022' THEN 'E'
	WHEN A.TrnBanAJ = '033' THEN 'H'
	WHEN A.TrnBanAJ = '024' THEN 'A'
	ELSE 'M'
END 'ConTrnBan',
A.TrnTipPrdCV 'ConTrnTipPrd',
Cast(A.TrnNsuAJ as varchar(18)) 'ConTrnNsu',
TrnVlrBruAJ 'ConTrnVlr',
A.TrnNumMov 'ConTrnAdqNumMov',
A.TrnNumReg 'ConTrnAdqNumReg',
'' 'ConTrnPosNroSerInt',
'' 'ConTrnPosNroSer',
A.TrnCodAutCvStr 'ConTrnNumAtzStr',
'' 'ConTrnAdqIdeTer',
A.TrnNumCarOriAJ 'ConTrnNumCar',
1 'ConTrnAdqCod',
'' 'ConTrnSta'
FROM Trn A
INNER JOIN TrnGlobalStatus B
ON A.TrnSts = B.TrnGlobalStatusCod
WHERE A.TrnCodTrn = 'AJ' 
AND A.TrnSts <> 'OK'

UNION ALL
*/

SELECT 
NewID() ConTrnId, 
'VAN04' 'ConTrnOri',
B.MovTrnDta 'ConTrnDta',
B.EstCod 'ConTrnEstCod',
B.MovTrnBan 'ConTrnBan',
B.MovTrnTipPrd 'ConTrnTipPrd',
Cast(B.MovTrnNsu as varchar(18)) 'ConTrnNsu',
B.MovTrnVlr 'ConTrnVlr',
B.MovTrnNumMov 'ConTrnAdqNumMov',
B.MovTrnNumReg 'ConTrnAdqNumReg',
'' 'ConTrnPosNroSerInt',
'' 'ConTrnPosNroSer',
B.MovTrnAutCodStr 'ConTrnNumAtzStr',
'' 'ConTrnAdqIdeTer',
B.MovTrnNumCar 'ConTrnNumCar',
1 'ConTrnAdqCod',
'' 'ConTrnSta'
FROM VLRPAG A
INNER JOIN MOVTRN01 B
ON A.VlpMovTrnId = B.MovTrnId
WHERE VLPSTSPAG = 13
) Resultado
GO


ALTER TABLE VAN02 ADD VanWbsAdqStatus VARCHAR(2) NULL;
ALTER TABLE EST ADD EstVar BIT NULL;

insert into VlpStatusPag values (13, 'Bloqueado Pendente Conciliacao')

/*APENAS BANESE*/
USE Banese
GO
update ADQ0001 set AdqIndRmbRedCap = 'S', AdqRedCap = 'Global' where AdqCod = 1
/**/