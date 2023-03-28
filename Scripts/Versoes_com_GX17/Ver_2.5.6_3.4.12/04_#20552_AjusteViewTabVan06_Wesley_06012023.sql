USE [Pronto]
GO

/****** Object:  View [dbo].[TABVEN06]    Script Date: 06/01/2023 16:45:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[TABVEN06] as 

select 
       NewID() EstTaxGuid,
       B.ADQUIRENTE AS 'EstTaxAdq',
	   C.TavNum AS 'EstTaxPlaNum',
       C.TavDsc AS 'EstTaxPlaDesc',
	   B.MAIOR_VIGENCIA AS 'EstTaxDtaVig',
	   CASE  
			  WHEN B.BANDEIRA = 'V' then 'Visa'
			  WHEN B.BANDEIRA = 'M' then 'Mastercard'
			  WHEN B.BANDEIRA = 'H' then 'Hipercard'
			  WHEN B.BANDEIRA = 'E' then 'Elo'
			  WHEN B.BANDEIRA = 'A' then 'Amex'
			  WHEN B.BANDEIRA = 'C' then 'Cabal'
			  WHEN B.BANDEIRA = 'D' then 'Verdecard'
			  WHEN B.BANDEIRA = 'L' then 'Alelo'
			  WHEN B.BANDEIRA = 'S' then 'Sodexo'
			  WHEN B.BANDEIRA = 'P' then 'Pix'

			  ELSE 'Outros'
	   END            AS 'EstTaxBan',
	   CASE
	   WHEN A.tavdettippln = 'D' THEN 'Débito'
	   WHEN A.tavdettippln = 'A' THEN 'Crédito à Vista'
	   WHEN A.tavdettippln = 'C' THEN 'Credito Parcelado'
	   WHEN A.tavdettippln = 'P' THEN 'Pix'
	   END AS 'EstTaxTip',   
       A.tavdetqtdpar    AS 'EstTaxPar',
	   A.tavdettxaadm    AS 'EstTaxVlrAdm',
	   A.tavdettxafin    AS 'EstTaxVlrAnt',
	   CASE
	   WHEN C.TavIndParBF = 'S' THEN 'Sim'
	   ELSE 'Não'
	   END  AS 'EstTaxParAce',   
	   A.TavDetTarCre    AS 'EstTaxTarCred',
	   A.TavDetVlrCusTrn AS 'EstTaxCusTrn',
	   A.przcodprz       AS 'EstTaxDiaCond'
from TABVEN05 A
     INNER JOIN tabven06_Aux02 B
ON  A.TavNum = B.PLANO 
     INNER JOIN TABVEN C
ON A.TavNum = C.TavNum
AND A.TavVigDtaIni = B.MAIOR_VIGENCIA
AND A.TavAdqCod    = B.ADQUIRENTE
AND A.TavBanCod    = B.BANDEIRA
AND A.TavDetSeq    = B.SEQUENCIA

GO


