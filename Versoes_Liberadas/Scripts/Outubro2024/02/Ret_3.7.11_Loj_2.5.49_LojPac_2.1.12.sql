/* Versionamento de scripts */

INSERT INTO SQLHistorico
VALUES ('3.7.11','2.5.49',GETDATE());

/* TAREFA #24685 - CARLOS */

use pronto

CREATE TABLE [EstabCnae] (
  [EC_Cnae_EstCod]  INT    NOT NULL,
  [EC_Cnae_CNPJ]    DECIMAL(15)    NULL,
  [EC_Cnae_CodCnae] CHAR(7)    NULL,
     PRIMARY KEY ( [EC_Cnae_EstCod] ))

/* TAREFA #25041 - CARLOS */

ALTER TABLE [LancamentosBoaVista]
ADD [LanBoaVistaVlrTaxAnt] DECIMAL(17,2) NULL

USE [EstBank]
--DROP PROC CarregaLanBoaVista
GO

/****** Object:  StoredProcedure [dbo].[CarregaLanBoaVista]    Script Date: 25/09/2024 08:31:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[CarregaLanBoaVista](@DATAVENDA DATE) 
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
		LanBoaVistaVlrTaxAnt,
		LanBoaVistaAge,
		LanBoaVistaBanco,
		LanBoaVistaConta,
		LanBoaVistaStatusEnviado,
		LanBoaVistaQuebraPar)
		SELECT 
			V.VanTrnDta 'DtaVenda',
			CONCAT(SUBSTRING(cast(V.VanTrnHra as varchar(6)),1, 2),':',
					SUBSTRING(cast(V.VanTrnHra as varchar(6)),3, 2),':',
					SUBSTRING(cast(V.VanTrnHra as varchar(6)),5, 2)) 'HraVenda',
			P.VlpDtaVct 'DtaCredito',  /*Tarefa #25041 - Era M.MOVTRNDTA*/
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
			M.MovTrnBfaVlrTxaAdm 'Valor Taxa', /*Tarefa #25041 - Era M.MOVTRNVLR - M.MOVTRNVLRLIQEST*/
			M.MovTrnBfaVlrTxaFin 'Valor Taxa Antecipação',
			E.EstAge1 'Agência',
			E.EstBco1 'Banco',
			E.EstCco1 'Conta',
			'1' 'Ststus Enviado', /*Pendente*/
			'0' 'QuebraParcela'   /*Definição do Status da Parcela*/
		FROM MOVTRN01 M INNER JOIN VAN04 V
		ON M.MOVTRNID = V.VanTrnMovId
		INNER JOIN EST E
		ON M.ESTCOD = E.ESTCOD
		INNER JOIN VLRPAG P
		ON M.MovTrnId = P.VlpMovTrnId
		WHERE V.VANTRNDTA = @DATAVENDA
		and E.EstCod in (89,90,91,92,93)
END


/*
DECLARE @DATAVENDA DATE
SET @DATAVENDA  = '2023-11-22'
EXEC CARREGALANBOAVISTA @DATAVENDA
*/
GO


