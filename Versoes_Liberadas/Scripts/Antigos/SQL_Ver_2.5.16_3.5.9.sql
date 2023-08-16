/* TAREFA #22482 - FELIPE */

INSERT INTO Pronto.dbo.PARSIS
(ParCod, ParDsc, ParTipPar, ParTamPar, ParQtdDec, ParIndSin, ParCon, ParUsuInc, ParDtiInc, ParUsuAlt, ParDtiAlt, ParFlgInt)
VALUES(N'HABILITAR_RETORNO', N'Habilitar retorno simulador lojista', N'CA', null, NULL, N'N', N'S', NULL, NULL, NULL, '2023-07-04 10:00:00.000', 0);

/* TAREFA #22486 - FELIPE */

ALTER TABLE [EST]
ADD [TavNumPS] SMALLINT    NULL,
    [EstUsaPS] BIT    NULL
CREATE NONCLUSTERED INDEX [IEST7] ON [EST] (
      [TavNumPS])
ALTER TABLE [EST]
 ADD CONSTRAINT [IEST7] FOREIGN KEY ( [TavNumPS] ) REFERENCES [TABVEN]([TavNum])