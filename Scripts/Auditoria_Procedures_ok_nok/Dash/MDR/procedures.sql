use pronto
go

/*
mdr adquirente 2 procs
consolidado soma taxa gbpint cv e ps agrupado por data realizado
campo novo soma taxa prevista agrupado por data também em cv e ps previsto

analitico leitura das transacoes que deram diferenca (deve estar no status) previsto - realizado
se for negativo origem adquirente
se for positivo origem mobbuy
se for igual nem lista pq nao e pendencia


no mdr cliente, previsto - realizado se menor que 0 mobbuy, se maior que 0, comolati
*/

alter table movtrn01
add MovTrnTxaComVlrPrv numeric(12,2) null


select a.MovTrnVlr, 
a.MovTrnVlrLiqBemFac, 
a.MovTrnGbpVlrTxaInt, 
a.MovTrnTxaCom, 
Round((a.MovTrnTxaCom/100) * a.MovTrnVlr, 2) 'Previsto',
MovTrnTxaComVlrPrv
from MovTrn01 a
where a.MovTrnCod in ('CV', 'PS')

update MovTrn01 set MovTrnTxaComVlrPrv = Round((MovTrnTxaCom/100) * MovTrnVlr, 2)
where MovTrnCod in ('CV', 'PS')

GO

CREATE PROCEDURE ConcMdrAdqRealiz 
(
	@DataTrn Date,
	@ValorTrn Numeric(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(MovTrnGbpVlrTxaInt), 0)
	FROM MovTrn01
	WHERE MovTrnDta = @DataTrn
	AND MovTrnCod in ('CV', 'PS')
END

GO

CREATE PROCEDURE ConcMdrAdqPrev 
(
	@DataTrn Date,
	@ValorTrn Numeric(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(MovTrnTxaComVlrPrv), 0)
	FROM MovTrn01
	WHERE MovTrnDta = @DataTrn
	AND MovTrnCod in ('CV', 'PS')
END

GO

ALTER PROCEDURE ConcMdrCliPrev 
(
	@DataTrn Date,
	@ValorTrn Numeric(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(MovTrnTxaEstVlrPrv), 0)
	FROM MovTrn01
	WHERE MovTrnDta = @DataTrn
	AND MovTrnCod in ('CV', 'PS')
END

GO

ALTER PROCEDURE ConcMdrCliRealiz 
(
	@DataTrn Date,
	@ValorTrn Numeric(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(MovTrnBfaVlrTxaAdm), 0)
	FROM MovTrn01
	WHERE MovTrnDta = @DataTrn
	AND MovTrnCod in ('CV', 'PS')
END

GO

CREATE TABLE TabvenSegmento (
	TavNum INT,
	Segmento VARCHAR(100)
)

/*Grupo Comolatti;2;Oficina;6;PitStop;7;Varejo;12*/

INSERT INTO TabvenSegmento VALUES 
(2, 'Grupo Comolatti'),
(6, 'Oficina'),
(7, 'PitStop'),
(12, 'Varejo')



ALTER TABLE Movtrn01
ADD MovTrnTxaEstVlrPrv NUMERIC(12,2) null,
	MovTrnEstTxaAdmPrv NUMERIC(6,2) null,
	MovTrnEstTxaAntPrv NUMERIC(6,2) null,
	MovTrnEstTarCredPrv NUMERIC(6,2) null,
	MovTrnEstCusTrnPrv NUMERIC(6,2) null,
	MovTrnTxaEstCond BIT NULL 


SELECT * FROM ( 
SELECT B.EstSegmento, C.TavNum,
IIF(A.MovTrnTipPrd = 'D', 1, MovTrnParQtd) 'Parcela',
A.MovTrnBan, A.AdqCod, A.MovTrnTipPrd
FROM MovTrn01 A
INNER JOIN EST B
ON A.EstCod = B.EstCod
INNER JOIN TabvenSegmento C
ON B.EstSegmento = C.Segmento
WHERE MovTrnDta >= '20230101'
AND MovTrnCod = 'CV'
AND MovTrnTipPrd <> 'P') A
LEFT JOIN (
SELECT 
EstTaxPlaNum, 
CASE
	WHEN EstTaxBan = 'Mastercard' THEN 'M'
	WHEN EstTaxBan = 'Visa' THEN 'V'
	WHEN EstTaxBan = 'Amex' THEN 'A'
	WHEN EstTaxBan = 'Cabal' THEN 'C'
	WHEN EstTaxBan = 'Verdecard' THEN 'D'
	WHEN EstTaxBan = 'Elo' THEN 'E'
	WHEN EstTaxBan = 'Hipercard' THEN 'H'
	ELSE 'O'
END 'Bandeira',
SUBSTRING(EstTaxTip, 1, 1) 'Produto',
EstTaxPar,
EstTaxVlrAdm, 
EstTaxVlrAnt, 
EstTaxTarCred, 
EstTaxCusTrn,
EstTaxAdq
FROM TABVEN06
Where EstTaxTip <> 'PIX') B
ON A.TavNum = B.EstTaxPlaNum AND A.Parcela = B.EstTaxPar AND A.AdqCod = B.EstTaxAdq AND A.MovTrnBan = B.Bandeira AND A.MovTrnTipPrd = B.Produto
--debito e credito a vista sao parcela 1
--641069 COM JOIN
--641069 SO MOVTRN

UPDATE A
SET A.MovTrnEstTxaAdmPrv = B.EstTaxVlrAdm,
A.MovTrnEstTxaAntPrv = B.EstTaxVlrAnt,
A.MovTrnEstTarCredPrv = B.EstTaxTarCred,
A.MovTrnEstCusTrnPrv = B.EstTaxCusTrn
FROM ( 
SELECT B.EstSegmento, C.TavNum,
IIF(A.MovTrnTipPrd = 'D', 1, MovTrnParQtd) 'Parcela',
A.MovTrnBan, A.AdqCod, A.MovTrnTipPrd, A.MovTrnEstTxaAdmPrv, 
A.MovTrnEstTxaAntPrv, A.MovTrnEstTarCredPrv, A.MovTrnEstCusTrnPrv
FROM MovTrn01 A
INNER JOIN EST B
ON A.EstCod = B.EstCod
INNER JOIN TabvenSegmento C
ON B.EstSegmento = C.Segmento
WHERE MovTrnDta >= '20230101'
AND MovTrnCod = 'CV'
AND MovTrnTipPrd <> 'P') A
LEFT JOIN (
SELECT 
EstTaxPlaNum, 
CASE
	WHEN EstTaxBan = 'Mastercard' THEN 'M'
	WHEN EstTaxBan = 'Visa' THEN 'V'
	WHEN EstTaxBan = 'Amex' THEN 'A'
	WHEN EstTaxBan = 'Cabal' THEN 'C'
	WHEN EstTaxBan = 'Verdecard' THEN 'D'
	WHEN EstTaxBan = 'Elo' THEN 'E'
	WHEN EstTaxBan = 'Hipercard' THEN 'H'
	ELSE 'O'
END 'Bandeira',
SUBSTRING(EstTaxTip, 1, 1) 'Produto',
EstTaxPar,
EstTaxVlrAdm, 
EstTaxVlrAnt, 
EstTaxTarCred, 
EstTaxCusTrn,
EstTaxAdq
FROM TABVEN06
Where EstTaxTip <> 'PIX') B
ON A.TavNum = B.EstTaxPlaNum AND A.Parcela = B.EstTaxPar AND A.AdqCod = B.EstTaxAdq AND A.MovTrnBan = B.Bandeira AND A.MovTrnTipPrd = B.Produto


SELECT MovTrnId, MovTrnVlr, MovTrnVlrLiqEst, MovTrnBfaVlrTxaAdm, MovTrnBfaVlrCusTrn, MovTrnBfaVlrTxaAnt, MovTrnBfaVlrTxaFin,
ROUND((MovTrnVlr * (MovTrnEstTxaAdmPrv/100)), 2), MovTrnParQtd, MovTrnEstTxaAdmPrv,
B.TavNum 'TAXA_CADASTRO', C.TavNum 'TAXA_SEGMENTO'
FROM MovTrn01 A
INNER JOIN EST B
ON A.EstCod = B.EstCod
INNER JOIN TabvenSegmento C
ON B.EstSegmento = C.Segmento
WHERE MovTrnEstTxaAdmPrv <> 0 AND MovTrnEstTxaAntPrv = 0
ORDER BY 1

UPDATE MovTrn01
SET MovTrnTxaEstVlrPrv = ROUND((MovTrnVlr * (MovTrnEstTxaAdmPrv/100)), 2)
WHERE MovTrnEstTxaAdmPrv <> 0 AND MovTrnEstTxaAntPrv = 0