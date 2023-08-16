use CredPag
go

alter table movtrn01
add MovTrnTxaComVlrPrv numeric(12,2) null,
	MovTrnTxaEstVlrPrv NUMERIC(12,2) null,
	MovTrnEstTxaAdmPrv NUMERIC(6,2) null,
	MovTrnEstTxaAntPrv NUMERIC(6,2) null,
	MovTrnEstTarCredPrv NUMERIC(6,2) null,
	MovTrnEstCusTrnPrv NUMERIC(6,2) null,
	MovTrnTxaEstCond BIT NULL 
