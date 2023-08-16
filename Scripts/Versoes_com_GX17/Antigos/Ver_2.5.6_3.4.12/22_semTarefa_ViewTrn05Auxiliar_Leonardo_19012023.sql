Create View Trn05Aux
AS

SELECT A.*,
B.MovTrnId,
B.MovTrnNsu,
B.MovTrnAutCod,
B.MovTrnAutCodStr,
B.MovTrnCod
FROM (
SELECT TrnBrsFecSeqArq,
SUBSTRING(TrnBrsOprIdeSer, 4, 1) 'TipoProduto',
CASE
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'D' AND TrnBrsOprParQtd < 2 THEN 0
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'D' AND TrnBrsOprParQtd >= 2 THEN TrnBrsOprParQtd
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'C' AND TrnBrsOprParQtd < 2 THEN 1
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'C' AND TrnBrsOprParQtd >= 2 THEN TrnBrsOprParQtd
END
'ParQtd',
CASE
	WHEN TrnBrsOprCodPrc = '002000' THEN 'D'
	WHEN TrnBrsOprCodPrc IN ('003000','003100', '003800') THEN 'C'
	WHEN TrnBrsOprCodPrc = '962000' THEN 'V'
END 'MovTrnTipPrd',
CASE
	WHEN TrnBrsOprBan = '002' THEN 'M'
	WHEN TrnBrsOprBan = '003' THEN 'V'
	WHEN TrnBrsOprBan = '004' THEN 'E'
	WHEN TrnBrsOprBan = '010' THEN 'C'
	WHEN TrnBrsOprBan = '006' THEN 'D'
END 'MovTrnBan',
CASE
	WHEN TrnBrsRdeSit in ('00','01','03','04') THEN 'VENDA'
	WHEN TrnBrsRdeSit IN ('10','13') THEN 'PRE AUT'
	WHEN TrnBrsRdeSit in ('20','21','40','41','43','44') THEN 'CANCELAMENTO'
	WHEN TrnBrsRdeSit in ('50', '54') THEN 'CANCELAMENTO ADQ'
END 'Situacao',
TrnBrsOprOriDat,
TrnBrsOprVlr,
TrnBrsOprMovNsu
FROM TRN05 
) A
LEFT JOIN MovTrn01 B
ON A.TrnBrsOprOriDat = B.MovTrnDta
AND B.MovTrnVlr = A.TrnBrsOprVlr
AND B.MovTrnParQtd = A.ParQtd
AND B.MovTrnBan = A.MovTrnBan
AND STR(B.MovTrnNsu) LIKE '%' + A.TrnBrsOprMovNsu + '%'