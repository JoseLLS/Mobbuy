/*Criar indice para buscar cumpom fiscal */
CREATE NONCLUSTERED INDEX [UVAN021] ON [VAN02] (
      [VanWbsTrnSeq])

      
/*Criar view tela HVAN0100_GRID */
Create view VwVan as 
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
