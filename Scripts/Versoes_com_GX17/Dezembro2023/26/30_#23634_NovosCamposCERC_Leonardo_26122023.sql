/* TAREFA #23433 - JOSÉ */

USE Pronto;

ALTER TABLE [UnidRecPag]
ADD [UnidRecPagISPBEfe] VARCHAR(10)    NULL,
    [UnidRecPagCompTitEfe] VARCHAR(20)    NULL,
    [UnidRecPagCtaTitularEfe] VARCHAR(60)    NULL,
    [UnidRecPagCtaEfe] VARCHAR(20)    NULL,
    [UnidRecPagAgeEfe] VARCHAR(20)    NULL,
    [UnidRecPagTipoCtaEfe] VARCHAR(20)    NULL,
    [UnidRecPagValorCalcEfe] DECIMAL(17,2)    NULL,
    [UnidRecPagValorEfe] DECIMAL(17,2)    NULL,
    [UnidRecPagTipoEfe] VARCHAR(5)    NULL
	
	ALTER TABLE [UnidRecPag]
ADD [UnidRecPagEfe] CHAR(1)    NULL