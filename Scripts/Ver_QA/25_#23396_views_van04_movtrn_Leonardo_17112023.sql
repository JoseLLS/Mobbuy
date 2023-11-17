

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
	WHEN A.MovTrnCod = 'PP' THEN 'Parcelado Portador'
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


ALTER view [dbo].[VwVan] as 
select NewID() AS VwVanId,
VwVanCod			= v4.VanCod,
VwVanTrnSeq			= v4.VanTrnSeq,
VwVanTrnCod			= v4.VanTrnCod,
VwVanDta 			= v4.VanTrnDta, 
VwVanHra 			= v4.VanTrnHra,
VwVanAdqCod			= v4.VanTrnAdqCod,
VwVanAdqNome		=  d.AdqNom , 
VwVanNom		  	= v1.VanNom, 
--Do case 
VwVanTipo				= (case when v4.VanTrnCod = 'CV' then 'Vendas'
when v4.VanTrnCod 		= 'CC' then 'Cancelamento'
when v4.VanTrnCod 		= 'PP' then 'Parcelado Portador'
when v4.VanTrnCod 		= 'PS' then 'Prestação de serviço' end),
VwVanProduto 			= (case when v4.VanTrnTipPrd = 'C' and v4.VanTrnQtdPar > 1 then concat('Crédito ',v4.VanTrnQtdPar,'X') 
when v4.VanTrnTipPrd 	= 'C' then 'Crédito'
when v4.VanTrnTipPrd 	= 'D' then 'Débito'
when VanTrnTipPrd = 'V' then 'Voucher' end),
VwVanStatus 		= (case when VanTrnReqSts = 'R' then 'Recusada' 
when VanTrnCanSeq > 0 then 'Cancelada' 
when VanTrnIndDfz = 'S' then 'Desfeita'
else 'Autorizada' end),--fim
VwVanNumAtz 		= v4.VanTrnNumAtz,
VwVanSegmento 		= est.EstSegmento,
VwVanNsu			= v4.VanTrnNsu,
VwVanNsuOri			= v4.VanTrnNsuOri,
VwVanNumSer			= v4.VanTrnPosNumSer,
VwVanTrnVlr			= v4.VanTrnVlr,
VwVanPosIde			= v4.VanTrnPosIde,
VwVanPosNumSer		= V4.VanTrnPosNumSer,
VwVanTipPrd			= v4.VanTrnTipPrd,
VwVanCubFis			= v2.VanWbsCupFis, 
VwVanDtaHorExp		= v4.VanTrnDtaHorExp, 
VwVanIndDfz			= v4.VanTrnIndDfz,  
VwVanMovId			= v4.VanTrnMovId,
VwVanReqSts			= v4.VanTrnReqSts,
VwVanQtdPar			= v4.VanTrnQtdPar,
VwVanCanSeq			= V4.VanTrnCanSeq,
VwVanMovAnt			= m.MovtrnAnt, 
VwVanMovInsTimpStp	= m.MovTrnInsTimStp, 
VwVanEstTav			= est.TavNum, 
VwVanEstCod			= est.EstCod,
VwVanEstFan			= est.EstNomFan, 
VwVanEstRazSoc		= est.EstRazSoc,
concat(est.EstCod,' - ',est.EstNomFan) as 'VwVanEstabelecimento',
concat(SUBSTRING(LTRIM(STR(VanTrnHra + 1000000)), 2, 2), ':', SUBSTRING(LTRIM(STR(VanTrnHra + 1000000)), 4, 2), ':', SUBSTRING(LTRIM(STR(VanTrnHra + 1000000)), 6, 2)) AS  'VwVanHraFor',
--Do case 
VwVanCncInd			= (case when VanTrnCanSeq > 0 then 1
when VanTrnIndDfz = 'S' then 1
when VanTrnMovId > 0 then 2
else 3 end),
VwVanReqStsDsc 		= (case when v4.VanTrnReqSts = 'CC' then 'A'
when v4.VanTrnReqSts = 'PS' then 'R de serviço'
end),
VwVanCncDsc			= (case when v4.VanTrnCanSeq > 0 and v4.VanTrnIndDfz = 'S'  then 'N/A'
when v4.VanTrnMovId > 0 then 'Ok'
else 'Erro' end ),
VwVanStsInd			= (case when v4.VanTrnReqSts = 'R' then 4
when v4.VanTrnCanSeq > 0 then 3
when v4.VanTrnIndDfz = 'S' then 2
else 1 end),
VwVanStsDsc 		= (case when  v4.VanTrnReqSts = 'R' then 'Recusada' 
 when v4.VanTrnCanSeq > 0 then 'Cancelada'
 when v4.VanTrnIndDfz = 'S'then 'Desfeita'
else 'Autorizada' end )--fim
from VAN04 v4
inner join VAN01 v1
on v1.VanCod = v4.VanCod
left join 
VAN02 v2
on v2.VanWbsTrnSeq = v4.VanTrnSeq and v2.VanWbsDat = v4.VanTrnDta and v2.VanWbsNsu = v4.VanTrnNsu
inner join ADQ0001 d 
on d.AdqCod = v4.VanTrnAdqCod
inner join EST 
on Est.EstCod = v4.EstCod
left join MovTrn01 M
on m.MovTrnId  = v4.VanTrnMovId
GO


