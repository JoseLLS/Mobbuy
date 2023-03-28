USE [Pronto]
GO

/****** Object:  View [dbo].[Est08]    Script Date: 21/03/2022 16:52:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[Est08] as 

SELECT 
	  E.EstCod as 'VwSdEstcod',

      E.EstNomFan AS 'VwSdEstNom',

      ISNULL(Convert(Numeric(15),EC.EfeitoContratoTitular),E.EstCpfCnpj) AS 'VwSdEstcpfCnpj',

	  E.EstTip as 'VwSdEstTipo',
	  
	  CASE 
	      WHEN NOT EC.EfeitoContratoTitular IS NULL AND EC.Data_Vencimento >= GETDATE() AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'S' 
		  WHEN E.EstPermiteCessao = 0 THEN 'S' 
		  ELSE 'N' 
	  END AS 'VwSdBloqueio',

	  CASE 
	      WHEN NOT EC.EfeitoContratoTitular IS NULL AND EC.Data_Vencimento >= GETDATE() AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'Bloqueio efeito de contrato.' 
		  WHEN E.EstPermiteCessao = 0 THEN 'Estabelecimento não tem permissão para gerar cessão.' 
		  ELSE '' 
	  END AS 'VwSdMotivoBloqueio', 
	  
	  CONVERT(DECIMAL(18,2), SUM(
	                             CASE 
								     WHEN V.VlpStsPag = 1 THEN V.VLPVLRPAG 
									 ELSE 0 
								 END)) 
	  AS 'VwSdSaldoTotal',
	  
	  CONVERT(DECIMAL(18,2), SUM(
	                             CASE 
								     WHEN EC.Data_Vencimento < GETDATE() OR EC.EfeitoContratoTitular IS NULL OR EC2.EfeitoContratoSituacao in ('B','R') THEN 
									      CASE 
										      WHEN V.VlpStsPag = 1 AND V.VlpTipPrd = 'C' THEN V.VLPVLRPAG 
											  ELSE 0 
										  END 
								     ELSE 0 
								 END)) 
	  AS 'VwSdSaldoAberto',
	  
	  CONVERT(DECIMAL(18,2), CASE 
	                             WHEN EC.Data_Vencimento < GETDATE() OR EC.EfeitoContratoTitular IS NULL  OR EC2.EfeitoContratoSituacao in ('B','R') THEN ISNULL(C.EstVlrCessao, 0) 
								 ELSE 0 
							 END) 
	  AS 'VwSdSaldoReservado',
	  
	  
	  CONVERT(DECIMAL(18,2), CASE
	                             WHEN EC.Data_Vencimento < GETDATE() OR EC.EfeitoContratoTitular IS NULL 
								 OR EC2.EfeitoContratoSituacao in ('B','R') THEN SUM(
								                                                     CASE 
																						 WHEN V.VlpStsPag = 1 AND V.VlpTipPrd = 'C' THEN V.VLPVLRPAG 
																						 ELSE 0 
																					 END) - ISNULL(C.EstVlrCessao, 0) 
							     ELSE 0  
							 END) 
	  AS 'VwSdSaldoDisponivelCessao',
	  
	  EC.Data_Vencimento AS 'VwSdDtaVenc',

	  EC2.EfeitoContratoSituacao AS 'VwEfeitoContratoSituacao',

	  ROUND(M.Media,2) AS 'VwSdPrazoMedio'

	 FROM EST E with(nolock)
LEFT JOIN VLRPAG V with(nolock)
     ON E.ESTCOD = V.EstCod

LEFT JOIN Est07 C with(nolock)
      ON V.EstCod = C.EstCodCessao

LEFT JOIN (select EfeitoContratoEstCod,
                  EfeitoContratoTitular,
                  max(EfeitoContratoDtaVenc) as 'Data_Vencimento'
		   from EfeitoContrato with(nolock) where EfeitoContratoAprovado = 1 group by EfeitoContratoEstCod,EfeitoContratoTitular) EC
     ON  E.EstCod = EC.EfeitoContratoEstCod 


LEFT JOIN (SELECT EfeitoContratoEstCod,
                  EfeitoContratoTitular,
				  EfeitoContratoDtaVenc,
				  EfeitoContratoSituacao
				  FROM EfeitoContrato
				  GROUP BY EfeitoContratoEstCod, EfeitoContratoTitular, EfeitoContratoDtaVenc, EfeitoContratoSituacao) EC2
ON EC2.EfeitoContratoEstCod  = EC.EfeitoContratoEstCod   AND 
   EC2.EfeitoContratoTitular = EC.EfeitoContratoTitular AND 
   EC2.EfeitoContratoDtaVenc = EC.Data_Vencimento

LEFT JOIN Est08_Aux02 M
ON M.EstCod = E.EstCod

GROUP BY E.EstCod,
         E.EstNomFan, 
		 C.EstVlrCessao, 
		 EC.EfeitoContratoTitular, 
		 EC.Data_Vencimento, 
		 E.EstCpfCnpj,
		 E.EstPermiteCessao,
		 E.EstTip,
		 EC2.EfeitoContratoSituacao,
		 M.Media

GO


