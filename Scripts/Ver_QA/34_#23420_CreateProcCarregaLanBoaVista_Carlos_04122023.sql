USE EstBank

GO
/****** Object:  StoredProcedure CarregaLanBoaVista   Script Date: 01/12/2023 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC CarregaLanBoaVista(@DATAVENDA DATE) 
AS
BEGIN
	INSERT INTO LANCAMENTOSBOAVISTA 
		(LanBoaVistaDtaVen,
		LanBoaVistaHraVen,
		LanBoaVistaDtaCre,
		LanBoaVistaNSU,
		LanBoaVistaAut,
		LanBoaVistaPlano,
		LanBoaVistaBan,
		LanBoaVistaProd,
		LanBoaVistaVlrVen,
		LanBoaVistaVlrBru,
		LanBoaVistaCodEst,
		LanBoaVistaVlrLiq,
		LanBoaVistaStatus,
		LanBoaVistaModCap,
		LanBoaVistaParc,
		LanBoaVistaVlrTax,
		LanBoaVistaAge,
		LanBoaVistaBanco,
		LanBoaVistaConta,
		LanBoaVistaStatusEnviado)
		SELECT 
			V.VanTrnDta 'DtaVenda',
			CONCAT(SUBSTRING(cast(V.VanTrnHra as varchar(6)),1, 2),':',
					SUBSTRING(cast(V.VanTrnHra as varchar(6)),3, 2),':',
					SUBSTRING(cast(V.VanTrnHra as varchar(6)),5, 2)) 'HraVenda',
			M.MovTrnDta 'DtaCredito',
			M.MovTrnNsu 'NSU',
			M.MovTrnAutCod 'Autorização',
			IIF(M.MovTrnParQtd = 0, 1, M.MovTrnParQtd) 'Plano',
			CASE
				WHEN M.MovTrnBan = 'V' THEN '1'
				WHEN M.MovTrnBan = 'M' THEN '2'
				WHEN M.MovTrnBan = 'E' THEN '7'
			ELSE '0'
			END 'Bandeira',
			CASE
				WHEN M.MOVTRNTIPPRD = 'D' AND M.MovTrnBan = 'V' THEN '2'
				WHEN M.MOVTRNTIPPRD = 'C' AND M.MovTrnBan = 'V' THEN '1'
				WHEN M.MOVTRNTIPPRD = 'D' AND M.MovTrnBan = 'M' THEN '343'
				WHEN M.MOVTRNTIPPRD = 'C' AND M.MovTrnBan = 'M' THEN '6'
				WHEN M.MOVTRNTIPPRD = 'D' AND M.MovTrnBan = 'E' THEN '197'
				WHEN M.MOVTRNTIPPRD = 'C' AND M.MovTrnBan = 'E' THEN '196'
			ELSE '0'
			END 'Produto',
			V.VanTrnVlr 'Valor Venda',
			M.MOVTRNVLR 'Valor Bruto',
			E.ESTCPFCNPJ 'Cod. Estabelecimento',
			M.MOVTRNVLRLIQEST 'Valor Líquido',
			'1' 'Status',
			'1' 'Modo Captura',
			IIF(M.MovTrnParQtd = 0, 1, M.MovTrnParQtd) 'Parcela',
			(M.MOVTRNVLR - M.MOVTRNVLRLIQEST) 'Valor Taxa',
			E.EstAge1 'Agência',
			E.EstBco1 'Banco',
			E.EstCco1 'Conta',
			'1' 'Ststus Enviado' /*Pendente*/
		FROM MOVTRN01 M INNER JOIN VAN04 V
		ON M.MOVTRNID = V.VanTrnMovId
		INNER JOIN EST E
		ON M.ESTCOD = E.ESTCOD
		WHERE V.VANTRNDTA = @DATAVENDA
		and E.EstCod in (89,90,91,92)
END

/*
DECLARE @DATAVENDA DATE
SET @DATAVENDA  = '2023-11-22'
EXEC CARREGALANBOAVISTA @DATAVENDA
*/
