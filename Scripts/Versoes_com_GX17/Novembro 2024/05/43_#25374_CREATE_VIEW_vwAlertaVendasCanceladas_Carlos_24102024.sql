USE [permite]
GO

/****** Object:  View [dbo].[vwAlertaVendasCanceladas]    Script Date: 24/10/2024 14:46:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW vwAlertaVendasCanceladas AS
	SELECT 
		NEWID() AS  'vwAlertaVendasCanceladasID',
		A.MovTrnDta as 'vwAlertaVendasCanceladasData', 
		A.EstCod as 'vwAlertaVendasCanceladasEC', 
		A.MovTrnVlr as 'vwAlertaVendasCanceladasVlrBru',
		A.MovTrnVlrLiqEst as 'vwAlertaVendasCanceladasVlrLiq',
		A.MovTrnNsu as 'vwAlertaVendasCanceladasNSU',
		A.MovTrnAutCod as 'vwAlertaVendasCanceladasAut',
		A.MovTrnBan as 'vwAlertaVendasCanceladasBan',
		A.MovTrnParQtd as 'vwAlertaVendasCanceladasParc'
	FROM MovTrn01 A LEFT JOIN TrnCan10 B 
	ON A.MovTrnNsuMovOri = B.TrnCan10NsuFormatado
	WHERE A.MovTrnCod = 'CC'
		AND A.AdqCod = 5
		AND B.TrnCan10Id is null
		AND A.MovTrnDta <= (getdate() - 15)
GO
