/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.21','2.5.28',GETDATE());

/* TAREFA #23337 - LEONARDO */

USE [Pronto]
GO

/****** Object:  View [dbo].[Est08_VlrPag_Aberto_AL]    Script Date: 27/10/2023 15:10:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create View [dbo].[Est08_VlrPag_Aberto_AL] as 

SELECT 
      EstCod, 
	  VlpVlrPag,
	  VlpDtaVct,
	  VlpTipPrd
FROM VLRPAG with(nolock) where VlpStsPag = 1 and TidCod = 1

GO


/****** Object:  View [dbo].[Est08_AL]    Script Date: 27/10/2023 15:11:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 CREATE view [dbo].[Est08_AL] as 

SELECT 
	  E.EstCod                                                                                                                                  AS 'VwSdEstcod_AL',
      E.EstNomFan                                                                                                                               AS 'VwSdEstNom_AL',
      ISNULL(Convert(Numeric(15),B.EstcpfCnpj),E.EstCpfCnpj)                                                                                    AS 'VwSdEstcpfCnpj_AL',
	  E.EstTip                                                                                                                                  AS 'VwSdEstTipo_AL',
	  B.Bloqueio                                                                                                                                AS 'VwSdBloqueio_AL',
	  B.MotivoBloqueio                                                                                                                          AS 'VwSdMotivoBloqueio_AL', 
	  ISNULL(SUM(A.VlpVlrPag),0)                                                                                                                AS 'VwSdSaldoTotal_AL',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') THEN A.VlpVlrPag ELSE 0 END) ELSE 0 END                             AS 'VwSdSaldoAberto_AL', 
	  CASE WHEN B.Status = 'OK' THEN ISNULL(C.EstVlrCessao, 0) ELSE 0 END                                                                       AS 'VwSdSaldoReservado_AL',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END AS 'VwSdSaldoDisponivelCessao_AL',
	  B.DataVencimento                                                                                                                          AS 'VwSdDtaVenc_AL',
	  B.Situacao                                                                                                                                AS 'VwEfeitoContratoSituacao_AL',
	  ROUND(CASE WHEN CAST(SUM(IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) AS numeric(18,2)) = 0 THEN  0
				 WHEN SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) <= 0 THEN 0
			ELSE ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) / 
			CAST(SUM(IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) AS numeric(18,2)),0) END,2)								AS 'VwSdPrazoMedio'

FROM EST E with(nolock)

--EC BLOQUEIO
LEFT JOIN Est08_Bloqueio_EfeitoContrato B
     ON E.EstCod = B.Estcod

--VLRPAG COM STS = 1
LEFT JOIN (SELECT EstCod, 
	              VlpVlrPag,
	              VlpDtaVct,
	              VlpTipPrd  FROM Est08_VlrPag_Aberto_AL) A
     ON E.EstCod = A.EstCod

--CESSOES
LEFT JOIN Est07 C with(nolock)
     ON E.EstCod = C.EstCodCessao

GROUP BY E.EstCod,
         E.EstNomFan, 
		 E.EstCpfCnpj,
		 E.EstTip,
		 B.Bloqueio,
		 B.MotivoBloqueio,
		 B.EstcpfCnpj,
		 B.Status,
		 B.DataVencimento,
		 B.Situacao,
		 C.EstVlrCessao
GO

/* TAREFA 23420 - CARLOS */

USE EstBank

CREATE TABLE [LancamentosBoaVista] (
  [LanBoaVistaId]            DECIMAL(12) IDENTITY ( 1 , 1 )   NOT NULL,
  [LanBoaVistaDtaVen]        DATETIME    NOT NULL,
  [LanBoaVistaHraVen]        DATETIME    NOT NULL,
  [LanBoaVistaDtaCre]        DATETIME    NOT NULL,
  [LanBoaVistaNsu]           DECIMAL(18)    NOT NULL,
  [LanBoaVistaAut]           DECIMAL(14)    NOT NULL,
  [LanBoaVistaPlano]         INT    NOT NULL,
  [LanBoaVistaBan]           SMALLINT    NOT NULL,
  [LanBoaVistaProd]          CHAR(3)    NOT NULL,
  [LanBoaVistaVlrVen]        DECIMAL(17,2)    NOT NULL,
  [LanBoaVistaVlrBru]        DECIMAL(17,2)    NOT NULL,
  [LanBoaVistaCodEst]        CHAR(20)    NOT NULL,
  [LanBoaVistaVlrLiq]        DECIMAL(17,2)    NOT NULL,
  [LanBoaVistaStatus]        CHAR(2)    NOT NULL,
  [LanBoaVistaModCap]        CHAR(2)    NOT NULL,
  [LanBoaVistaParc]          SMALLINT    NOT NULL,
  [LanBoaVistaVlrTax]        DECIMAL(17,2)    NOT NULL,
  [LanBoaVistaAge]           SMALLINT    NOT NULL,
  [LanBoaVistaBanco]         SMALLINT    NOT NULL,
  [LanBoaVistaConta]         CHAR(20)    NOT NULL,
  [LanBoaVistaStatusEnviado] SMALLINT    NOT NULL,
  [LanBoaVistaJsonUpl]       VARCHAR(MAX)    NULL,
  [LanBoaVistaJsonResp]      VARCHAR(MAX)    NULL,
     PRIMARY KEY ( [LanBoaVistaId] ));

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
				WHEN M.MovTrnBan = 'E' THEN '3'
			ELSE '0'
			END 'Bandeira',
			CASE
				WHEN M.MOVTRNTIPPRD = 'D' THEN '1'
				WHEN M.MOVTRNTIPPRD = 'C' THEN '2'
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