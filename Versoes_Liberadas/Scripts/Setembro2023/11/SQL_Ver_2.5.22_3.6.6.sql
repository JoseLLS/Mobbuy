/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.6','2.5.22',GETDATE());

/* TAREFA #22460 - FELIPE */

CREATE TABLE [LISTAJOBS] (
  [IDJOB]        SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [JOBDescricao] VARCHAR(100)    NULL,
  [JOBChave]     VARCHAR(200)    NULL,
PRIMARY KEY ( [IDJOB] ));

INSERT INTO CredPag.dbo.PARSIS
(ParCod, ParDsc, ParTipPar, ParTamPar, ParQtdDec, ParIndSin, ParCon, ParUsuInc, ParDtiInc, ParUsuAlt, ParDtiAlt, ParFlgInt)
VALUES(N'API_JOB', N'Endereço para executar jobs', N'', 255, NULL, N'N', N'172.16.4.6', NULL, NULL, NULL, NULL, 0);

INSERT INTO CredPag.dbo.PARSIS
(ParCod, ParDsc, ParTipPar, ParTamPar, ParQtdDec, ParIndSin, ParCon, ParUsuInc, ParDtiInc, ParUsuAlt, ParDtiAlt, ParFlgInt)
VALUES(N'API_JOB_BASEURL', N'Base URL do Endereço para executar jobs', N'', 255, NULL, N'N', N'/api/21/job/', NULL, NULL, NULL, NULL, 0);

INSERT INTO CredPag.dbo.PARSIS
(ParCod, ParDsc, ParTipPar, ParTamPar, ParQtdDec, ParIndSin, ParCon, ParUsuInc, ParDtiInc, ParUsuAlt, ParDtiAlt, ParFlgInt)
VALUES(N'API_JOB_TOKEN', N'Token para executar jobs', N'  ', 255, NULL, N'N', N'l4rE1XSykeaKvVcfa86qYEgoDHWNp0V1', NULL, NULL, NULL, NULL, 0);