USE [Pronto]
GO

/****** Object:  View [dbo].[Est08]    Script Date: 14/12/2022 12:18:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[Est08] as 

SELECT 
	  E.EstCod                                                                                                                           AS 'VwSdEstcod',
      E.EstNomFan                                                                                                                        AS 'VwSdEstNom',
      ISNULL(Convert(Numeric(15),B.EstcpfCnpj),E.EstCpfCnpj)                                                                             AS 'VwSdEstcpfCnpj',
	  E.EstTip                                                                                                                           AS 'VwSdEstTipo',
	  B.Bloqueio                                                                                                                         AS 'VwSdBloqueio',
	  B.MotivoBloqueio                                                                                                                   AS 'VwSdMotivoBloqueio', 
	  ISNULL(SUM(A.VlpVlrPag),0)                                                                                                         AS 'VwSdSaldoTotal',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd = 'C' THEN A.VlpVlrPag ELSE 0 END) ELSE 0 END                             AS 'VwSdSaldoAberto', 
	  CASE WHEN B.Status = 'OK' THEN ISNULL(C.EstVlrCessao, 0) ELSE 0 END                                                                AS 'VwSdSaldoReservado',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd = 'C' THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END AS 'VwSdSaldoDisponivelCessao',
	  B.DataVencimento                                                                                                                   AS 'VwSdDtaVenc',
	  B.Situacao                                                                                                                         AS 'VwEfeitoContratoSituacao',
	  ISNULL(CASE WHEN ROUND(CASE WHEN CAST(SUM(A.VlpVlrPag) AS numeric(18,2)) = 0 THEN  0 ELSE
		     ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * A.VlpVlrPag) / CAST(SUM(A.VlpVlrPag) AS numeric(18,2)),0) END,2) < 0 THEN 0
			 ELSE
			 ROUND(CASE WHEN CAST(SUM(A.VlpVlrPag) AS numeric(18,2)) = 0 THEN  0 ELSE
		     ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * A.VlpVlrPag) / CAST(SUM(A.VlpVlrPag) AS numeric(18,2)),0) END,2) END, 0)
                                                                                                                                         AS 'VwSdPrazoMedio'

FROM EST E with(nolock)

--EC BLOQUEIO
LEFT JOIN Est08_Bloqueio_EfeitoContrato B
     ON E.EstCod = B.Estcod

--VLRPAG COM STS = 1
LEFT JOIN (SELECT EstCod, 
	              VlpVlrPag,
	              VlpDtaVct,
	              VlpTipPrd  FROM Est08_VlrPag_Aberto) A
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


