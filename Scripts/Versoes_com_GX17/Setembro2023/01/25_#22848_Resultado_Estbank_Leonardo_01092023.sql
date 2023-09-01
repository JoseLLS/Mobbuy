USE [EstBank]
GO

/****** Object:  Table [dbo].[RelBaseTrib]    Script Date: 31/08/2023 12:01:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RelBaseTrib](
	[RelBaseTribId] [decimal](12, 0) IDENTITY(1,1) NOT NULL,
	[RelBaseTribDataRef] [datetime] NOT NULL,
	[RelBaseTribEstCod] [int] NOT NULL,
	[RelBaseTribSegmento] [varchar](100) NOT NULL,
	[RelBaseTribValorTrn] [decimal](17, 2) NOT NULL,
	[RelBaseTribValorAdq] [decimal](17, 2) NOT NULL,
	[RelBaseTribValorParcPort] [decimal](17, 2) NOT NULL,
	[RelBaseTribValorPS] [decimal](17, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RelBaseTribId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Rodar primeiro
USE EstBank
GO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HBTR0200_GRID', 'Rel Base Trib. - Est', 'Rel Base Trib. - Est', '', '', 0, 1, '')

--Rodar segundo
INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HBTR0200_GRID', '', 210, 'CTR_FIN', '', '/credinov/servlet/') --Alterar "/cliente/servlet/"

--Rodar terceiro
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (28, 'HBTR0200_GRID') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

--Rodar quarto
INSERT INTO sse2_grp_mod (UNG2Cod, USR2GrpId, MOD2Id)
VALUES (28, 'ADM', 'HBTR0200_GRID') 
--Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

USE ESTBANK
GO

CREATE PROCEDURE InsereRelBaseTrib (@DataIni DATE, @DataFim DATE)
AS

BEGIN

DELETE FROM RelBaseTrib WHERE RelBaseTribDataRef BETWEEN @DataIni AND @DataFim

INSERT INTO RELBASETRIB
(RelBaseTribDataRef, RelBaseTribEstCod, RelBaseTribSegmento, RelBaseTribValorTrn, RelBaseTribValorAdq, RelBaseTribValorParcPort, RelBaseTribValorPS)
SELECT
Trn.MovTrnDta,
Trn.EstCod, 
Trn.EstSegmento, 
COALESCE(Trn.ValorTrn, 0),
COALESCE(Adq.ValorLiqAdquirencia, 0),
COALESCE(ParcPort.ValorPP, 0), 
COALESCE(PS.ValorPS, 0) 
FROM
(

	SELECT A.EstCod, A.MovTrnDta, C.EstSegmento, SUM(A.MovTrnVlr) 'ValorTrn'
	FROM MovTrn01 A
	INNER JOIN EST C
	ON A.EstCod = C.EstCod
	GROUP BY A.EstCod, A.MovTrnDta, C.EstSegmento
) Trn
LEFT JOIN 
(
	SELECT A.EstCod, A.MovTrnDta, 
	SUM(CASE
		    WHEN A.MovtrnAnt = 'T' THEN (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnGbpVlrTxaAnt)
			ELSE (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnTxaAntPrv)
		END)
	'ValorPP'
	FROM MovTrn01 A
	INNER JOIN VAN02 B
	ON A.MovTrnVanSeq = B.VanWbsTrnSeq
	WHERE MovTrnCod = 'PS'
	AND B.VanWbsCupFis LIKE '%PP'
	GROUP BY A.EstCod, A.MovTrnDta
) ParcPort
ON Trn.EstCod = ParcPort.EstCod AND Trn.MovTrnDta = ParcPort.MovTrnDta
LEFT JOIN 


(
	SELECT A.EstCod, A.MovTrnDta,
	SUM(CASE
		    WHEN A.MovtrnAnt = 'T' THEN (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnGbpVlrTxaAnt)
			ELSE (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnTxaAntPrv)
		END)
	'ValorLiqAdquirencia'
	FROM MovTrn01 A
	WHERE MovTrnCod = 'CV'
	GROUP BY A.EstCod, A.MovTrnDta
) Adq
ON Trn.EstCod = Adq.EstCod AND Trn.MovTrnDta = ADQ.MovTrnDta
LEFT JOIN 
(
	SELECT B.EstCod, B.MovTrnDta, 
	SUM(CASE
		    WHEN B.MovtrnAnt = 'T' THEN ((A.TrnVlrTot - A.TrnVlrTotBru) - (B.MovTrnVlr - B.MovTrnVlrLiqBemFac - - B.MovTrnVlrLiqEst) - B.MovTrnGbpVlrTxaAnt)
			ELSE ((A.TrnVlrTot - A.TrnVlrTotBru) - (B.MovTrnVlr - B.MovTrnVlrLiqBemFac - - B.MovTrnVlrLiqEst) - B.MovTrnTxaAntPrv)
		END)
	'ValorPS' 
	FROM TRN08 A
	INNER JOIN MovTrn01 B
	ON A.TRN08VanTrnSeq = B.MovTrnVanSeq
	GROUP BY B.EstCod, B.MovTrnDta
) PS
ON Trn.EstCod = PS.EstCod AND Trn.MovTrnDta = PS.MovTrnDta
WHERE Trn.MovTrnDta BETWEEN @DataIni AND @DataFim

END

GO
