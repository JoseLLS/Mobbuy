/*
Missing Index Details from SQLQuery3.sql - not connected
The Query Processor estimates that implementing the following index could improve the query cost by 25.0688%.
*/


USE [Banese]
GO
CREATE NONCLUSTERED INDEX [SVLRFECH1]
ON [dbo].[VLRPAG] ([VlpDtaVct],[VlpNsu])
INCLUDE ([VlpVlrPag],[VlpVlrTaxAdm],[EstCod],[VlpVlrParBru],[VlpAutCodStr])

USE [Banese]
GO
CREATE NONCLUSTERED INDEX [SVLRFECH2]
ON [dbo].[VLRPAG] ([VlpStspag],[VlpDtaVct],[VlpDtiAlt],[VlpNsu])
INCLUDE ([VlpVlrPag],[VlpVlrTaxAdm],[EstCod],[VlpVlrParBru],[VlpAutCodStr])
GO
GO

USE [Banese]
GO
CREATE NONCLUSTERED INDEX [SVLRFECH3]
ON [dbo].[VLRPAG] ([EstCod],[VlpDtaVct],[VlpNsu])
INCLUDE ([VlpVlrPag],[VlpVlrTaxAdm],[VlpVlrParBru],[VlpAutCodStr])
GO

USE [Banese]
GO
CREATE NONCLUSTERED INDEX [SVLRFECH4]
ON [dbo].[VLRPAG] ([EstCod],[VlpStspag],[VlpDtaVct],[VlpDtiAlt],[VlpNsu])
INCLUDE ([VlpVlrPag],[VlpVlrTaxAdm],[VlpVlrParBru],[VlpAutCodStr])
GO


USE BANESE
GO


CREATE PROCEDURE FECHAMENTO_BANESE(@DATA_TRANSACAO DATE, @DATA_VENCIMENTO_FUTURO DATE, @DATA_LIQUIDACAO_FUTURO DATE)
AS

	/*
	SET @DATA_TRANSACAO = '20221130'; --data EDI today -1
	SET @DATA_VENCIMENTO_FUTURO = '20221201'; --data esta a vencer today
	SET @DATA_LIQUIDACAO_FUTURO = '20221201'; --data liquidacao futura
	*/

	DECLARE @ANO INT;
	DECLARE @MES INT;

	SET @ANO = YEAR(@DATA_TRANSACAO);
	SET @MES = MONTH(@DATA_TRANSACAO);

	DECLARE @T1 TABLE (
	EstCod INT, VlpDtaVct DATE, VlpVlrParBru NUMERIC(17,2), VlpVlrPag NUMERIC(17,2), 
	VlpNumLan NUMERIC(18,0), VlpNsu NUMERIC(12,0), EstCpfCnpj NUMERIC(15,0), EstNomFan VARCHAR(100), 
	VlpAutCodStr VARCHAR(20), VlpVlrTaxAdm NUMERIC(18,2)
	)

	/*EM ABERTO*/
	INSERT INTO @T1
	select
	a.EstCod, a.VlpDtaVct, a.VlpVlrParBru, a.VlpVlrPag, a.VlpNumLan, a.VlpNsu, c.EstCpfCnpj, c.EstNomFan, a.VlpAutCodStr, a.VlpVlrTaxAdm
	from vlrpag a 
	join movtrn01 b on a.vlpnsu = b.MovTrnNsu
	join EST c on a.EstCod = c.EstCod
	where b.movtrnnsu > 0
	and a.VlpStspag = 1
	and b.MovTrnDta <= @DATA_TRANSACAO
	and a.VlpDtaVct <= @DATA_TRANSACAO

	UNION

	/*VENCIMENTO FUTURO*/
	select
	a.EstCod, a.VlpDtaVct, a.VlpVlrParBru, a.VlpVlrPag, a.VlpNumLan, a.VlpNsu, c.EstCpfCnpj, c.EstNomFan, a.VlpAutCodStr, a.VlpVlrTaxAdm
	from vlrpag a 
	join movtrn01 b on a.vlpnsu = b.MovTrnNsu
	join EST c on a.EstCod = c.EstCod
	where b.movtrnnsu > 0
	and b.MovTrnDta <= @DATA_TRANSACAO
	and a.VlpDtaVct >= @DATA_VENCIMENTO_FUTURO

	UNION

	/*LIQUIDADO POS VENCIMENTO*/
	select
	a.EstCod, a.VlpDtaVct, a.VlpVlrParBru, a.VlpVlrPag, a.VlpNumLan, a.VlpNsu, c.EstCpfCnpj, c.EstNomFan, a.VlpAutCodStr, a.VlpVlrTaxAdm
	from vlrpag a 
	join movtrn01 b on a.vlpnsu = b.MovTrnNsu
	join EST c on a.EstCod = c.EstCod
	where b.movtrnnsu > 0
	and a.VlpStspag = 2
	and b.MovTrnDta <= @DATA_TRANSACAO
	and a.VlpDtaVct <= @DATA_TRANSACAO
	and a.VlpDtiAlt >= @DATA_LIQUIDACAO_FUTURO


	INSERT INTO RPT0002b (Rpt002Ano, Rpt002Mes, Rpt002DetPgtSeq, Rpt002DetPgtEstCod, Rpt002DetPgtDat, Rpt002DetPgtVlrBru, Rpt002DetPgtVlrLiq,
	Rpt002DetPgtVlpNumLan, Rpt002MovTrnNsu, Rpt002EstCpfCnpj, Rpt002EstNomFan, Rpt002MovTrnAut, Rpt002VlpTax
	)
	SELECT @ANO, @MES, ROW_NUMBER() OVER(ORDER BY a.EstCod ASC) AS SEQ, 
	a.EstCod, a.VlpDtaVct, a.VlpVlrParBru, a.VlpVlrPag, a.VlpNumLan, a.VlpNsu, a.EstCpfCnpj, a.EstNomFan, a.VlpAutCodStr, a.VlpVlrTaxAdm
	FROM @T1 a

GO