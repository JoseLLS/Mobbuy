/* TAREFA #24370 - JOSÉ */

USE MonitorPronto;

CREATE TABLE [Configuracao] (
  [ConfigId]          SMALLINT    NOT NULL,
  [ConfigAplicacao]   NVARCHAR(40)    NULL,
  [ConfigImgLogo]     VARBINARY(MAX)    NULL,
  [ConfigImgLogo_GXI] VARCHAR(2048)    NULL,
     PRIMARY KEY ( [ConfigId] ));