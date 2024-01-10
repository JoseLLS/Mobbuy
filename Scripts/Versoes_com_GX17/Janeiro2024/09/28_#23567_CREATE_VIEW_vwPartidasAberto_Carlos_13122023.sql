
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
