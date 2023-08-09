ALTER TABLE [POS]
ADD [PosNumMultiECPai] INT    NULL,
    [PosMultiEC] SMALLINT    NULL

    DROP INDEX [IPOS5] ON [POS]
CREATE NONCLUSTERED INDEX [UPOS2] ON [POS] (
      [PosNumSer])

INSERT INTO Pronto.dbo.PARSIS
(ParCod, ParDsc, ParTipPar, ParTamPar, ParQtdDec, ParIndSin, ParCon, ParUsuInc, ParDtiInc, ParUsuAlt, ParDtiAlt, ParFlgInt)
VALUES(N'wsmbps_url3', N'Complemento da URL do serviço Multi EC', N'CA', 256, 0, NULL, N'/InterfaceManagerMobbuy/interface/api/estrutura', N'Sistema             ', '2023-08-09 16:16:17.463', NULL, NULL, 0);