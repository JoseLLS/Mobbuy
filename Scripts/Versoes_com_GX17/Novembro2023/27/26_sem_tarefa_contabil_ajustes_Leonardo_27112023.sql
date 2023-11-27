use pronto
go


	 alter table RtAnalitico add RtAnaliticoValorAjusteContabil numeric(17,2) null
	 alter table RtAnalitico add RtAnaliticoValorAjusteBanco numeric(17,2) null
	 alter table RtAnalitico add RtAnaliticoValorAjusteCessao numeric(17,2) null
	 alter table RtAnalitico add RtAnaliticoValorAjusteCessaoBnf numeric(17,2) null

	 alter table RtConsolidado add RtConsolidadoAjusteContabil numeric(17,2) null

	 alter table RtConsolidado add RtConsolidadoAjusteCessao  numeric(17,2) null
	 alter table RtConsolidado add RtConsolidadoAjusteCessaoBnf numeric(17,2) null
	 alter table RtConsolidado add RtConsolidadoAjusteBanco numeric(17,2) null

CREATE TABLE [RtAjusteCon] (
  [RtAjusteConId]      DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtAjusteConNsu]     DECIMAL(18)    NOT NULL,
  [RtAjusteConAutCod]  VARCHAR(20)    NOT NULL,
  [RtAjusteConTrnCod]  VARCHAR(10)    NOT NULL,
  [RtAjusteConValor]   DECIMAL(17,2)    NOT NULL,
  [RtAjusteConData]    DATETIME    NOT NULL,
  [RtAjusteConBan]     VARCHAR(1)    NOT NULL,
  [RtAjusteConPrd]     VARCHAR(1)    NOT NULL,
  [RtAjusteConEstCod]  INT    NOT NULL,
  [RtAjusteConDataInc] DATETIME    NOT NULL,
  [RtAjusteConGuid]    VARCHAR(255)    NOT NULL,
  [RtAjusteConUsrId]   VARCHAR(255)    NOT NULL,
     PRIMARY KEY ( [RtAjusteConId] ))




go


create view VwContabilAjustes as
select NewId() as 'VwContabilAjustesId',
RtAnaliticoEstCod 'VwContabilAjustesEstCod', 
RtAnaliticoDataTrn 'VwContabilAjustesData', 
RtAnaliticoNsu 'VwContabilAjustesNsu', 
RtAnaliticoAutcod 'VwContabilAjustesAutcod',
'Ajuste transacao' 'VwContabilAjustesProduto', 
RtAnaliticoValorAjusteContabil*-1 'VwContabilAjustesValor' 
from RtAnalitico where RtAnaliticoEstCod in 
(
select a.RtConsolidadoEstCod from (
select RtConsolidadoEstCod, (RtConsolidadoReceberValor - RtConsolidadoCustoAntValor - RtConsolidadoCessaoOriValor + RtConsolidadoCessaoBenValor - 
RtConsolidadoBancoValor + coalesce(TotalAluguelPos, 0) - RtConsolidadoAjusteContabil + RtConsolidadoAjusteCessao - RtConsolidadoAjusteCessaoBnf + RtConsolidadoAjusteBanco) 
- (RtConsolidadoAbertoValor)
'Dif'
from RtConsolidado a
left join 
(
	select sum(VlpVlrPag) 'TotalAluguelPos', EstCod 
	from VLRPAG
	Where TidCod = 2
	and VlpTrnCod = 'AL'
	group by EstCod
) b on a.RtConsolidadoEstCod = b.EstCod) a
where a.Dif = 0
) and RtAnaliticoValorAjusteContabil <> 0

union all

select NewId(), RtAnaliticoEstCod, RtAnaliticoDataTrn, RtAnaliticoNsu, RtAnaliticoAutcod, 'Ajuste Banco', RtAnaliticoValorAjusteBanco
from RtAnalitico where RtAnaliticoEstCod in 
(
select a.RtConsolidadoEstCod from (
select RtConsolidadoEstCod, (RtConsolidadoReceberValor - RtConsolidadoCustoAntValor - RtConsolidadoCessaoOriValor + RtConsolidadoCessaoBenValor - 
RtConsolidadoBancoValor + coalesce(TotalAluguelPos, 0) - RtConsolidadoAjusteContabil + RtConsolidadoAjusteCessao - RtConsolidadoAjusteCessaoBnf + RtConsolidadoAjusteBanco) 
- (RtConsolidadoAbertoValor)
'Dif'
from RtConsolidado a
left join 
(
	select sum(VlpVlrPag) 'TotalAluguelPos', EstCod 
	from VLRPAG
	Where TidCod = 2
	and VlpTrnCod = 'AL'
	group by EstCod
) b on a.RtConsolidadoEstCod = b.EstCod) a
where a.Dif = 0
) and RtAnaliticoValorAjusteBanco <> 0

union all

select NewId(), RtAnaliticoEstCod, RtAnaliticoDataTrn, RtAnaliticoNsu, RtAnaliticoAutcod, 'Ajuste Cessao', RtAnaliticoValorAjusteCessao
from RtAnalitico where RtAnaliticoEstCod in 
(
select a.RtConsolidadoEstCod from (
select RtConsolidadoEstCod, (RtConsolidadoReceberValor - RtConsolidadoCustoAntValor - RtConsolidadoCessaoOriValor + RtConsolidadoCessaoBenValor - 
RtConsolidadoBancoValor + coalesce(TotalAluguelPos, 0) - RtConsolidadoAjusteContabil + RtConsolidadoAjusteCessao - RtConsolidadoAjusteCessaoBnf + RtConsolidadoAjusteBanco) 
- (RtConsolidadoAbertoValor)
'Dif'
from RtConsolidado a
left join 
(
	select sum(VlpVlrPag) 'TotalAluguelPos', EstCod 
	from VLRPAG
	Where TidCod = 2
	and VlpTrnCod = 'AL'
	group by EstCod
) b on a.RtConsolidadoEstCod = b.EstCod) a
where a.Dif = 0
) and RtAnaliticoValorAjusteCessao <> 0

union all

select NewId(), RtAnaliticoEstCod, RtAnaliticoDataTrn, RtAnaliticoNsu, RtAnaliticoAutcod, 'Ajuste Cessao BNF', RtAnaliticoValorAjusteCessaoBnf*-1
from RtAnalitico where RtAnaliticoValorAjusteCessaoBnf <> 0 and rtanaliticoestcod not in (1,9,10,645)


go


CREATE TABLE [dbo].[ConcSaldo](
	[ConcSaldoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[ConcSaldoData] [datetime] NOT NULL,
	[ConcSaldoValor] [decimal](17, 2) NOT NULL,
	[ConcSaldoTipoLan] [int] NOT NULL,
	[ConcSaldoDataInc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ConcSaldoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO