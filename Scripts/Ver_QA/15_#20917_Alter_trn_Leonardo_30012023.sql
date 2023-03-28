use banese
go


ALTER TABLE [TRN]
ADD [TrnCCAutCodVenda] VARCHAR(20)    NULL,
    [TrnCCNumParVenda] VARCHAR(5)    NULL,
    [TrnCCVlrDescontoVenda] DECIMAL(17,2)    NULL,
    [TrnCCVlrLiqVenda] DECIMAL(17,2)    NULL,
    [TrnCCVlrBrutoVenda] DECIMAL(17,2)    NULL,
    [TrnCCVlrLiq] DECIMAL(17,2)    NULL,
    [TrnCCVlrDesconto] DECIMAL(17,2)    NULL,
    [TrnCCVlrBrutoParc] DECIMAL(17,2)    NULL,
    [TrnCCVlrBruto] DECIMAL(17,2)    NULL,
    [TrnNsuHostTrm] VARCHAR(20)    NULL,
    [TrnSegAdqPay] VARCHAR(10)    NULL,
    [TrnMcc] VARCHAR(10)    NULL,
    [TrnCodFilPay] VARCHAR(20)    NULL,
    [TrnCodComPay] VARCHAR(20)    NULL,
    [TrnIdPagPay] VARCHAR(20)    NULL,
    [TrnIdAntPay] VARCHAR(20)    NULL,
    [TrnIdFinPay] VARCHAR(20)    NULL,
    [TrnContaPagamento] VARCHAR(20)    NULL,
    [TrnTrace] VARCHAR(10)    NULL,
    [TrnIdEnvelope] VARCHAR(20)    NULL