USE [Pronto]
GO

/****** Object:  View [dbo].[Est08_Aux03]    Script Date: 25/11/2022 10:52:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[Est08_Bloqueio_EfeitoContrato] as 

select 
      E.EstCod                                                           AS 'Estcod',
	  EC.EfeitoContratoTitular                                           AS 'EstcpfCnpj',
      CASE 
	      WHEN EC.Data_Vencimento >= GETDATE() AND NOT EC.EfeitoContratoTitular IS NULL AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'S' 
		  WHEN E.EstPermiteCessao = 0 THEN 'S' 
		  ELSE 'N' 
	  END                                                                AS 'Bloqueio',
	  CASE 
	      WHEN EC.Data_Vencimento >= GETDATE() AND NOT EC.EfeitoContratoTitular IS NULL AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'Bloqueio efeito de contrato.' 
		  WHEN E.EstPermiteCessao = 0 THEN 'Estabelecimento não tem permissão para gerar cessão.' 
		  ELSE '' 
	  END                                                                AS 'MotivoBloqueio',
	  EC2.EfeitoContratoDtaVenc                                          AS 'DataVencimento',
	  EC2.EfeitoContratoSituacao                                         AS 'Situacao',
	  CASE 
		  WHEN EC2.EfeitoContratoDtaVenc < GETDATE() OR EC.EfeitoContratoTitular IS NULL OR EC2.EfeitoContratoSituacao in ('B','R') THEN 'OK' ELSE '' 
	  END                                                                AS 'Status'
from Est E

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
ON EC2.EfeitoContratoEstCod  = EC.EfeitoContratoEstCod  AND 
   EC2.EfeitoContratoTitular = EC.EfeitoContratoTitular AND 
   EC2.EfeitoContratoDtaVenc = EC.Data_Vencimento

GO


