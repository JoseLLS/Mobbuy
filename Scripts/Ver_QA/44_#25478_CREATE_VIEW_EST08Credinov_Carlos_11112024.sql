USE Credinov
GO
/****** Object:  View [dbo].[Est08]    Script Date: 11/11/2024  ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Est08Credinov] as 

SELECT 
	  E.EstCod																																								   AS 'VwSdEstcod',
      E.EstNomFan																																							   AS 'VwSdEstNom',
      ISNULL(Convert(Numeric(15),B.EstcpfCnpj),E.EstCpfCnpj)																												   AS 'VwSdEstcpfCnpj',
	  E.EstTip																																								   AS 'VwSdEstTipo',
	  B.Bloqueio																																							   AS 'VwSdBloqueio',
	  B.MotivoBloqueio																																						   AS 'VwSdMotivoBloqueio', 
	  ISNULL(SUM(A.VlpVlrPag),0)																																			   AS 'VwSdSaldoTotal',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') THEN A.VlpVlrPag ELSE 0 END) ELSE 0 END															   AS 'VwSdSaldoAberto', 
	  CASE WHEN B.Status = 'OK' THEN ISNULL(C.EstVlrCessao, 0) ELSE 0 END																									   AS 'VwSdSaldoReservado',
  
	  CASE WHEN     (CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') AND A.TidCod in (1,2) THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END) > (ISNULL(SUM(A.VlpVlrPag),0)) THEN    SUM(CASE WHEN A.VlpTipPrd IN ('C','O','D') AND A.TidCod in (1,2) THEN A.VlpVlrPag - (IIF(A.VlpTipPrd = 'D', IIF(A.VlpVlrPag > 0, A.VlpVlrPag,0 ), 0))  ELSE 0 END )
		   ELSE     (CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') AND A.TidCod in (1,2) THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END) END	   AS 'VwSdSaldoDisponivelCessao',
	         
	  B.DataVencimento																																						   AS 'VwSdDtaVenc',
	  B.Situacao																																							   AS 'VwEfeitoContratoSituacao',

	  ROUND(CASE WHEN E.EstTipLimCreCessao = 1 THEN E.EstVlrLimCreCessao ELSE 
			CASE WHEN    (CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') AND A.TidCod in (1,2) THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END) > (ISNULL(SUM(A.VlpVlrPag),0)) THEN    SUM(CASE WHEN A.VlpTipPrd IN ('C','O','D') AND A.TidCod in (1,2) THEN A.VlpVlrPag - (IIF(A.VlpTipPrd = 'D', IIF(A.VlpVlrPag > 0, A.VlpVlrPag,0 ), 0))  ELSE 0 END ) ELSE     
		    (CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') AND A.TidCod in (1,2) THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END) END * (1 + (E.EstVlrLimCreCessao / 100)) END,2)	AS 'vwSdLimiteCessao',

	  ROUND(CASE WHEN CAST(SUM(IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) AS numeric(18,2)) = 0 THEN  0
				 WHEN SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) <= 0 THEN 0
			ELSE ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) / 
			CAST(SUM(IIF(A.VlpTipPrd = 'D', 0, IIF(A.VlpVlrPag < 0, 0, A.VlpVlrPag))) AS numeric(18,2)),0) END,2)															   AS 'VwSdPrazoMedio'

FROM EST E with(nolock)

--EC BLOQUEIO
LEFT JOIN Est08_Bloqueio_EfeitoContrato B
     ON E.EstCod = B.Estcod

--VLRPAG COM STS = 1
LEFT JOIN (SELECT EstCod, 
	              VlpVlrPag,
	              VlpDtaVct,
	              VlpTipPrd,
				  VlpTrnCod,
				  TidCod
				  FROM Est08_VlrPag_Aberto) A
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
		 E.EstTipLimCreCessao,
		 E.EstVlrLimCreCessao,
		 C.EstVlrCessao
GO













