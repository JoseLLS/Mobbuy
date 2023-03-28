
USE [Pronto]
GO

CREATE NONCLUSTERED INDEX [UVLRPAGVWCAN]
ON [dbo].[VLRPAG] ([VlpStspag],[VlpTrnCod])
INCLUDE ([VlpVlrPag],[EstCod],[VlpMovTrnId],[VlpBnfCod])
GO

CREATE TABLE [CancelamentoPosVenda] (
  [CancelamentoPosVendaId]      DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [MovTrnId]                    DECIMAL(18)    NOT NULL,
  [VlpNumLan]                   DECIMAL(18)    NOT NULL,
  [CancelamentoPosVendaDataInc] DATETIME    NOT NULL,
     PRIMARY KEY ( [CancelamentoPosVendaId] ))
CREATE NONCLUSTERED INDEX [ICANCELAMENTOPOSVENDA1] ON [CancelamentoPosVenda] (
      [VlpNumLan])
CREATE NONCLUSTERED INDEX [ICANCELAMENTOPOSVENDA2] ON [CancelamentoPosVenda] (
      [MovTrnId])
ALTER TABLE [CancelamentoPosVenda]
 ADD CONSTRAINT [ICANCELAMENTOPOSVENDA2] FOREIGN KEY ( [MovTrnId] ) REFERENCES [MovTrn01]([MovTrnId])
ALTER TABLE [CancelamentoPosVenda]
 ADD CONSTRAINT [ICANCELAMENTOPOSVENDA1] FOREIGN KEY ( [VlpNumLan] ) REFERENCES [VLRPAG]([VlpNumLan])

 CREATE NONCLUSTERED INDEX [UVLRPAG10] ON [VLRPAG] (
      [VlpDtaVct],
      [VlpVlrPag])

USE pronto
GO

CREATE VIEW VwCanPos AS

SELECT NewID() AS 'VwCanPosId', A.EstCod AS 'VwCanPosEstCod', A.VlpMovTrnId AS 'VwCanPosMovTrnId', A.ValorAberto AS 'VwCanPosValor'
FROM (
SELECT EstCod, VlpMovTrnId, sum(VlpVlrPag) 'ValorAberto' 
FROM VLRPAG
WHERE VlpStspag = 1 and VlpTrnCod = 'CC' and EstCod = VlpBnfCod
GROUP BY EstCod, VlpBnfCod, VlpMovTrnId) A

GO

insert into VlpStatusPag values (
10, 'Em Analise'
), (
11, 'Compensado'
)