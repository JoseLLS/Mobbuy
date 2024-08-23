use credpag

/****** Object:  View vwTrnNaoConf   Script Date: Agosto/2024  ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW vwTrnNaoConf AS
SELECT
	NEWID() AS  'vwTrnNaoConfID',
	A.ESTPACCOD AS 'vwTrnNaoConfPacCod',
	C.VANWBSDAT AS 'vwTrnNaoConfDta',
	CONCAT(SUBSTRING(C.VANWBSHRATRN,1,2),':',SUBSTRING(C.VANWBSHRATRN,3,2),':',SUBSTRING(C.VANWBSHRATRN,5,2)) AS 'vwTrnNaoConfHra',
	A.ESTCOD AS 'vwTrnNaoConfEstCod',
	A.ESTNOMFAN AS 'vwTrnNaoConfNomFan',
	C.VANWBSADQIDE AS 'vwTrnNaoConfAdq',
	C.VANCOD AS 'vwTrnNaoConfVanCod',
	C.VANWBSSTA AS 'vwTrnNaoConfSts', 
	C.VANWBSDSC AS 'vwTrnNaoConfTip',
	B.POSCODTMRSFE AS 'vwTrnNaoConfPosIde',
	IIF(VANWBSATZ<>'NULL',VANWBSATZ,'') AS 'vwTrnNaoConfAtz',
	IIF(C.VANWBSNSU<>'NULL',C.VANWBSNSU,'') AS 'vwTrnNaoConfNsu',
	C.VANWBSNUMSER AS 'vwTrnNaoConfNroSer',
	IIF(LEN(VANWBSVLR)=1,CONCAT('00',VANWBSVLR),IIF(LEN(VANWBSVLR)=2,CONCAT('0',VANWBSVLR),VANWBSVLR)) AS 'vwTrnNaoConfVlr',
	CONCAT(D.CodigoRetornoTransacoesCod,' - ',CodigoRetornoTransacoesDsc) AS 'vwTrnNaoConfRetTrn'
FROM EST A INNER JOIN POS B
ON A.ESTCOD = B.POSESTCOD
INNER JOIN VAN02 C
ON B.POSCODTMRSFE = C.VANWBSPOSIDE
INNER JOIN CodigoRetornoTransacoes D
ON D.CodigoRetornoTransacoesCod = C.VanWbsRspCod
WHERE A.ESTSIT = 'A' AND NOT C.VANWBSSTA LIKE '%CONFIRMADA%'

GO
