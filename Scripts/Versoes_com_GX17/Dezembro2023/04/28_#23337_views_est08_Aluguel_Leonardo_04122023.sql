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


