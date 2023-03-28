/* TAREFA #20379 - WESLEY */

USE [Pronto]
GO

/****** Object:  View [dbo].[Est08]    Script Date: 13/12/2022 10:07:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[Est08] as 

SELECT 
	  E.EstCod                                                                                                                                  AS 'VwSdEstcod',
      E.EstNomFan                                                                                                                               AS 'VwSdEstNom',
      ISNULL(Convert(Numeric(15),B.EstcpfCnpj),E.EstCpfCnpj)                                                                                    AS 'VwSdEstcpfCnpj',
	  E.EstTip                                                                                                                                  AS 'VwSdEstTipo',
	  B.Bloqueio                                                                                                                                AS 'VwSdBloqueio',
	  B.MotivoBloqueio                                                                                                                          AS 'VwSdMotivoBloqueio', 
	  ISNULL(SUM(A.VlpVlrPag),0)                                                                                                                AS 'VwSdSaldoTotal',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') THEN A.VlpVlrPag ELSE 0 END) ELSE 0 END                             AS 'VwSdSaldoAberto', 
	  CASE WHEN B.Status = 'OK' THEN ISNULL(C.EstVlrCessao, 0) ELSE 0 END                                                                       AS 'VwSdSaldoReservado',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd IN ('C','O') THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END AS 'VwSdSaldoDisponivelCessao',
	  B.DataVencimento                                                                                                                          AS 'VwSdDtaVenc',
	  B.Situacao                                                                                                                                AS 'VwEfeitoContratoSituacao',
	  ROUND(CASE WHEN CAST(SUM(A.VlpVlrPag) AS numeric(18,2)) = 0 THEN  0 ELSE
				 ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * A.VlpVlrPag) / CAST(SUM(A.VlpVlrPag) AS numeric(18,2)),0) END,2)               AS 'VwSdPrazoMedio'

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

/* TAREFA #20381 - LEONARDO */

--Rodar primeiro
USE PRONTO
GO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('RtConsolidado_GRID', 'Consolidado', 'Consolidado', '', '', 0, 1, '')

--Rodar segundo
INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'RtConsolidado_GRID', '', 150, 'CTR_FIN', '', '/credinov/servlet/') --Alterar "/cliente/servlet/"

--Rodar terceiro
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'RtConsolidado_GRID') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente


--Rodar quarto
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'RtConsolidado_GRID') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente