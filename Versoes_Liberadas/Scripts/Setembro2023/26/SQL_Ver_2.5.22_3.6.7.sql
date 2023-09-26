/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.7','2.5.22',GETDATE());

/* TAREFA #22300 - LEONARDO */

USE PRONTO
GO

CREATE TABLE AuxCtbTipoLan (
	AuxCtbTipoLanId INT,
	AuxCtbTipoLanDesc VARCHAR(60),
	AuxCtbTipoLanCondicao VARCHAR(255)
)

INSERT INTO AuxCtbTipoLan (AuxCtbTipoLanId, AuxCtbTipoLanDesc, AuxCtbTipoLanCondicao) VALUES 
(1, 'Vendas Vero', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ("CV","CC") and MovTrnVlr > 0'),
(2, 'Vendas PagSeguro', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 8 and MovTrnCod in ("CV","CC") and MovTrnVlr > 0'),
(3, 'Cancelamento Vendas Vero', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ("CV","CC") and MovTrnVlr < 0'),
(4, 'Cancelamento Vendas PagSeguro', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 8 and MovTrnCod in ("CV","CC") and MovTrnVlr < 0'),
(5, 'Taxa Vendas Vero', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ("CV","CC") and MovTrnVlr > 0'),
(6, 'Taxa Vendas PagSeguro', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 8 and MovTrnCod in ("CV","CC") and MovTrnVlr > 0'),
(7, 'Taxa Cancelamento Vero', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ("CV","CC") and MovTrnVlr < 0'),
(8, 'Taxa Cancelamento PagSeguro Vero', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ("CV","CC") and MovTrnVlr < 0'),
(9, 'Faturamento Clientes', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and MovTrnCod in ("CV","CC") and MovTrnVlr > 0'),
(10, 'Faturamento Cancelamento Clientes', 'from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and MovTrnCod in ("CV","CC") and MovTrnVlr < 0'),
(11, 'Cessao Dasa', 'from Pronto..cessao where  convert(date,cessaodtaliq) = @DATA_CONTABIL and cessaostatusid = 1 and CessaoEstCodBen = 1'),
(12, 'Cessao Pellegrino', 'from Pronto..cessao where  convert(date,cessaodtaliq) = @DATA_CONTABIL and cessaostatusid = 1 and CessaoEstCodBen = 9'),
(13, 'Cessao CarCentral', 'from Pronto..cessao where  convert(date,cessaodtaliq) = @DATA_CONTABIL and cessaostatusid = 1 and CessaoEstCodBen = 10'),
(14, 'Repasse Dasa', 'from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod = 1'),
(15, 'Repase Pellegrino', 'from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod = 9'),
(16, 'Repasse CarCentral', 'from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod = 10'),
(17, 'Repasse Ecs', 'from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod not in (1,9,10)')

GO


CREATE PROCEDURE Insere_AUXCTBLan (@DATA_CONTABIL DATE, @TIPO INT)
AS
--Tipo Lancamento 1 - Vendas Vero
IF @TIPO = 0 OR @TIPO = 1
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 10210023, 'TRANSITORIA ADQUIRENTE',20500064,'COMISSAO ESTABELECIMENTO A PG', '' ,'Vendas Vero', movtrndta, sum(movtrnvlr),0 ,'Pronto Vero',1 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ('CV','CC') and MovTrnVlr > 0
	group by MovTrnDta


--Tipo Lancamento 2 - Vendas PagSeguro
IF @TIPO = 0 OR @TIPO = 2
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 10210023, 'TRANSITORIA ADQUIRENTE',20500064,'COMISSAO ESTABELECIMENTO A PG', '' ,'Vendas PagSeguro', movtrndta, sum(movtrnvlr),0 ,'Pronto PagSeguro',2 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 8 and MovTrnCod in ('CV','CC') and MovTrnVlr > 0
	group by MovTrnDta


--Tipo Lancamento 3 - CAncelamento Vendas Vero
IF @TIPO = 0 OR @TIPO = 3
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',10210023,'TRANSITORIA ADQUIRENTE', '' ,'Cancelamento Vero', movtrndta, sum(movtrnvlr),0 ,'Cancelamento Vero',3 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ('CV','CC') and MovTrnVlr < 0
	group by MovTrnDta


--Tipo Lancamento 4 - CAncelamento Vendas PagSeguro
IF @TIPO = 0 OR @TIPO = 4
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',10210023,'TRANSITORIA ADQUIRENTE', '' ,'Cancelamento PagSeguro', movtrndta, sum(movtrnvlr),0 ,'Cancelamento PagSeguro',4 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 8 and MovTrnCod in ('CV','CC') and MovTrnVlr < 0
	group by MovTrnDta


--Tipo Lancamento 5 - Taxa Vendas Vero
IF @TIPO = 0 OR @TIPO = 5
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',20200004,'CONTAS A PAGAR ADQUIRENTE', '' ,'Pronto Tx Vero', movtrndta, sum(movtrnvlr)-sum(MovTrnVlrLiqBemFac),0 ,'Pronto Tx Vero',5 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ('CV','CC') and MovTrnVlr > 0
	group by MovTrnDta


--Tipo Lancamento 6 - Taxa Vendas PagSeguro
IF @TIPO = 0 OR @TIPO = 6
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',20200004,'CONTAS A PAGAR ADQUIRENTE', '' ,'Pronto Tx PagSeguro', movtrndta, sum(movtrnvlr)-sum(MovTrnVlrLiqBemFac),0 ,'Pronto Tx PagSeguro',6 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 8 and MovTrnCod in ('CV','CC') and MovTrnVlr > 0
	group by MovTrnDta


--Tipo Lancamento 7 - Taxa Cancelamento Vero
IF @TIPO = 0 OR @TIPO = 7
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',20200004,'CONTAS A PAGAR ADQUIRENTE', '' ,'Pronto Tx Cancelamento Vero', movtrndta, sum(movtrnvlr)-sum(MovTrnVlrLiqBemFac),0 ,'Pronto Tx Cancelamento Vero',7 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 5 and MovTrnCod in ('CV','CC') and MovTrnVlr < 0
	group by MovTrnDta


--Tipo Lancamento 8 - Taxa Cancelamento PagSeguro
IF @TIPO = 0 OR @TIPO = 8
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',20200004,'CONTAS A PAGAR ADQUIRENTE', '' ,'Pronto Tx Cancelamento PagSeguro', movtrndta, sum(movtrnvlr)-sum(MovTrnVlrLiqBemFac),0 ,'Pronto Tx Cancelamento PagSeguro',8 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and adqcod = 8 and MovTrnCod in ('CV','CC') and MovTrnVlr < 0
	group by MovTrnDta


--Tipo Lancamento 9 - Faturamento Clientes
IF @TIPO = 0 OR @TIPO = 9
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',20500056,'TRANSITORIA FATURAMENTO', '' ,'Faturamento Clientes', movtrndta, (sum(movtrnvlr) - sum(movtrnvlrliqest)) - (sum(movtrnvlr)-sum(MovTrnVlrLiqBemFac)) ,0 ,'Faturamento Clientes',9 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and MovTrnCod in ('CV','CC') and MovTrnVlr > 0
	group by MovTrnDta


--Tipo Lancamento 10 -  Faturamento Cancelamentos Clientes
IF @TIPO = 0 OR @TIPO = 10
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, movtrndta, 20500064, 'COMISSAO ESTABELECIMENTO A PG',20500056,'TRANSITORIA FATURAMENTO', '' ,'Faturamento Cancelamentos Clientes', movtrndta, (sum(movtrnvlr) - sum(movtrnvlrliqest)) - (sum(movtrnvlr)-sum(MovTrnVlrLiqBemFac)) ,0 ,'Faturamento Cancelamentos Clientes',10 
	from Pronto..movtrn01 where  movtrndta = @DATA_CONTABIL and MovTrnCod in ('CV','CC') and MovTrnVlr < 0
	group by MovTrnDta


--Tipo Lancamento 11 -  Cessao DASA
IF @TIPO = 0 OR @TIPO = 11
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, convert(date,cessaodtaliq), 20500064, 'COMISSAO ESTABELECIMENTO A PG',20500068,'CONTAS A PAGAR - DASA', '' ,'Cessao DASA', convert(date,cessaodtaliq), sum(cessaovalor) ,0 ,'Cessao DASA',11
	from Pronto..cessao where  convert(date,cessaodtaliq) = @DATA_CONTABIL and cessaostatusid = 1 and CessaoEstCodBen = 1
	group by convert(date,cessaodtaliq)


--Tipo Lancamento 12 -  Cessao PELLEGRINO
IF @TIPO = 0 OR @TIPO = 12
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, convert(date,cessaodtaliq), 20500064, 'COMISSAO ESTABELECIMENTO A PG',20500069,'CONTAS A PAGAR - PELLEGRINO', '' ,'Cessao PELLEGRINO', convert(date,cessaodtaliq), sum(cessaovalor) ,0 ,'Cessao PELLEGRINO',12
	from Pronto..cessao where convert(date,cessaodtaliq) = @DATA_CONTABIL and cessaostatusid = 1 and CessaoEstCodBen = 9
	group by convert(date,cessaodtaliq)


--Tipo Lancamento 13 -  Cessao CARCENTRAL
IF @TIPO = 0 OR @TIPO = 13
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, convert(date,cessaodtaliq), 20500064, 'COMISSAO ESTABELECIMENTO A PG',20500070,'CONTAS A PAGAR - CARCENTRAL', '' ,'Cessao CARCENTRAL', convert(date,cessaodtaliq), sum(cessaovalor) ,0 ,'Cessao CARCENTRAL',13
	from Pronto..cessao where convert(date,cessaodtaliq) = @DATA_CONTABIL and cessaostatusid = 1 and CessaoEstCodBen = 10
	group by convert(date,cessaodtaliq)


--Tipo Lancamento 14 -  Repasse Dasa
IF @TIPO = 0 OR @TIPO = 14
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, ArbDetDtaCre, 20500068, 'CONTAS A PAGAR - DASA',20508001,'CAIXA FINANCEIRO - TRANSITORIA', '' ,'Repasse DASA', ArbDetDtaCre, sum(ArbDetVlr) ,0 ,'Repasse DASA',14
	from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod = 1
	group by ArbDetDtaCre


--Tipo Lancamento 15 -  Repasse Pellegrino
IF @TIPO = 0 OR @TIPO = 15
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, ArbDetDtaCre, 20500069, 'CONTAS A PAGAR - PELLEGRINO',20508001,'CAIXA FINANCEIRO - TRANSITORIA', '' ,'Repasse PELLEGRINO', ArbDetDtaCre, sum(ArbDetVlr) ,0 ,'Repasse PELLEGRINO',15
	from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod = 9
	group by ArbDetDtaCre
	

--Tipo Lancamento 16 -  Repasse CarCentral
IF @TIPO = 0 OR @TIPO = 16
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, ArbDetDtaCre, 20500070, 'CONTAS A PAGAR - CARCENTRAL',20508001,'CAIXA FINANCEIRO - TRANSITORIA', '' ,'Repasse CARCENTRAL', ArbDetDtaCre, sum(ArbDetVlr) ,0 ,'Repasse CARCENTRAL',16
	from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod = 10
	group by ArbDetDtaCre


--Tipo Lancamento 17 -  Repasse ECs
IF @TIPO = 0 OR @TIPO = 17
	insert into auxiliar_contabil..auxctblan (AUXCTBLanUngId, AUXCTBLanDtaMov, AUXCTBLanCCDeb, AUXCTBLanDscCCDeb, AUXCTBLanCCCre, AUXCTBLanDscCCCre, AUXCTBLanNumOpe, AUXCTBLanHistorico, AUXCTBLanDtaOpe, AUXCTBLanValor, AUXCTBLanEstCod, AUXCTBLanNomLoja, AUXCTBTipoLan)
	select 25, ArbDetDtaCre, 20500064, 'COMISSAO ESTABELECIMENTO A PG',20508001,'CAIXA FINANCEIRO - TRANSITORIA', '' ,'Repasse ECs', ArbDetDtaCre, sum(ArbDetVlr) ,0 ,'Repasse ECs',17
	from Pronto..ARQDET where  ArbDetDtaCre = @DATA_CONTABIL and ArbDetCodSit in (0,4) and ArbDetEstCod not in (1,9,10)
	group by ArbDetDtaCre

GO