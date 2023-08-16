use pronto
go

create view ArquivoEfeitoRecusado
as
select * from (
	select b.EfeitoContratoEstCod, b.EfeitoContratoDtaVenc, sum(b.EfeitoContratoVlrRepasse) 'repasse'
	from arqdet a
	inner join EfeitoContrato b
	on a.ArbNum = b.EfeitoContratoArbNum and a.ArbLotNum = b.EfeitoContratoArbLotNum and a.ArbDetSeq = b.EfeitoContratoArbDetSeq
	where a.ArbDetCodSit not in (0, 4) and b.EfeitoContratoVlrRepasse <> 0
	group by b.EfeitoContratoEstCod, b.EfeitoContratoDtaVenc
) a inner join (
	select EstCod, VlpDtaVct, sum(VlpVlrEfeito) 'vlr_efeito'
	from VLRPAG
	group by EstCod, VlpDtaVct
) b 
on a.EfeitoContratoEstCod = b.EstCod and a.EfeitoContratoDtaVenc = b.VlpDtaVct